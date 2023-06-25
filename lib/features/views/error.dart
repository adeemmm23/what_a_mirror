import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_mirror/core/images.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: Image.asset(
                  isDark(context, notFound['dark'], notFound['light'])),
            ),
            const SizedBox(height: 20),
            const Text('Looks like you\'re lost'),
            const SizedBox(height: 5),
            TextButton(
                onPressed: () {
                  context.go('/');
                },
                child: const Text('Go back')),
          ],
        ),
      ),
    );
  }
}
