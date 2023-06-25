import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../scanner/scanner.dart';
import '/core/modules_post.dart';
import '/core/images.dart';
import '/core/validators.dart';

GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool obscureText = true;
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    formSignUpKey.currentState?.dispose();
    registreEmailController.dispose();
    registrePasswordController.dispose();
  }

  // text controllers
  final registreEmailController = TextEditingController();
  final registrePasswordController = TextEditingController();
  final registreNameController = TextEditingController();

  // update name
  dynamic signName(value) {
    final User? user = FirebaseAuth.instance.currentUser;
    user!.updateDisplayName(registreNameController.text);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formSignUpKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        isDark(context, logo['dark'], logo['light']),
                        height: 70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Hello new user',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Ready to reflect your life?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: 300,
                      height: 80,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Firstname',
                          helperText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: validateFirstName,
                        controller: registreNameController,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 300,
                      height: 80,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          helperText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: validateEmail,
                        controller: registreEmailController,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 300,
                      height: 80,
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(
                              obscureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Password',
                          helperText: '',
                        ),
                        validator: validatePassword,
                        controller: registrePasswordController,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 300,
                      height: 80,
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(
                              obscureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Repeat it',
                          helperText: '',
                        ),
                        validator: (val) => validateRepeatPassword(
                            val, registrePasswordController),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text('You already have an account?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurface)),
                    const SizedBox(height: 7),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                      label: const Text('Get back'),
                      icon: const Icon(Icons.arrow_back),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (formSignUpKey.currentState!.validate()) {
              signUpUser();
            }
          },
          label: const Text('Register'),
          icon: loading
              ? SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    strokeWidth: 2,
                  ))
              : const Icon(Icons.chevron_right_rounded),
        ));
  }

  // Sign up user
  void signUpUser() async {
    setState(() {
      loading = true;
    });
    String email = registreEmailController.text;
    String password = registrePasswordController.text;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => signName(value))
          .then((value) => sendModulesSample(value))
          .then((value) => getRefreshToken(email, password));
      if (mounted) {
        setState(() {
          loading = false;
        });
        context.go('/scanner');
      }
      debugPrint(FirebaseAuth.instance.currentUser.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You already have an account'),
          ),
        );
      } else if (e.code == 'network-request-failed') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check your internet connection.'),
          ),
        );
      } else {
        debugPrint(e.code);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Try again.'),
          ),
        );
      }
      setState(() {
        loading = false;
      });
    }
  }

  // Send modules sample to the database
  Future<void> sendModulesSample(value) async {
    uid = value.user!.uid;
    displayName = registreNameController.text;
    for (var module in modulesList) {
      postModules(module.map, module.id);
    }
  }

  // Get refresh token
  Future<void> getRefreshToken(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC4vl0DJrf2rmk6PNDv6XuQsrFR1FmIMI4'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final refreshToken = responseData['refreshToken'];
        userRefreshToken = refreshToken;
        debugPrint('Refresh token: $userRefreshToken');
      } else {
        debugPrint('Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
