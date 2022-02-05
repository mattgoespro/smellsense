import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  final String _mainScreenBannerAndroid =
      "ca-app-pub-3910471454197021/7023188632";
  final String _mainScreenBannerIOS = "ca-app-pub-3910471454197021/4386840138";

  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  get mainScreenBannerAds =>
      ({"android": _mainScreenBannerAndroid, "ios": _mainScreenBannerIOS});

  BannerAdListener get adListener => const BannerAdListener();
}
