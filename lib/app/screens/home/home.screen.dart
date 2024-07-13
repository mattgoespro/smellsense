import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smellsense/app/application/providers/asset.provider.dart';
import 'package:smellsense/app/application/providers/infrastructure.provider.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart'
    show TrainingScent;
import 'package:smellsense/app/shared/widgets/button.widget.dart'
    show ActionButton, ActionButtonType;

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  HomeScreenWidgetState createState() => HomeScreenWidgetState();
}

class HomeScreenWidgetState extends State<HomeScreenWidget> {
  final double _menuButtonSize = 140;
  final List<TrainingScent> scents = [];

  get assetBundle => AssetProvider();

  @override
  Widget build(BuildContext context) {
    var infrastructure = context.watch<Infrastructure>();

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: FutureBuilder(
          future: infrastructure.databaseService
              .getTrainingScentService()
              .findTrainingScentsForPeriod(
                  TrainingPeriod(startDate: DateTime.now(), sessions: [])),
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/smellsense_logo.svg",
                  width: 50,
                ),
                Text(
                  'SmellSense',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'Smell Training',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                ActionButton(
                  type: ActionButtonType.primary,
                  text: 'Train',
                  onPressed: () async => context.go(
                    '/training-session',
                  ),
                ),
                ActionButton(
                  type: ActionButtonType.primary,
                  text: 'View Progress',
                  onPressed: () => context.go('/training-progress'),
                ),
                SizedBox(
                  width: _menuButtonSize,
                  child: ActionButton(
                    type: ActionButtonType.primary,
                    text: 'About',
                    onPressed: () => context.goNamed('about'),
                  ),
                ),
                SizedBox(
                  width: _menuButtonSize,
                  child: ActionButton(
                    type: ActionButtonType.primary,
                    text: 'Help',
                    onPressed: () => context.goNamed('help'),
                  ),
                )
              ],
            );
          },
        ));
  }
}
