import 'dart:io' show exit;

import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:provider/provider.dart' show MultiProvider, Provider;
import 'package:smellsense/app/app.dart';
import 'package:smellsense/app/providers/infrastructure.provider.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => Infrastructure(),
        ),
        Provider(
          create: (context) => DateTime.now(),
        )
      ],
      child: const App(),
    ),
  );
}
