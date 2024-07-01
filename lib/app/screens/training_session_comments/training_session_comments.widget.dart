import 'package:flutter/material.dart';
import 'package:smellsense/app/screens/training_session_comments/comment_form.widget.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry.module.dart';
import 'package:smellsense/app/shared/utils.dart';
import 'package:smellsense/app/shared/widgets/app_bar.widget.dart';

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
            ...widget.entries.map(
              (entry) => CommentForm(
                mode: widget.mode,
                entry: entry,
              ),
            ),
          ],
        ),
      );
}
