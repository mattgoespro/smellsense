import 'package:smellsense/app/application/providers/asset.provider.dart';
import 'package:smellsense/app/db/services/database.service.dart';
import 'package:smellsense/app/providers/database_service.provider.dart';

class Infrastructure {
  final DatabaseService? databaseService;
  final AssetProvider? assetProvider;

  Infrastructure({required this.databaseService, required this.assetProvider});

  AssetProvider getAssetProvider() => assetProvider!;

  static Future<Infrastructure> getInfrastructure() async {
    final databaseService =
        await DatabaseServiceProvider.createDatabaseService();
    final assetProvider = AssetProvider();
    return Infrastructure(
        databaseService: databaseService, assetProvider: assetProvider);
  }

  static Infrastructure newInstance() {
    return Infrastructure(databaseService: null, assetProvider: null);
  }
}
