import 'package:smellsense/db/daos/training_period.dao.dart';
import 'package:smellsense/db/daos/training_scent.dao.dart';
import 'package:smellsense/db/daos/training_session.dao.dart';
import 'package:smellsense/db/daos/training_session_entry.dao.dart';
import 'package:smellsense/db/smellsense.db.dart';

class DatabaseProvider {
  static const String _databaseName = 'smellsense_database.db';

  static late SmellSenseDatabase _database;

  static late TrainingPeriodDao trainingPeriodDao;
  static late TrainingSessionDao trainingSessionDao;
  static late TrainingSessionEntryDao trainingSessionEntryDao;
  static late TrainingScentDao trainingScentDao;

  static createDatabase() async {
    _database =
        await $FloorSmellSenseDatabase.databaseBuilder(_databaseName).build();
    trainingSessionEntryDao = _database.trainingSessionEntryDao;
  }

  static SmellSenseDatabase get database {
    return _database;
  }
}
