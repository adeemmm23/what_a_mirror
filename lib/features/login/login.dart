import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/modules_post.dart';
import '/core/images.dart';
import '/core/validators.dart';

GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureText = true;
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    formLoginKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Login user
  void signInUser() async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (mounted) {
        GoRouter.of(context).go('/home');
        setState(() {
          uid = FirebaseAuth.instance.currentUser!.uid;
          loading = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('There is no user with that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formLoginKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        isDark(context, logo['dark'], logo['light']),
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'What a Mirror',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Welcome back!',
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          helperText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: validateEmail,
                        controller: emailController,
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
                        controller: passwordController,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                      ),
                      onPressed: () {
                        context.push('/auth/login/password_reset');
                      },
                      child: const Text(
                        'Reset your password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
            if (formLoginKey.currentState!.validate()) {
              signInUser();
            }
          },
          label: const Text('Login'),
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
}
