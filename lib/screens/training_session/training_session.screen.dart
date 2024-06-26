import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:im_stepper/stepper.dart'
    show
        DotStepper,
        Indicator,
        LineConnectorDecoration,
        FixedDotDecoration,
        IndicatorDecoration;
import 'package:smellsense/shared/widgets/app_bar.widget.dart'
    show SmellSenseAppBar;
import 'package:smellsense/shared/widgets/button.widget.dart'
    show ActionButton, ActionButtonType;

import 'training_session_entry/training_session_entry_form.widget.dart';

class TrainingSessionScreenWidget extends StatefulWidget {
  final List<TrainingSessionEntryFormWidget> children;

  const TrainingSessionScreenWidget({super.key, required this.children});

  @override
  TrainingSessionScreenWidgetState createState() =>
      TrainingSessionScreenWidgetState();
}

class TrainingSessionScreenWidgetState
    extends State<TrainingSessionScreenWidget> {
  int _activeStep = 0;
  bool _timerActive = true;

  // Group checkbox selections per scent
  final _answers = {};

  PageController pageController = PageController();

  void onTimerStatusChange(bool active) {
    setState(() {
      _timerActive = active;
    });
  }

  Widget get _stepperWidget => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: DotStepper(
          dotRadius: 7,
          spacing: 30,
          dotCount: widget.children.length,
          activeStep: _activeStep,
          indicator: Indicator.jump,
          fixedDotDecoration: const FixedDotDecoration(
            color: Colors.white,
            strokeWidth: 1,
          ),
          indicatorDecoration: const IndicatorDecoration(
            color: Colors.blue,
            strokeWidth: 1,
          ),
          tappingEnabled: _timerActive,
          onDotTapped: (tappedDotIndex) {
            pageController.animateToPage(
              tappedDotIndex,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
          },
          lineConnectorsEnabled: true,
          lineConnectorDecoration:
              const LineConnectorDecoration(strokeWidth: 0.1),
        ),
      );

  void _showDoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Are you sure you are done training?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
        actions: [
          ActionButton(
            type: ActionButtonType.secondary,
            text: 'No',
            onPressed: () => Navigator.of(context).pop(),
          ),
          ActionButton(
            type: ActionButtonType.primary,
            text: 'Yes',
            onPressed: () async {
              // DateTime sessionDate = DateTime.now();

              // TODO: Retrieve the session entries from the entry widgets
              // List<TrainingSessionEntry> ratings = ...

              // TODO: Create the session entries for the training session and save them to the database

              // Navigate straight to the training progress screen
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/training-progress', (route) => route.settings.name == "/");
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SmellSenseAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: 4,
                  onPageChanged: (pageNumber) {
                    setState(() {
                      _activeStep = pageNumber;
                    });
                  },
                  controller: pageController,
                  itemBuilder: (context, index) => widget.children[index]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ActionButton(
                  type: ActionButtonType.secondary,
                  text: 'Back',
                  onPressed: _timerActive
                      ? () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                ),
                _stepperWidget,
                if (_activeStep < widget.children.length - 1)
                  ActionButton(
                    type: ActionButtonType.primary,
                    text: 'Next',
                    onPressed: _timerActive
                        ? () {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        : null,
                  ),
                if (_activeStep == widget.children.length - 1)
                  ActionButton(
                    type: ActionButtonType.primary,
                    text: _activeStep == 3 ? 'Done' : 'Next',
                    onPressed: _timerActive
                        ? () {
                            if (_activeStep == 3) {
                              if (_answers.keys.length == 4) {
                                _showDoneDialog();
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "Train and rate all your scents before proceeding.",
                                );
                              }
                            }
                          }
                        : null,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
