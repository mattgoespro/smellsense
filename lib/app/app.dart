import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smellsense/app/router.dart';
import 'package:smellsense/app/shared/widgets/app_bar.widget.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  bool _isFirstLaunch = true;

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.toString());
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }

    setState(() {
      _isFirstLaunch = isFirstLaunch;
    });
  }

  @override
  void initState() async {
    super.initState();
    await _checkFirstLaunch();
  }

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
            fontSizeResolver: (fontSize, instance) {
              if (instance.screenWidth > 1080) {
                return fontSize * 1.5;
              }

              return fontSize as double;
            },
          );

          if (_isFirstLaunch) {
            Navigator.pushNamed(context, '/scent-selection');
          }

          return Scaffold(
            appBar: SmellSenseAppBar(),
            body: widget!,
          );
        },
      ),
    );
  }
}
