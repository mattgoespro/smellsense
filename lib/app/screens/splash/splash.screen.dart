import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final List<Widget> introSequence = [
      TweenAnimationBuilder<double>(
        tween: Tween(
          begin: 0,
          end: 1,
        ),
        duration: const Duration(
          seconds: 8,
        ),
        curve: Curves.decelerate,
        onEnd: () => setState(
          () => _currentStep++,
        ),
        builder: (context, value, child) {
          return Opacity(
            opacity: value < 0.6 ? value : 1 - value,
            child: Transform.translate(
              offset: Offset.fromDirection(
                0,
                (value - 1) * 200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/smellsense_logo.svg",
                    width: 200,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Smell",
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: "Sense",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      TweenAnimationBuilder<double>(
        tween: Tween(
          begin: 0,
          end: 1,
        ),
        duration: const Duration(
          seconds: 8,
        ),
        curve: Curves.easeInToLinear,
        onEnd: () => context.go("/"),
        builder: (context, value, child) {
          return Opacity(
            opacity: value < 0.6 ? value : 1 - value,
            child: Transform.translate(
              offset: Offset.fromDirection(
                0,
                value * 200,
              ),
              child: Text(
                "Let's start by selecting your training scents.",
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      )
    ];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      body: Center(child: introSequence[_currentStep]),
    );
  }
}
