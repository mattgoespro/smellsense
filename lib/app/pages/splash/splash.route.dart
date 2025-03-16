import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smellsense/app/pages/splash/splash.page.dart';
import 'package:smellsense/app/pages/training_session_history/training_session_history.route.dart';
import 'package:smellsense/app/router/router_route_data.dart';

class SplashRouteData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SplashPage();
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    SharedPreferences? prefs = context.watch<SharedPreferences?>();
    bool hasScentsSelected = prefs?.getBool('hasScentsSelected') ?? false;

    if (hasScentsSelected || kDebugMode) {
      return TrainingSessionHistoryRouteData().location;
    }

    return location;
  }
}
