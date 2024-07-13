import 'package:smellsense/app/application/providers/asset.provider.dart';
import 'package:smellsense/app/application/providers/database_service.provider.dart';
import 'package:smellsense/app/db/services/database.service.dart';

class Infrastructure {
  final DatabaseService databaseService;
  final AssetProvider assetProvider;

  Infrastructure({required this.databaseService, required this.assetProvider});

  AssetProvider getAssetProvider() => assetProvider;

  ///
  /// Get the infrastructure for the application shared by all of the widgets.
  /// This method should only be called once in the application lifecycle.
  ///
  static Future<Infrastructure> getInfrastructure() async {
    final databaseService =
        await DatabaseServiceProvider.createDatabaseService();
    final assetProvider = AssetProvider();

    return Infrastructure(
        databaseService: databaseService, assetProvider: assetProvider);
  }
}
