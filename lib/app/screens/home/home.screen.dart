import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smellsense/app/application/providers/asset.provider.dart';
import 'package:smellsense/app/application/providers/infrastructure.provider.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart'
    show TrainingScent;

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  HomeScreenWidgetState createState() => HomeScreenWidgetState();
}

class HomeScreenWidgetState extends State<HomeScreenWidget> {
  // final double _menuButtonSize = 140;
  final List<TrainingScent> scents = [];
  late final Infrastructure infrastructure;

  get assetBundle => AssetProvider();

  Future<TrainingPeriod> getActiveTrainingPeriod() async {
    return infrastructure.databaseService
        .getTrainingPeriodService()
        .getActiveTrainingPeriod();
  }

  @override
  void initState() {
    super.initState();
    infrastructure = context.read<Infrastructure>();
  }

  @override
  Widget build(BuildContext context) {
    var infrastructure = context.watch<Infrastructure>();
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.canvasColor,
      body: FutureBuilder(
        future: infrastructure.databaseService
            .getTrainingScentService()
            .findTrainingScentsForPeriod(
              TrainingPeriod(
                startDate: DateTime.now(),
                sessions: [],
              ),
            ),
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
              FloatingActionButton(
                onPressed: () => context.goNamed('training'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('Start Training', style: textTheme.labelMedium),
              ),
              FloatingActionButton(
                  onPressed: () => context.go('/training-progress'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "View Training Progress",
                    style: textTheme.labelMedium,
                  )),
              FloatingActionButton(
                  onPressed: () => context.goNamed('about'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "About",
                    style: textTheme.labelMedium,
                  )),
              FloatingActionButton(
                  onPressed: () => context.goNamed('help'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Help",
                    style: textTheme.labelMedium,
                  )),
            ],
          );
        },
      ),
    );
  }
}
