import 'package:smellsense/app/application/providers/supported_training_scent.provider.dart';
import 'package:smellsense/app/db/services/training_period.service.dart';
import 'package:smellsense/app/db/services/training_scent.service.dart';
import 'package:smellsense/app/db/services/training_session.service.dart';
import 'package:smellsense/app/db/services/training_session_entry.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/modules/training_scent/training_scent.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session.module.dart';
import 'package:smellsense/app/shared/utils/stringbuilder.dart';
import 'package:smellsense/app/shared/utils/utils.dart';

class DatabaseService {
  late final SmellSenseDatabase db;

  late final TrainingPeriodService _trainingPeriodService;
  late final TrainingScentService _trainingScentService;
  late final TrainingSessionService _trainingSessionService;
  late final TrainingSessionEntryService _trainingSessionEntryService;
  late final SupportedTrainingScentProvider _supportedTrainingScentProvider;

  DatabaseService({
    required this.db,
    required SupportedTrainingScentProvider supportedTrainingScentProvider,
  }) {
    _supportedTrainingScentProvider = supportedTrainingScentProvider;
    _trainingScentService = TrainingScentService(
      db: db,
      supportedTrainingScentProvider: _supportedTrainingScentProvider,
    );
    _trainingSessionEntryService = TrainingSessionEntryService(
      db: db,
      supportedTrainingScentProvider: _supportedTrainingScentProvider,
      trainingScentService: _trainingScentService,
    );
    _trainingSessionService = TrainingSessionService(
      db: db,
      trainingSessionEntryService: _trainingSessionEntryService,
    );
    _trainingPeriodService = TrainingPeriodService(
        db: db, trainingSessionService: _trainingSessionService);
  }

  Future<void> createTrainingPeriod(
    DateTime startDate,
    List<TrainingScent> scents,
  ) async {
    try {
      TrainingPeriod period = TrainingPeriod(
        id: uuid(),
        startDate: startDate,
      );

      await _trainingPeriodService.createTrainingPeriod(period);

      for (TrainingScent scent in scents) {
        await _trainingScentService.createTrainingScent(period, scent);
      }
    } catch (error, stackTrace) {
      throw SmellSenseDatabaseException(
        StringBuilder.builder()
            .append("Error creating training period.")
            .appendLine(error.toString())
            .appendLine(stackTrace.toString())
            .build(),
      );
    }
  }

  Future<void> recordTrainingSession(
    TrainingSession session,
  ) async {
    try {
      TrainingPeriod period =
          await _trainingPeriodService.getActiveTrainingPeriod();

      await _trainingSessionService.recordTrainingSession(
        period,
        session,
      );
    } catch (error, stackTrace) {
      throw SmellSenseDatabaseException(
        StringBuilder.builder()
            .append("Error recording training sessions.")
            .appendLine(error.toString())
            .appendLine(stackTrace.toString())
            .build(),
      );
    }
  }

  Future<List<TrainingScent>> getActiveTrainingScents() async {
    try {
      TrainingPeriod activePeriod =
          await _trainingPeriodService.getActiveTrainingPeriod();

      return _trainingScentService.findTrainingScents(activePeriod);
    } catch (error, stackTrace) {
      throw SmellSenseDatabaseException(
        StringBuilder.builder()
            .append("Error retrieving active training scents.")
            .appendLine(error.toString())
            .appendLine(stackTrace.toString())
            .build(),
      );
    }
  }

  Future<List<TrainingPeriod>> getTrainingPeriods() async {
    try {
      return _trainingPeriodService.getAllTrainingPeriods();
    } catch (error, stackTrace) {
      throw SmellSenseDatabaseException(
        StringBuilder.builder()
            .append("Error retrieving training periods.")
            .appendLine(error.toString())
            .appendLine(stackTrace.toString())
            .build(),
      );
    }
  }
}
