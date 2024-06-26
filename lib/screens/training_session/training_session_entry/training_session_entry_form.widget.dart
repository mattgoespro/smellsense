import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smellsense/screens/training_session/training_session.model.dart';
import 'package:smellsense/screens/training_session/training_session_entry/training_session_entry.model.dart';
import 'package:smellsense/screens/training_session/training_session_entry/training_session_timer.widget.dart';
import 'package:smellsense/shared/widgets/fade.widget.dart' show FadeAnimation;

class TrainingSessionEntryFormWidget extends StatefulWidget {
  static const timerDuration = 15;

  const TrainingSessionEntryFormWidget({super.key});

  @override
  TrainingSessionEntryFormWidgetState createState() =>
      TrainingSessionEntryFormWidgetState();
}

class TrainingSessionEntryFormWidgetState
    extends State<TrainingSessionEntryFormWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TrainingSessionEntryRating? _rating;

  bool busy = false;
  String? currentEncouragement;

  Widget get formWidget => Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Center(
          child: TimerWidget(
            time: TrainingSessionEntryFormWidget.timerDuration,
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
            replaceDoneTimerWidget: FadeAnimation(
              reverse: false,
              child: busy
                  ? FadeAnimation(
                      reverse: false,
                      child: Text(currentEncouragement ?? ""),
                    )
                  : RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: TrainingSessionRatings.getRatings().length,
                      itemSize: 40,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = TrainingSessionRatings.getRating(rating);
                        });
                      },
                    ),
            ),
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SizedBox(
        width: double.infinity,
        child: Center(
          child: formWidget,
        ));
  }
}
