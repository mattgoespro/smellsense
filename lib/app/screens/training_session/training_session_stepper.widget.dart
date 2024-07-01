import 'package:flutter/material.dart';
import 'package:smellsense/app/screens/training_session/training_session_entry/form/form.widget.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';

class TrainingSessionEntryFormStepper extends StatefulWidget {
  final List<TrainingScent> scents;

  const TrainingSessionEntryFormStepper({super.key, required this.scents});

  @override
  State<TrainingSessionEntryFormStepper> createState() =>
      _TrainingSessionEntryFormStepperState();
}

class _TrainingSessionEntryFormStepperState
    extends State<TrainingSessionEntryFormStepper> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      type: StepperType.vertical,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: widget.scents.map((scent) {
        return Step(
          title: Text(scent.name.toString()),
          content: TrainingSessionEntryFormWidget(
            scent: scent,
          ),
        );
      }).toList(),
    );
  }
}
