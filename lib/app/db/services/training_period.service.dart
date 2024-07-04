import 'package:smellsense/app/db/daos/training_period.dao.dart';
import 'package:smellsense/app/db/daos/training_scent.dao.dart';
import 'package:smellsense/app/db/entities/training_period.entity.dart';
import 'package:smellsense/app/db/entities/training_scent.entity.dart';
import 'package:smellsense/app/db/services/util.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';

class TrainingPeriodService {
  final SmellSenseDatabase db;
  late TrainingPeriodDao _trainingPeriodDao;
  late TrainingScentDao _trainingScentDao;

  TrainingPeriodService({required this.db}) {
    _trainingPeriodDao = db.trainingPeriodDao;
    _trainingScentDao = db.trainingScentDao;
  }

  Future<TrainingPeriodEntity?> findTrainingPeriodById(String id) async {
    return db.trainingPeriodDao.findTrainingPeriodById(id);
  }

  Future<TrainingPeriodEntity?> findTrainingPeriodByStartDate(
      DateTime startDate) async {
    return db.trainingPeriodDao.findTrainingPeriodByStartDate(startDate);
  }

  Future<void> createTrainingPeriod(
    TrainingPeriod period,
  ) async {
    if (period.sessions.isNotEmpty) {
      throw SmellSenseDatabaseException(
          "Error creating training period: cannot create period with multiple initial sessions.");
    }

    try {
      String periodId = uuid();

      await _trainingPeriodDao.insertTrainingPeriod(
        TrainingPeriodEntity(
          id: periodId,
          startDate: period.startDate,
        ),
      );

      var session = period.sessions[0];
      var entries = session.entries;

      for (TrainingScent scent in entries.map((entry) => entry.scent)) {
        var supportedScent = await db.supportedTrainingScentDao
            .findSupportedTrainingScentByName(scent.name.scentName);

        await _trainingScentDao.insertTrainingScent(
          TrainingScentEntity(
            id: uuid(),
            periodId: periodId,
            supportedScentId: supportedScent!.id,
          ),
        );
      }
    } catch (e) {
      throw SmellSenseDatabaseException(
          "Error creating training period: ${e.toString()}");
    }
  }
}
