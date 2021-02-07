import 'package:flutter/material.dart';
import 'package:smellsense/model/scent.dart';
import 'package:smellsense/screens/about/about.dart';
import 'package:smellsense/screens/help/help.screen.dart';
import 'package:smellsense/screens/main-menu/main-menu.screen.dart';
import 'package:smellsense/screens/scent-selection/scent-selection.screen.dart';
import 'package:smellsense/screens/training/training.screen.dart';
import 'package:smellsense/screens/training-progress/training-progress.screen.dart';

class ScentSelectionRouteArguments {
  List<Scent> scentSelections;
  Function onScentSelectionChanged;

  ScentSelectionRouteArguments(
    this.scentSelections,
    this.onScentSelectionChanged,
  );
}

class SmellTrainingRouteArguments {
  List<Scent> scents;

  SmellTrainingRouteArguments(this.scents);
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => MainMenuScreen(),
        );
      case '/training':
        var scentArgs = args as SmellTrainingRouteArguments;
        return MaterialPageRoute(
          builder: (context) => SmellTrainingScreen(scentArgs.scents),
        );
      case '/select-scents':
        var scentArgs = args as ScentSelectionRouteArguments;
        return MaterialPageRoute(
          builder: (context) => ScentSelectionScreen(
            scentArgs.scentSelections,
            scentArgs.onScentSelectionChanged,
          ),
        );
      case '/training-progress':
        return MaterialPageRoute(
          builder: (context) => ViewTrainingProgressScreen(),
        );
      case '/about':
        return MaterialPageRoute(
          builder: (context) => AboutScreen(),
        );
      case '/help':
        return MaterialPageRoute(
          builder: (context) => HelpScreen(),
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
