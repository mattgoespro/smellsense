import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smellsense/app/assets/generated/assets.gen.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_parosmia_reaction.module.dart';
import 'package:smellsense/app/shared/utils/utils.dart';

class CommentFormWidget extends StatefulWidget {
  final WidgetFormMode mode;

  const CommentFormWidget({
    super.key,
    required this.mode,
  });

  @override
  State<CommentFormWidget> createState() => _CommentFormWidgetState();
}

class _CommentFormWidgetState extends State<CommentFormWidget> {
  Widget get parosmiaReactionFormField => FormField(
        builder: (FormFieldState<dynamic> field) =>
            DropdownButtonFormField<int>(
          items: [
            for (TrainingSessionEntryParosmiaReaction reaction
                in TrainingSessionEntryParosmiaReaction.getReactions())
              DropdownMenuItem(
                value: reaction.reaction,
                alignment: Alignment.center,
                child: Assets.images.reactions.values
                    .elementAt(reaction.reaction)
                    .image(),
              ),
          ],
          decoration: InputDecoration(
            labelText:
                'pages.training_session.training_session_entry.comment_form.parosmia_reaction_field_label'
                    .tr(),
            hintText:
                'pages.training_session.training_session_entry.comment_form.parosmia_reaction_field_hint'
                    .tr(),
          ),
          onChanged: (int? value) {
            field.didChange(value);
          },
        ),
      );

  Widget get parosmiaReactionSeverityFormField => FormField(
        builder: (FormFieldState<dynamic> field) =>
            DropdownButtonFormField<int>(
          items: [
            for (TrainingSessionEntryParosmiaSeverity severity
                in TrainingSessionEntryParosmiaSeverity.getSeverities())
              DropdownMenuItem(
                value: severity.severity,
                alignment: Alignment.center,
                child: Text(
                  "screens.training_session.training_session_entry.comment_form.parosmia_reaction.${severity.name}"
                      .tr(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
          decoration: InputDecoration(
            labelText:
                'pages.training_session.training_session_entry.comment_form.parosmia_reaction_severity_field_label'
                    .tr(),
            hintText:
                'pages.training_session.training_session_entry.comment_form.parosmia_reaction_severity_field_hint'
                    .tr(),
          ),
          onChanged: (int? value) {
            field.didChange(value);
          },
        ),
      );

  Widget get additionalCommentsFormField => FormField(
        builder: (FormFieldState<dynamic> field) => TextFormField(
          decoration: InputDecoration(
            labelText:
                'pages.training_session.training_session_entry.comment_form.additional_comments_field_label'
                    .tr(),
            hintText:
                'pages.training_session.training_session_entry.comment_form.additional_comments_field_hint'
                    .tr(),
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
          parosmiaReactionFormField,
          parosmiaReactionSeverityFormField,
          additionalCommentsFormField
        ],
      ),
    );
  }
}
