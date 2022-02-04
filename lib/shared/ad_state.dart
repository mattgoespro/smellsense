import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  // Use below in production
  // ignore: unused_field
  final String _bannerAdUnitId = "ca-app-pub-3910471454197021/7023188632";

  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  // Change in production
  // String get bannerAdUnitId => BannerAd.testAdUnitId;
  String get bannerAdUnitId => _bannerAdUnitId;

  BannerAdListener get adListener => const BannerAdListener();
}
