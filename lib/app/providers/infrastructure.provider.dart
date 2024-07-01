import 'package:smellsense/app/providers/asset.provider.dart';

class Infrastructure {
  final AssetProvider _assetProvider = AssetProvider();
  // final LocalizationProvider _localizationProvider = LocalizationProvider();

  AssetProvider getAssetProvider() => _assetProvider;
}
