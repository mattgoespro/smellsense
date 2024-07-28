import 'package:smellsense/app/db/daos/training_period.dao.dart';
import 'package:smellsense/app/db/entities/training_period.entity.dart';
import 'package:smellsense/app/db/services/training_session.service.dart';
import 'package:smellsense/app/db/services/util.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session.module.dart';

class TrainingPeriodService {
  final SmellSenseDatabase db;
  late TrainingPeriodDao _trainingPeriodDao;
  late TrainingSessionService _trainingSessionService;

  TrainingPeriodService({required this.db}) {
    _trainingPeriodDao = db.trainingPeriodDao;
    _trainingSessionService = TrainingSessionService(db: db);
  }

  Future<TrainingPeriod> findTrainingPeriodById(String id) async {
    TrainingPeriodEntity? trainingPeriodEntity =
        await db.trainingPeriodDao.findTrainingPeriodById(id);

    if (trainingPeriodEntity == null) {
      throw SmellSenseDatabaseException(
          "Training period with id $id not found.");
    }

    List<TrainingSession> sessions = await _trainingSessionService
        .getTrainingSessionsForPeriodId(trainingPeriodEntity.id);

    return TrainingPeriod(
      startDate: trainingPeriodEntity.startDate,
      sessions: sessions,
    );
  }

  Future<TrainingPeriod> getActiveTrainingPeriod() async {
    try {
      TrainingPeriodEntity? period =
          await _trainingPeriodDao.findActiveTrainingPeriod();

      if (period == null) {
        throw SmellSenseDatabaseException(
            "There are no active training period.");
      }

      List<TrainingSession> sessions = await _trainingSessionService
          .getTrainingSessionsForPeriodId(period.id);

      return TrainingPeriod(
        startDate: period.startDate,
        sessions: sessions,
      );
    } catch (e) {
      throw SmellSenseDatabaseException(
          "Error getting current training period: ${e.toString()}");
    }
  }

  Future<void> createTrainingPeriod(
    DateTime startDate,
  ) async {
    try {
      String periodId = uuid();

      await _trainingPeriodDao.insertTrainingPeriod(
        TrainingPeriodEntity(
          id: periodId,
          startDate: startDate,
        ),
      );
    } catch (e) {
      throw SmellSenseDatabaseException(
          "Error creating training period: ${e.toString()}");
    }
  }
}
