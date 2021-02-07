import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:smellsense/model/scent.dart';
import 'package:smellsense/providers/scent.provider.dart';
import 'package:smellsense/shared/widgets/ad-state.dart';
import 'package:smellsense/shared/widgets/button.widget.dart';
import 'package:smellsense/storage/storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../router.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final double _menuButtonSize = 140;
  bool _isFirstAppStart = false;
  ScentProvider _scentProvider = GetIt.I<ScentProvider>();
  SmellSenseStorage _storage = GetIt.I<SmellSenseStorage>();
  List<Scent> _scentSelections;

  BannerAd banner;

  _onScentSelectionChanged(List<Scent> selections) {
    setState(() {
      this._isFirstAppStart = false;
      this._scentSelections = selections;
      this._scentProvider.scentRatings = {};
    });
  }

  _initMenu() async {
    var sel = await this._storage.getCurrentScentSelections();

    if (sel != null) {
      this._scentSelections = sel
          .map((scent) => Scent.scents.firstWhere((s) => s.name == scent))
          .toList();
    } else {
      setState(() {
        this._isFirstAppStart = true;
      });
    }
  }

  List<Widget> get menuButtons {
    return [
      if (this._isFirstAppStart)
        SizedBox(
          width: this._menuButtonSize,
          child: Button.primary(
            text: 'Get started',
            onPressed: () => Navigator.of(context).pushNamed(
              '/select-scents',
              arguments: ScentSelectionRouteArguments(
                this._scentSelections,
                _onScentSelectionChanged,
              ),
            ),
          ),
        )
      else ...[
        SizedBox(
          width: this._menuButtonSize,
          child: Button.primary(
            text: 'Train',
            onPressed: () async => Navigator.of(context).pushNamed(
              '/training',
              arguments: SmellTrainingRouteArguments(this._scentSelections),
            ),
          ),
        ),
        SizedBox(
          width: this._menuButtonSize,
          child: Button.primary(
            text: 'View Progress',
            onPressed: () =>
                Navigator.of(context).pushNamed('/training-progress'),
          ),
        ),
        SizedBox(
          width: this._menuButtonSize,
          child: Button.primary(
            text: 'Reselect Scents',
            onPressed: () => Navigator.of(context).pushNamed(
              '/select-scents',
              arguments: ScentSelectionRouteArguments(
                this._scentSelections,
                _onScentSelectionChanged,
              ),
            ),
          ),
        ),
      ],
      SizedBox(
        width: this._menuButtonSize,
        child: Button.primary(
          text: 'Shop',
          onPressed: () => launch('https://smellsense.myshopify.com/'),
        ),
      ),
      SizedBox(
        width: this._menuButtonSize,
        child: Button.primary(
          text: 'About',
          onPressed: () => Navigator.of(context).pushNamed('/about'),
        ),
      ),
      SizedBox(
        width: this._menuButtonSize,
        child: Button.primary(
          text: 'Help',
          onPressed: () => Navigator.of(context).pushNamed('/help'),
        ),
      ),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final adState = Provider.of<AdState>(context);
    adState.initialization.then((value) {
      setState(() {
        this.banner = BannerAd(
          size: AdSize.banner,
          adUnitId: adState.bannerAdUnitId,
          listener: adState.adListener,
          request: AdRequest(),
        )..load();
      });
    });
  }

  @override
  void dispose() {
    this.banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
        future: this._initMenu(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Center(
                          child: Image.asset(
                            'assets/images/logos/smellsense_main_menu_logo.png',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: FittedBox(
                            child: Column(
                              children: [...this.menuButtons],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (this.banner != null)
                Container(
                  height: 50,
                  child: AdWidget(
                    ad: this.banner,
                  ),
                )
              else
                SizedBox(
                  height: 50,
                )
            ],
          );
        },
      ),
    );
  }
}
