import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  final String mainScreenBannerAndroid =
      "ca-app-pub-3910471454197021/7023188632";
  final String mainScreenBannerIOS = "ca-app-pub-3910471454197021/4386840138";

  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  BannerAdListener get adListener => const BannerAdListener();
}
