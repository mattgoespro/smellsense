import 'dart:io' show Platform, exit;
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:smellsense/providers/scent.provider.dart' show ScentProvider;
import 'package:smellsense/router.dart' show RouteGenerator;
import 'package:smellsense/storage/storage.dart' show SmellSenseStorage;
import 'package:flutter_screenutil/flutter_screenutil.dart' show ScreenUtil, ScreenUtilInit;

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<SmellSenseStorage>(SmellSenseStorage());
  getIt.registerSingleton<ScentProvider>(ScentProvider());
  await getIt.get<SmellSenseStorage>().initStorage();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  runApp(const SmellSenseApp());
}

class SmellSenseApp extends StatelessWidget {
  const SmellSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      builder: (context, widget) => MaterialApp(
        title: 'SmellSense',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            color: Colors.white,
          ),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.black,
              fontSize: 54,
            ),
            displayMedium: TextStyle(
              color: Colors.black,
              fontSize: 36,
            ),
            titleMedium: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w200,
            ),
            titleSmall: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: (context, widget) {
          ScreenUtil.init(
            context,
            designSize: const Size(1080, 1920),
            minTextAdapt: true,
          );
          return Platform.isIOS
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: widget!,
                )
              : widget!;
        },
      ),
    );
  }
}
