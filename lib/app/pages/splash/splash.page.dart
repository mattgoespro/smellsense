import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smellsense/app/assets/generated/assets.gen.dart';
import 'package:smellsense/app/pages/scent_selection/scent_selection.route.dart';
import 'package:smellsense/app/router/router_route_data.dart';
import 'package:smellsense/app/shared/theme/theme.dart';
import 'package:smellsense/app/shared/widgets/animators/fade.animator.widget.dart';
import 'package:smellsense/app/shared/widgets/animators/scale.animator.widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme.of(context);

    final List<Widget> introSequence = [
      ScaleAnimate(
        initialScale: 1,
        finalScale: 1.5,
        duration: const Duration(seconds: 5),
        child: FadeAnimate(
          onComplete: () {
            setState(() {
              _currentStep++;
            });
          },
          fadeInDuration: const Duration(seconds: 3),
          idleDuration: const Duration(milliseconds: 500),
          fadeOutDuration: const Duration(milliseconds: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.branding.logo.image(
                width: 60,
                height: 60,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Smell",
                      style: theme.textTheme.titleSmall,
                    ),
                    TextSpan(
                      text: "Sense",
                      style: theme.textTheme.titleSmall!.copyWith(
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
      ),
      FadeAnimate(
        onComplete: () {
          ScentSelectionRouteData().go(context);
        },
        fadeInDuration: const Duration(milliseconds: 2000),
        idleDuration: const Duration(seconds: 2),
        fadeOutDuration: const Duration(milliseconds: 700),
        child: Center(
          heightFactor: 1,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              "pages.splash.intro_start_scent_selection_title".tr(),
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      body: Center(
        child: introSequence[_currentStep],
      ),
    );
  }
}
