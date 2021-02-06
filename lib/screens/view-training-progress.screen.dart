import 'package:flutter/material.dart';
import 'package:smellsense/screens/widgets/app-bar.dart';

class ViewTrainingProgressScreen extends StatefulWidget {
  @override
  _ViewTrainingProgressScreenState createState() =>
      _ViewTrainingProgressScreenState();
}

class _ViewTrainingProgressScreenState
    extends State<ViewTrainingProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmellSenseAppBar(),
      body: Container(),
    );
  }
}
