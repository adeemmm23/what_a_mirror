import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModuleStore extends StatelessWidget {
  const ModuleStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module Store'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No new modules available'),
              ),
            );
            }
          },
          child: ListView(
            physics: const ClampingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              const SizedBox(
                height: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(width: 250, 'assets/images/store_soon.png'),
                  const SizedBox(
                    height: 30,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Comming soon',
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 70),
                      ),
                      TypewriterAnimatedText(
                        'Download new modules',
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 70),
                      ),
                      TypewriterAnimatedText(
                        'Wait for it',
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 70),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    indent: 170,
                    endIndent: 170,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Get notified when new modules are available',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You will be notified'),
                        ),
                      );
                    },
                    child: const Text('Notify me'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
