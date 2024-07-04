import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smellsense/app/providers/infrastructure.provider.dart';
import 'package:smellsense/app/screens/training_session/training_session_entry/rating_form/form_rating.widget.dart';
import 'package:smellsense/app/screens/training_session/training_session_entry/rating_form/form_timer.widget.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent_display.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry.module.dart';

class TrainingSessionEntryRatingFormWidget extends StatefulWidget {
  static const timerDuration = 15;
  final TrainingScent scent;

  const TrainingSessionEntryRatingFormWidget({super.key, required this.scent});

  @override
  TrainingSessionEntryRatingFormWidgetState createState() =>
      TrainingSessionEntryRatingFormWidgetState();

  static TrainingSessionEntryRatingFormWidgetState of(BuildContext context) =>
      context.findAncestorStateOfType<
          TrainingSessionEntryRatingFormWidgetState>()!;
}

class TrainingSessionEntryRatingFormWidgetState
    extends State<TrainingSessionEntryRatingFormWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final Map<TrainingScentName, TrainingSessionEntry> _entries = {};

  bool busy = false;
  String? currentEncouragement;

  @override
  bool get wantKeepAlive => true;

  void updateEntry(TrainingSessionEntry entry) {
    _entries[widget.scent.name] = entry;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var infrastructure = context.read<Infrastructure>();

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            Image(
              image: infrastructure.getAssetProvider().getImage(
                    TrainingScentDisplay.getScent(
                      widget.scent.name.scentName,
                    ).displayImage,
                  ),
            ),
            TrainingSessionEntryRatingFormTimerWidget(
              time: TrainingSessionEntryRatingFormWidget.timerDuration,
              onStartFn: () {
                setState(() {
                  busy = true;
                  currentEncouragement =
                      TrainingSessionEncouragements.getNextEncouragement();
                });
              },
              onCompleteFn: () {
                setState(() {
                  busy = false;
                  currentEncouragement = null;
                });
              },
              replaceDoneTimerWidget:
                  TrainingSessionEntryRatingFormRatingWidget(
                      scent: widget.scent),
            ),
          ],
        ),
      ),
    );
  }
}
