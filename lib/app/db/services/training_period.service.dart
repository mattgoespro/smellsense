import 'package:smellsense/app/application/providers/supported_training_scent.provider.dart';
import 'package:smellsense/app/db/daos/training_period.dao.dart';
import 'package:smellsense/app/db/daos/training_scent.dao.dart';
import 'package:smellsense/app/db/entities/training_period.entity.dart';
import 'package:smellsense/app/db/services/training_session.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session.module.dart';
import 'package:smellsense/app/shared/utils/datetimeutils.dart';
import 'package:smellsense/app/shared/utils/stringbuilder.dart';

class TrainingPeriodService {
  final SmellSenseDatabase db;

  final TrainingSessionService trainingSessionService;

  late final TrainingScentDao trainingScentDao;
  late final TrainingPeriodDao trainingPeriodDao;

  late SupportedTrainingScentProvider supportedTrainingScentProvider =
      SupportedTrainingScentProvider();

  TrainingPeriodService({
    required this.db,
    required this.trainingSessionService,
  }) {
    trainingScentDao = db.trainingScentDao;
    trainingPeriodDao = db.trainingPeriodDao;
  }

  Future<TrainingPeriod> getActiveTrainingPeriod() async {
    try {
      TrainingPeriodEntity? period =
          await trainingPeriodDao.findActiveTrainingPeriod();

      if (period == null) {
        throw SmellSenseDatabaseException("No training periods exist.");
      }

      List<TrainingSession> sessions =
          await trainingSessionService.getTrainingSessions(period.id);

      return TrainingPeriod(
        id: period.id,
        startDate: period.startDate,
        sessions: sessions,
      );
    } catch (e) {
      throw SmellSenseDatabaseException(
        StringBuilder.builder()
            .append("Error retrieving active training period.")
            .appendLine(e.toString())
            .build(),
      );
    }
  }

  Future<void> createTrainingPeriod(
    TrainingPeriod period,
  ) async {
    try {
      await trainingPeriodDao.insertTrainingPeriod(
        TrainingPeriodEntity(
          id: period.id,
          startDate: DateTimeUtils.getDateOnly(period.startDate),
        ),
      );
    } catch (e, stackTrace) {
      throw SmellSenseDatabaseException(
        StringBuilder.builder()
            .append("Error creating training period.")
            .appendLine(e.toString())
            .appendLine(stackTrace.toString())
            .build(),
      );
    }
  }

  Future<List<TrainingPeriod>> getAllTrainingPeriods() async {
    try {
      List<TrainingPeriodEntity>? periodEntities =
          await trainingPeriodDao.listTrainingPeriods();

      if (periodEntities == null) {
        return Future.value(<TrainingPeriod>[]);
      }

      List<TrainingPeriod> periods = [];

      for (TrainingPeriodEntity periodEntity in periodEntities) {
        List<TrainingSession> sessions =
            await trainingSessionService.getTrainingSessions(periodEntity.id);

        periods.add(
          TrainingPeriod(
            id: periodEntity.id,
            startDate: periodEntity.startDate,
            sessions: sessions,
          ),
        );
      }

      return periods;
    } catch (e) {
      throw SmellSenseDatabaseException(
        StringBuilder.builder()
            .append("Error listing all training periods.")
            .appendLine(e.toString())
            .build(),
      );
    }
  }
}
