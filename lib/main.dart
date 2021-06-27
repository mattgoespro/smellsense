import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:smellsense/providers/scent.provider.dart';
import 'package:smellsense/router.dart';
import 'package:smellsense/shared/widgets/ad-state.dart';
import 'package:smellsense/storage/storage.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<SmellSenseStorage>(SmellSenseStorage());
  getIt.registerSingleton<ScentProvider>(ScentProvider());
  await getIt.get<SmellSenseStorage>().initStorage();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);

  await setup();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => SmellSenseApp(),
    ),
  );
}

class SmellSenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'SmellSense',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.white,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
