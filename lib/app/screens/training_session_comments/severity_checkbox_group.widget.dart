import 'package:flutter/material.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_reaction.module.dart';

class TrainingSessionSeverityCheckboxGroupWidget extends StatefulWidget {
  final TrainingSessionEntry entry;

  const TrainingSessionSeverityCheckboxGroupWidget(
      {super.key, required this.entry});

  @override
  TrainingSessionSeverityCheckboxGroupWidgetState createState() =>
      TrainingSessionSeverityCheckboxGroupWidgetState();
}

class TrainingSessionSeverityCheckboxGroupWidgetState
    extends State<TrainingSessionSeverityCheckboxGroupWidget> {
  TrainingSessionEntryParosmiaSeverity _selectedSeverity =
      TrainingSessionEntryParosmiaSeverity.none;

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            for (var severity
                in TrainingSessionEntryParosmia.getParosmiaReactions())
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: RadioListTile(
                  title: Text(
                    TrainingSessionEntryParosmia.getParosmiaReactionEmoji(
                        severity.key),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  groupValue: _selectedSeverity,
                  value: severity.value,
                  onChanged: (dynamic value) {
                    setState(() => _selectedSeverity = value);
                  },
                ),
              ),
          ],
        ),
      );
}
