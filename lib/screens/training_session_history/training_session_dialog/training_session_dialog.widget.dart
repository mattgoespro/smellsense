import 'package:flutter/material.dart';
import 'package:smellsense/screens/training_session/training_session.model.dart';
import 'package:smellsense/screens/training_session/training_session_entry/training_session_entry.model.dart';
import 'package:smellsense/screens/training_session_comments/comment_form.widget.dart';
import 'package:smellsense/shared/utils.dart';

class TrainingSessionDialogContentWidget extends StatelessWidget {
  final TrainingSession sessionEntry;

  const TrainingSessionDialogContentWidget(this.sessionEntry, {super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            for (TrainingSessionEntry entry in sessionEntry.entries)
              CommentForm(mode: FormMode.fill, entry: entry)
          ],
        ),
      );

  static show(BuildContext context, TrainingSession session) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding: const EdgeInsets.all(10),
          title: const Column(
            children: [
              Center(
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              )
            ],
          ),
          contentPadding: EdgeInsets.zero,
          children: [
            Center(
              child: Text(
                'Date: ${session.date}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            TrainingSessionDialogContentWidget(session)
          ],
        );
      },
    );
  }

  String _formatEntryComment(String? comment) {
    return (comment != null && comment.trim().isNotEmpty)
        ? '- None -'
        : comment!;
  }
}
