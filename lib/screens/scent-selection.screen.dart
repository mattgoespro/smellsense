import 'package:flutter/material.dart';
import 'package:smellsense/screens/widgets/app-bar.dart';

class ScentSelectionScreen extends StatefulWidget {
  @override
  _ScentSelectionScreenState createState() => _ScentSelectionScreenState();
}

class _ScentSelectionScreenState extends State<ScentSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmellSenseAppBar(),
      body: Container(),
    );
  }
}
