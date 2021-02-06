import 'package:flutter/material.dart';
import 'package:smellsense/screens/about.screen.dart';
import 'package:smellsense/screens/main-menu.screen.dart';
import 'package:smellsense/screens/scent-selection.screen.dart';
import 'package:smellsense/screens/view-training-progress.screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print(settings);
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => MainMenuScreen(),
        );
      case '/select-scents':
        return MaterialPageRoute(
          builder: (context) => ScentSelectionScreen(),
        );
      case '/view-training-progress':
        return MaterialPageRoute(
          builder: (context) => ViewTrainingProgressScreen(),
        );
      case '/about':
        return MaterialPageRoute(
          builder: (context) => AboutScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('ERROR'),
          centerTitle: true,
        ),
      ),
    );
  }
}
