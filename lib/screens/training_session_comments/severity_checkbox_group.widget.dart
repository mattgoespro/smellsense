import 'package:flutter/material.dart';
import 'package:smellsense/screens/training_session/training_session_entry/training_session_entry.model.dart';
import 'package:smellsense/screens/training_session/training_session_entry/training_session_entry_reaction.model.dart';
import 'package:smellsense/shared/widgets/app_bar.widget.dart';

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
        appBar: SmellSenseAppBar(),
        body: Column(
          children: [
            for (var severity
                in TrainingSessionEntryParosmiaReaction.getParosmiaReactions())
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: RadioListTile(
                  title: Text(
                    TrainingSessionEntryParosmiaReaction
                        .getParosmiaReactionEmoji(severity.key),
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
