import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/images.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController dotController = PageController();
  
  void getStarted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('getStarted', true);

    if (dotController.page == 2) {
      if (mounted) {
        context.go('/auth');
      }
    } else {
      dotController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
      debugPrint(dotController.page.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    dotController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: Image.asset(
              isDark(context, logo['dark'], logo['light']),
              height: 40,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 400,
            child: PageView(
              controller: dotController,
              scrollDirection: Axis.horizontal,
              children: const [
                Onboarding1(),
                Onboarding2(),
                Onboarding3(),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SmoothPageIndicator(
            onDotClicked: (index) {
              dotController.animateToPage(index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut);
            },
            controller: dotController,
            count: 3,
            effect: ExpandingDotsEffect(
              dotColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              activeDotColor: Theme.of(context).colorScheme.primary,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 5,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              getStarted();
            },
            child: const Icon(Icons.arrow_forward),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              getStarted();
            },
            child: Text(
              'Skip',
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.6),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// onboarding 1
class Onboarding1 extends StatelessWidget {
  const Onboarding1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'assets/images/onboarding1.png',
          width: 210,
        ),
        const SizedBox(
          height: 20,
        ),
        AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(
              'Very customizable',
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 70),
            ),
          ],
        )
      ]),
    );
  }
}

// onboarding 2
class Onboarding2 extends StatelessWidget {
  const Onboarding2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'assets/images/onboarding2.png',
          width: 230,
        ),
        const SizedBox(
          height: 20,
        ),
        AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(
              'Fast and quick',
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 70),
            ),
          ],
        )
      ]),
    );
  }
}

// onboarding 3
class Onboarding3 extends StatelessWidget {
  const Onboarding3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/onboarding3.png', width: 210),
        const SizedBox(
          height: 20,
        ),
        AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(
              'Safe and secure',
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 70),
            ),
          ],
        )
      ]),
    );
  }
}
