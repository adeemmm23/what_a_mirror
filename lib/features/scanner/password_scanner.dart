import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

import '../../core/images.dart';
import '../../core/validators.dart';
import 'scanner.dart';

GlobalKey<FormState> formScannerPassword = GlobalKey<FormState>();

class PasswordToScanner extends StatefulWidget {
  const PasswordToScanner({super.key});

  @override
  State<PasswordToScanner> createState() => _PasswordToScannerState();
}

class _PasswordToScannerState extends State<PasswordToScanner> {
  bool obscureText = true;
  bool loading = false;

  // Password controller
  final scannerPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    scannerPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset(
            isDark(context, logo['dark'], logo['light']),
            height: 30,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'scanner',
        label: const Text('Scanner'),
        icon: loading
            ? SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  strokeWidth: 2,
                ))
            : const Icon(Icons.chevron_right_rounded),
        onPressed: () {
          if (formScannerPassword.currentState!.validate()) {
            getPassword();
          }
        },
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                isDark(
                    context, scanningLottie['dark'], scanningLottie['light']),
                height: 250,
                width: 250,
              ),
              const Text(
                'Enter your password to access the scanner',
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formScannerPassword,
                child: SizedBox(
                  width: 300,
                  height: 80,
                  child: TextFormField(
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
                    controller: scannerPasswordController,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          icon: const Icon(Icons.password_sharp),
                          title: const Text('Reset your password'),
                          content: const Text(
                              'You will receive an email to reset your password.'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  FirebaseAuth.instance.sendPasswordResetEmail(
                                      email: FirebaseAuth
                                          .instance.currentUser!.email!);
                                  context.pop();
                                },
                                child: const Text('Reset')),
                          ],
                        );
                      });
                },
                child: const Text('Reset your password'),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Get back')),
            ],
          ),
        ),
      ),
    );
  }

  // get password to scanner
  void getPassword() async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
            email: FirebaseAuth.instance.currentUser!.email!,
            password: scannerPasswordController.text),
      );
      await getRefreshToken(FirebaseAuth.instance.currentUser!.email!,
          scannerPasswordController.text);
      if (mounted) {
        setState(() {
          loading = false;
        });
        context.push('/scanner');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password. Try again.'),
          ),
        );
      } else if (e.code == 'network-request-failed') {
        debugPrint('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check your internet connection.'),
          ),
        );
      } else {
        debugPrint(e.code);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            elevation: 9,
            content: Text('Something went wrong. Try again.'),
          ),
        );
      }
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
        debugPrint('Something went wrong');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
