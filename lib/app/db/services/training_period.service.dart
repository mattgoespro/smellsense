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

  Future<void> createTrainingPeriod(
    TrainingPeriod period,
    List<TrainingScent> scents,
  ) async {
    try {
      String periodId = generateUuid();

      await _trainingPeriodDao.insertTrainingPeriod(
        TrainingPeriodEntity(
          id: periodId,
          startDate: period.startDate,
        ),
      );

      for (TrainingScent scent in scents) {
        await _trainingScentDao.insertTrainingScent(
          TrainingScentEntity(
            id: generateUuid(),
            periodId: periodId,
            name: scent.name.toString(),
          ),
        );
      }
    } catch (e) {
      throw SmellSenseDatabaseException(
          "Error creating training period: ${e.toString()}");
    }
  }
}
