import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smellsense/screens/training_session/training_session_entry/training_session_entry.model.dart';
import 'package:smellsense/screens/training_session/training_session_entry/training_session_entry_reaction.model.dart';
import 'package:smellsense/shared/utils.dart';

class CommentForm extends StatefulWidget {
  final FormMode mode;
  final TrainingSessionEntry? entry;

  const CommentForm({super.key, required this.mode, this.entry});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  Widget get reactionFormField => FormField(
        builder: (FormFieldState<dynamic> field) => DropdownButtonFormField(
          items: [
            for (var reaction
                in TrainingSessionEntryParosmiaReaction.getParosmiaReactions())
              DropdownMenuItem(
                value: reaction.value,
                alignment: Alignment.center,
                child: SvgPicture.asset(reaction.value),
              ),
          ],
          decoration: const InputDecoration(
            labelText: 'How did you react after smelling this scent?',
            hintText: 'Enter your comment here',
          ),
          onChanged: (String? value) {
            field.didChange(value);
          },
        ),
      );

  Widget get reactionSeverityFormField => FormField(
        builder: (FormFieldState<dynamic> field) => DropdownButtonFormField(
          items: [
            for (var severity
                in TrainingSessionEntryParosmiaReaction.getParosmiaSeverities())
              DropdownMenuItem(
                value: severity.value,
                alignment: Alignment.center,
                child: Text(
                  TrainingSessionEntryParosmiaReaction
                      .getParosmiaSeverityDisplayValue(severity.key),
                ),
              ),
          ],
          decoration: const InputDecoration(
            labelText:
                'What was the severity of your reaction to the smell of this scent?',
            hintText: 'Enter your comment here',
          ),
          onChanged: (String? value) {
            field.didChange(value);
          },
        ),
      );

  Widget get additionalCommentsFormField => FormField(
        builder: (FormFieldState<dynamic> field) => TextFormField(
          decoration: const InputDecoration(
            labelText: 'Any additional comments?',
            hintText: 'Enter your comment here',
          ),
          maxLines: 3,
          onChanged: (String value) {
            field.didChange(value);
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          reactionFormField,
          reactionSeverityFormField,
          additionalCommentsFormField
        ],
      ),
    );
  }
}
