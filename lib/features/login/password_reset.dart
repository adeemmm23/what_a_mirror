import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/images.dart';
import '../../core/validators.dart';

GlobalKey<FormState> formResetKey = GlobalKey<FormState>();

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});
  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  // text controllers
  final resetController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    formResetKey.currentState?.dispose();
    resetController.dispose();
  }

  void resetUser() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: resetController.text,
      );
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent.'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
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
              key: formResetKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/shield.png', height: 120),
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          isDark(context, logo['light'], logo['light']),
                          height: 38,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Reset your password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Just enter your email!',
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
                      decoration: InputDecoration(
                        labelText: 'Email',
                        helperText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: validateEmail,
                      controller: resetController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                    ),
                    onPressed: () {
                      if (formResetKey.currentState!.validate()) {
                        resetUser();
                      }
                    },
                    child: const Text(
                      'Reset',
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
    );
  }
}
