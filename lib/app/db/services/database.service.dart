import 'package:smellsense/app/db/services/training_period.service.dart';
import 'package:smellsense/app/db/services/training_scent.service.dart';
import 'package:smellsense/app/db/services/training_session_entry.service.dart';
import 'package:smellsense/app/db/services/training_session.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';

class DatabaseService {
  final SmellSenseDatabase db;

  late TrainingPeriodService _trainingPeriodService;
  late TrainingScentService _trainingScentService;
  late TrainingSessionService _trainingSessionService;
  late TrainingSessionEntryService _trainingSessionEntryService;

  DatabaseService({required this.db}) {
    _trainingPeriodService = TrainingPeriodService(db: db);
    _trainingScentService = TrainingScentService(db: db);
  }

  TrainingPeriodService getTrainingPeriodService() {
    return _trainingPeriodService;
  }

  TrainingScentService getTrainingScentService() {
    return _trainingScentService;
  }

  TrainingSessionService getTrainingSessionService() {
    return _trainingSessionService;
  }

  TrainingSessionEntryService getTrainingSessionEntryService() {
    return _trainingSessionEntryService;
  }
}
