import 'package:flutter/material.dart';
import 'package:smellsense/model/scent.dart' show Scent;
import 'package:smellsense/screens/about/about.screen.dart' show AboutScreen;
import 'package:smellsense/screens/help/help.screen.dart' show HelpScreen;
import 'package:smellsense/screens/main_menu/main_menu.screen.dart' show MainMenuScreen;
import 'package:smellsense/screens/scent_selection/scent_selection.screen.dart' show ScentSelectionScreen;
import 'package:smellsense/screens/training/training.screen.dart' show SmellTrainingScreen;
import 'package:smellsense/screens/training_progress/training_progress.screen.dart' show ViewTrainingProgressScreen;

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
          builder: (context) => const MainMenuScreen(),
        );
      case '/training':
        var scentArgs = args as SmellTrainingRouteArguments;
        return MaterialPageRoute(
          builder: (context) => SmellTrainingScreen(
              Key(scentArgs.scents.join()), scentArgs.scents),
        );
      case '/select-scents':
        var scentArgs = args as ScentSelectionRouteArguments;
        return MaterialPageRoute(
          builder: (context) => ScentSelectionScreen(
            const Key("select-scents"),
            scentArgs.scentSelections,
            scentArgs.onScentSelectionChanged,
          ),
        );
      case '/training-progress':
        return MaterialPageRoute(
          builder: (context) => const ViewTrainingProgressScreen(),
        );
      case '/about':
        return MaterialPageRoute(
          builder: (context) => const AboutScreen(),
        );
      case '/help':
        return MaterialPageRoute(
          builder: (context) => const HelpScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
          centerTitle: true,
        ),
      ),
    );
  }
}
