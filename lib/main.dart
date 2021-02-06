import 'package:flutter/material.dart';
import 'package:smellsense/router.dart';

void main() {
  runApp(SmellSenseApp());
}

class SmellSenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmellSense',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.white,
      )),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
