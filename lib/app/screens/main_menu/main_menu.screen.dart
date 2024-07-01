import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:smellsense/app/providers/asset.provider.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart'
    show TrainingScent;
import 'package:smellsense/app/shared/widgets/button.widget.dart'
    show ActionButton, ActionButtonType;

class MainMenuScreenWidget extends StatefulWidget {
  const MainMenuScreenWidget({super.key});

  @override
  MainMenuScreenWidgetState createState() => MainMenuScreenWidgetState();
}

class MainMenuScreenWidgetState extends State<MainMenuScreenWidget> {
  final double _menuButtonSize = 140;
  final List<TrainingScent> scents = [];

  late List<Widget> menuButtons = [
    SizedBox(
      width: _menuButtonSize,
      child: ActionButton(
        type: ActionButtonType.primary,
        text: 'Train',
        onPressed: () async => Navigator.of(context).pushNamed(
          '/training',
        ),
      ),
    ),
    SizedBox(
      width: _menuButtonSize,
      child: ActionButton(
        type: ActionButtonType.primary,
        text: 'View Progress',
        onPressed: () => Navigator.of(context).pushNamed('/training-progress'),
      ),
    ),
    // TODO: Move to Settings panel
    // SizedBox(
    //   width: _menuButtonSize,
    //   child: ActionButton(
    //     type: ActionButtonType.primary,
    //     text: 'Select Scents',
    //     onPressed: () => Navigator.of(context).pushNamed(
    //       '/select-scents',
    //       arguments: ScentSelectionRouteArguments(
    //         _scentSelections,
    //         _onScentSelectionChanged,
    //       ),
    //     ),
    //   ),
    // ),
    SizedBox(
      width: _menuButtonSize,
      child: ActionButton(
        type: ActionButtonType.primary,
        text: 'About',
        onPressed: () => Navigator.of(context).pushNamed('/about'),
      ),
    ),
    SizedBox(
      width: _menuButtonSize,
      child: ActionButton(
        type: ActionButtonType.primary,
        text: 'Help',
        onPressed: () => Navigator.of(context).pushNamed('/help'),
      ),
    )
  ];

  get assetBundle => AssetProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/smellsense_logo.svg",
                          width: 50,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Smell',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              TextSpan(
                                text: 'Sense',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .merge(
                                      const TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Smell Training',
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Column(
                      children: [...menuButtons],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
