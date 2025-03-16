import 'package:smellsense/app/application/providers/supported_training_scent.provider.dart';
import 'package:smellsense/app/db/services/database.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/utils/logger.dart';

class DatabaseServiceProvider {
  static const String dbName = 'smellsense_database.db';

  late final SmellSenseDatabase db;

  DatabaseServiceProvider({
    required this.db,
  });

  ///
  /// Create the database service.
  ///
  /// This function should only be called once before the application initializes.
  ///
  static Future<DatabaseService> create() async {
    SmellSenseDatabase db = await $FloorSmellSenseDatabase
        .databaseBuilder(DatabaseServiceProvider.dbName)
        .build();

    Output.trace('Database created.');

    return DatabaseService(
      db: db,
      supportedTrainingScentProvider: SupportedTrainingScentProvider(),
    );
  }
}
