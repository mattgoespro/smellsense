import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:smellsense/model/scent.dart' show Scent;
import 'package:smellsense/providers/scent.provider.dart' show ScentProvider;
import 'package:smellsense/shared/widgets/button.widget.dart' show Button;
import 'package:smellsense/storage/storage.dart' show SmellSenseStorage;
import 'package:url_launcher/url_launcher.dart' show launchUrl;
import '../../router.dart' show ScentSelectionRouteArguments, SmellTrainingRouteArguments;

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  MainMenuScreenState createState() => MainMenuScreenState();
}

class MainMenuScreenState extends State<MainMenuScreen> {
  final double _menuButtonSize = 140;
  bool _isFirstAppStart = false;
  final ScentProvider _scentProvider = GetIt.I<ScentProvider>();
  final SmellSenseStorage _storage = GetIt.I<SmellSenseStorage>();
  List<Scent> _scentSelections = [];

  final SvgPicture _logo = SvgPicture.asset(
    "assets/svg/smellsense_logo.svg",
    width: 50,
  );

  _onScentSelectionChanged(List<Scent> selections) {
    setState(() {
      _isFirstAppStart = false;
      _scentSelections = selections;
      _scentProvider.scentRatings = {};
    });
  }

  _initMenu() {
    var sel = _storage.getCurrentScentSelections();

    if (sel != null) {
      _scentSelections = sel
          .map((scent) => Scent.scents.firstWhere((s) => s.name == scent))
          .toList();
    } else {
      setState(() {
        _isFirstAppStart = true;
      });
    }
  }

  List<Widget> get menuButtons {
    return [
      if (_isFirstAppStart)
        SizedBox(
          width: _menuButtonSize,
          child: Button.primary(
            text: 'Get started',
            onPressed: () => Navigator.of(context).pushNamed(
              '/select-scents',
              arguments: ScentSelectionRouteArguments(
                _scentSelections,
                _onScentSelectionChanged,
              ),
            ),
          ),
        )
      else ...[
        SizedBox(
          width: _menuButtonSize,
          child: Button.primary(
            text: 'Train',
            onPressed: () async => Navigator.of(context).pushNamed(
              '/training',
              arguments: SmellTrainingRouteArguments(_scentSelections),
            ),
          ),
        ),
        SizedBox(
          width: _menuButtonSize,
          child: Button.primary(
            text: 'View Progress',
            onPressed: () =>
                Navigator.of(context).pushNamed('/training-progress'),
          ),
        ),
        SizedBox(
          width: _menuButtonSize,
          child: Button.primary(
            text: 'Reselect Scents',
            onPressed: () => Navigator.of(context).pushNamed(
              '/select-scents',
              arguments: ScentSelectionRouteArguments(
                _scentSelections,
                _onScentSelectionChanged,
              ),
            ),
          ),
        ),
      ],
      SizedBox(
        width: _menuButtonSize,
        child: Button.primary(
          text: 'Shop',
          onPressed: () => launchUrl(Uri(path: 'https://smellsense.myshopify.com/')),
        ),
      ),
      SizedBox(
        width: _menuButtonSize,
        child: Button.primary(
          text: 'About',
          onPressed: () => Navigator.of(context).pushNamed('/about'),
        ),
      ),
      SizedBox(
        width: _menuButtonSize,
        child: Button.primary(
          text: 'Help',
          onPressed: () => Navigator.of(context).pushNamed('/help'),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _initMenu();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
        future: _initMenu(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _logo,
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Smell',
                                    style:
                                        Theme.of(context).textTheme.displayLarge,
                                  ),
                                  TextSpan(
                                    text: 'Sense',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'The Smell Training App',
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Column(
                          children: [...menuButtons],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
