import 'package:flutter/material.dart';
import 'package:smellsense/screens/scent_selection/scent_selection_checkbox_group.widget.dart';
import 'package:smellsense/shared/widgets/app_bar.widget.dart'
    show SmellSenseAppBar;
import 'package:smellsense/shared/widgets/button.widget.dart'
    show ActionButton, ActionButtonType;

class SmellSenseScentSelectionScreenWidget extends StatefulWidget {
  static int maxSelectionCount = 4;

  const SmellSenseScentSelectionScreenWidget({super.key});

  @override
  SmellSenseScentSelectionScreenWidgetState createState() =>
      SmellSenseScentSelectionScreenWidgetState();
}

class SmellSenseScentSelectionScreenWidgetState
    extends State<SmellSenseScentSelectionScreenWidget> {
  Set<String> selectedScents = {};

  isSelectionComplete() =>
      selectedScents.length ==
      ScentSelectionCheckboxGroupWidget.maxSelectionCount;

  storeScentSelections() {
    // Store selected scents in shared preferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmellSenseAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Center(
              child: Text(
                'Select your training scents',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w100,
                  fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ScentSelectionCheckboxGroupWidget(
              onSelectionChangeFn: (Set<String> scents) {
                setState(() {
                  selectedScents = scents;
                });
              },
            ),
          ),
          const Divider(
            color: Colors.blueGrey,
            indent: 30,
            endIndent: 30,
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 40,
              ),
              child: SizedBox(
                child: ActionButton(
                  type: ActionButtonType.primary,
                  text: 'Next',
                  onPressed: selectedScents.length ==
                          SmellSenseScentSelectionScreenWidget.maxSelectionCount
                      ? () {
                          Navigator.of(context).pop();
                        }
                      : null,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
