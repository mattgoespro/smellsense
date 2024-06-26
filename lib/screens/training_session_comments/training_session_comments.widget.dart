import 'package:flutter/material.dart';
import 'package:smellsense/screens/training_session/training_session_entry/training_session_entry.model.dart';
import 'package:smellsense/screens/training_session_comments/comment_form.widget.dart';
import 'package:smellsense/shared/utils.dart';
import 'package:smellsense/shared/widgets/app_bar.widget.dart';

class TrainingSessionRatingCommentsWidget extends StatefulWidget {
  final FormMode mode;
  final List<TrainingSessionEntry> entries;

  const TrainingSessionRatingCommentsWidget(
      {super.key, required this.mode, required this.entries});

  @override
  TrainingSessionRatingCommentsWidgetState createState() =>
      TrainingSessionRatingCommentsWidgetState();
}

class TrainingSessionRatingCommentsWidgetState
    extends State<TrainingSessionRatingCommentsWidget> {
  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: SmellSenseAppBar(),
        body: Column(
          children: [
            for (TrainingSessionEntry entry in widget.entries)
              Center(
                child: CommentForm(mode: widget.mode, entry: entry),
              )
          ],
        ),
      );
}
