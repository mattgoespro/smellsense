import 'package:flutter/material.dart';
import 'package:smellsense/app/providers/router.provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return router;
  }
}
