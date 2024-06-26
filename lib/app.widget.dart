import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smellsense/router.dart';

class SmellSenseTraining extends StatelessWidget {
  const SmellSenseTraining({super.key});

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
