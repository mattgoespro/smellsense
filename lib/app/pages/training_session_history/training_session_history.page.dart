import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smellsense/app/application/providers/infrastructure.provider.dart';
import 'package:smellsense/app/pages/training_session_history/training_session_history_chart/training_session_history_chart.widget.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/theme/theme.dart';
import 'package:smellsense/app/shared/utils/logger.dart';
import 'package:smellsense/app/shared/widgets/loader.widget.dart';

class TrainingSessionHistoryPage extends StatefulWidget {
  const TrainingSessionHistoryPage({super.key});

  @override
  TrainingSessionHistoryPageState createState() =>
      TrainingSessionHistoryPageState();
}

class TrainingSessionHistoryPageState
    extends State<TrainingSessionHistoryPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: Create chart from training sessions

    MaterialTheme theme = MaterialTheme.of(context);
    Infrastructure infrastructure = Infrastructure.of(context);

    return Scaffold(
      body: FutureBuilder(
          future: infrastructure.databaseService.getTrainingPeriods(),
          builder: (context, AsyncSnapshot<List<TrainingPeriod>> snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'pages.training_session_history.title'.tr(),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
                TrainingSessionHistoryChartWidget(
                  periods: snapshot.data ?? [],
                ),
              ],
            );
          }),
    );
  }
}
