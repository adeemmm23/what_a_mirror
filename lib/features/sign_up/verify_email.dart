import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/images.dart';



class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/shield.png', height: 150),
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          isDark(context, logo['light'], logo['light']),
                          height: 45,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Only one step left!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Just verify your email',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 15,
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
      ); 
  }
}
