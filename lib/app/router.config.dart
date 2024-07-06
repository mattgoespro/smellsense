import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smellsense/app/screens/help/help.screen.dart';
import 'package:smellsense/app/screens/home/home.screen.dart';
import 'package:smellsense/app/screens/scent_selection/scent_selection.screen.dart';
import 'package:smellsense/app/screens/training_session/training_session.screen.dart';
import 'package:smellsense/app/screens/training_session_history/training_session_history.screen.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';

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

Future<bool> _checkFirstLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }

  if (kDebugMode) {
    print(prefs.toString());
    print('\nFirst launch: $isFirstLaunch');
  }

  return isFirstLaunch;
}

// GoRouter configuration
final routerConfig = GoRouter(
  // initialLocation: '/',
  onException: (context, state, router) => MaterialPage(
    child: Scaffold(
      appBar: AppBar(
        title: const Text('ERROR'),
        centerTitle: true,
      ),
    ),
  ),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => FutureBuilder(
        future: _checkFirstLaunch(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            case ConnectionState.done:
              {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }

                var isFirstLaunch = snapshot.data!;

                if (isFirstLaunch) {
                  return const ScentSelectionScreenWidget();
                }

                return const HomeScreenWidget();
              }
            case ConnectionState.none:
              {
                return const Center(
                  child: Text(
                    "Error: No connection state.",
                  ),
                );
              }
          }
        },
      ),
    ),
    GoRoute(
      path: "/training-session",
      builder: (context, state) {
        try {
          print(
            "State: ${state.toString()}",
          );
          List<TrainingScent> scents = parseScentsFromUri(state.uri);

          return TrainingSessionScreenWidget(scents: scents);
        } catch (e) {
          return Center(
            child: Text(e.toString()),
          );
        }
      },
    ),
    GoRoute(
      path: "/help",
      builder: (context, state) => const HelpScreenWidget(),
    ),
    GoRoute(
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
);
