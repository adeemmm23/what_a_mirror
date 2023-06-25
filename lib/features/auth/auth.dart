import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/images.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Column(
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    isDark(context, logo['dark'], logo['light']),
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                  TypewriterAnimatedText(
                    'A Mirror..',
                    cursor: '',
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 70),
                  ),
                  TypewriterAnimatedText(
                    'and Smart?',
                    cursor: '',
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 70),
                  ),
                  TypewriterAnimatedText(
                    'What a Mirror!',
                    cursor: '',
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 70),
                  ),
                ]),
                
                const SizedBox(height: 20),
                FilledButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 47)),
                    ),
                    onPressed: () {
                      context.go('/auth/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(height: 7),
                TextButton(
                    onPressed: () {
                      context.go('/auth/register');
                    },
                    child: const Text('Register')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
