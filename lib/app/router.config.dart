import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smellsense/app/screens/help/help.screen.dart';
import 'package:smellsense/app/screens/home/home.screen.dart';
import 'package:smellsense/app/screens/scent_selection/scent_selection.screen.dart';
import 'package:smellsense/app/screens/splash/splash.screen.dart';
import 'package:smellsense/app/screens/training_session/training_session.screen.dart';
import 'package:smellsense/app/screens/training_session_history/training_session_history.screen.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';
import 'package:smellsense/app/shared/widgets/fade.widget.dart';

List<TrainingScent> parseScentsFromUri(Uri uri) {
  print(uri);
  String? scentsQueryParam = uri.queryParameters['scents'];

  if (scentsQueryParam == null) {
    throw GoException("Error: No scents resolved from URL path: ${uri.path}.");
  }

  List<String> scents = scentsQueryParam.split(',');

  if (scents.length < TrainingScent.maxTrainingScents) {
    throw GoException(
        "Error: Not enough scents resolved from URL path: ${uri.path}.\nExpected ${TrainingScent.maxTrainingScents} scents, but got ${scents.length}.");
  }

  return scents
      .map<TrainingScent>((scentName) =>
          TrainingScent(name: TrainingScentName.fromString(scentName)))
      .toList();
}

// GoRouter configuration
final routerConfig = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: SplashScreenWidget(),
        );
      },
    ),
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: HomeScreenWidget(),
        );
      },
      redirect: (context, state) async {
        final prefs = await SharedPreferences.getInstance();
        final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

        if (isFirstLaunch && state.fullPath != '/scent-selection') {
          return '/scent-selection';
        }

        return null;
      },
    ),
    GoRoute(
      path: '/scent-selection',
      name: 'scent-selection',
      pageBuilder: (context, state) {
        return MaterialPage(
          child: FutureProvider<SharedPreferences?>(
            create: (context) {
              return SharedPreferences.getInstance();
            },
            initialData: null,
            child: const FadeAnimation(
              scale: 0.5,
              duration: 5000,
              easing: Curves.easeInOut,
              child: ScentSelectionScreenWidget(),
            ),
          ),
        );
      },
    ),
    GoRoute(
      name: "training-session",
      path: "/training-session",
      pageBuilder: (context, state) {
        try {
          print(
            "State: ${state.toString()}",
          );
          List<TrainingScent> scents = parseScentsFromUri(state.uri);

          return MaterialPage(
              child: TrainingSessionScreenWidget(scents: scents));
        } catch (e) {
          return MaterialPage(
            child: Text(e.toString()),
          );
        }
      },
    ),
    GoRoute(
      name: "help",
      path: "/help",
      builder: (context, state) => const HelpScreenWidget(),
    ),
    GoRoute(
      name: "training-session-history",
      path: "/training-session-history",
      builder: (context, state) => const TrainingSessionHistoryScreenWidget(),
      routes: [
        ShellRoute(
          builder: (
            BuildContext context,
            GoRouterState state,
            Widget child,
          ) {
            // TODO: Implement dialog for session date selection
            return Scaffold(
              body: Stack(
                children: [const Dialog(), child],
              ),
            );
          },
          routes: [
            GoRoute(
              path: ":sessionDate",
              builder: (
                BuildContext context,
                GoRouterState state,
              ) {
                String? sessionDate = state.pathParameters['sessionDate'];

                if (sessionDate == null) {
                  return Center(
                    child: Text(
                        "Error: No session date resolved from URL path: ${state.uri.path}."),
                  );
                }

                return const TrainingSessionHistoryScreenWidget();
              },
            )
          ],
        )
      ],
    ),
  ],
  onException: (context, state, router) => MaterialPage(
    child: Scaffold(
      appBar: AppBar(
        title: const Text('ERROR'),
        centerTitle: true,
      ),
    ),
  ),
);
