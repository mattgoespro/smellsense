import 'package:flutter/material.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent_display.module.dart';

class ScentSelectionCheckboxGroupWidget extends StatefulWidget {
  static const maxSelectionCount = 4;

  final void Function(Set<String>) onSelectionChangeFn;

  const ScentSelectionCheckboxGroupWidget(
      {super.key, required this.onSelectionChangeFn});

  @override
  ScentSelectionCheckboxGroupWidgetState createState() =>
      ScentSelectionCheckboxGroupWidgetState();
}

class ScentSelectionCheckboxGroupWidgetState
    extends State<ScentSelectionCheckboxGroupWidget> {
  final Set<String> selectedScents = {};

  @override
  Widget build(BuildContext context) => ListView(
        scrollDirection: Axis.vertical,
        children: [
          for (TrainingScentDisplay scent in TrainingScentDisplay.getScents())
            CheckboxListTile(
              title: Text(
                scent.displayName,
                style: TextStyle(
                  color: scent.displayColor,
                ),
              ),
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  if (selectedScents.length <
                      ScentSelectionCheckboxGroupWidget.maxSelectionCount) {
                    selectedScents.add(scent.displayName);
                    widget.onSelectionChangeFn(selectedScents);
                    return;
                  }

                  selectedScents.remove(scent.displayName);
                  widget.onSelectionChangeFn(selectedScents);
                });
              },
              value: selectedScents.contains(scent.displayName),
              controlAffinity: ListTileControlAffinity.leading,
            ),
        ],
      );
}
