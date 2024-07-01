import 'package:flutter/material.dart';
import 'package:smellsense/app/screens/training_session/training_session_stepper.widget.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';
import 'package:smellsense/app/shared/widgets/app_bar.widget.dart'
    show SmellSenseAppBar;

class TrainingSessionScreenWidget extends StatefulWidget {
  const TrainingSessionScreenWidget({super.key});

  @override
  TrainingSessionScreenWidgetState createState() =>
      TrainingSessionScreenWidgetState();
}

class TrainingSessionScreenWidgetState
    extends State<TrainingSessionScreenWidget> {
  List<TrainingScent> scents = [];

  @override
  void initState() {
    super.initState();
    // TODO: Retrieve scent list from database and pass it to the TrainingSessionScreenWidget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmellSenseAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: TrainingSessionEntryFormStepper(
          scents: scents,
        ),
      ),
    );
  }
}

// ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: const Text(
//                                     'Are you sure you have finished your training session?'),
//                                 action: SnackBarAction(
//                                   label: 'Yes',
//                                   onPressed: () {
//                                     // DateTime sessionDate = DateTime.now();

//                                     // TODO: Retrieve the session entries from the entry widgets
//                                     // List<TrainingSessionEntry> ratings = ...

//                                     // TODO: Create the session entries for the training session and save them to the database

//                                     // Navigate straight to the training progress screen
//                                     Navigator.of(context)
//                                         .pushNamedAndRemoveUntil(
//                                             '/training-progress',
//                                             (route) =>
//                                                 route.settings.name == "/");
//                                   },
//                                 ),
//                               ),
//                             );
