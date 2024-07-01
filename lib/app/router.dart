import 'package:flutter/material.dart';
import 'package:smellsense/app/screens/about/about.screen.dart'
    show AboutScreenWidget;
import 'package:smellsense/app/screens/help/help.screen.dart'
    show HelpScreenWidget;
import 'package:smellsense/app/screens/main_menu/main_menu.screen.dart'
    show MainMenuScreenWidget;
import 'package:smellsense/app/screens/scent_selection/scent_selection.screen.dart'
    show SmellSenseScentSelectionScreenWidget;
import 'package:smellsense/app/screens/training_session/training_session.screen.dart'
    show TrainingSessionScreenWidget;
import 'package:smellsense/app/screens/training_session_history/training_session_history.screen.dart'
    show TrainingSessionHistoryScreenWidget;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const MainMenuScreenWidget(),
        );
      case '/training':
        return MaterialPageRoute(
          builder: (context) => const TrainingSessionScreenWidget(),
        );
      case '/select-scents':
        return MaterialPageRoute(
          builder: (context) => const SmellSenseScentSelectionScreenWidget(),
        );
      case '/training-progress':
        return MaterialPageRoute(
          builder: (context) => const TrainingSessionHistoryScreenWidget(),
        );
      case '/about':
        return MaterialPageRoute(
          builder: (context) => const AboutScreenWidget(),
        );
      case '/help':
        return MaterialPageRoute(
          builder: (context) => const HelpScreenWidget(),
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
