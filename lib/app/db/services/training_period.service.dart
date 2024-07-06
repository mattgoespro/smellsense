import 'package:smellsense/app/db/daos/training_period.dao.dart';
import 'package:smellsense/app/db/entities/training_period.entity.dart';
import 'package:smellsense/app/db/services/util.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';

class TrainingPeriodService {
  final SmellSenseDatabase db;
  late TrainingPeriodDao _trainingPeriodDao;

  TrainingPeriodService({required this.db}) {
    _trainingPeriodDao = db.trainingPeriodDao;
  }

  Future<TrainingPeriodEntity?> findTrainingPeriodById(String id) async {
    return db.trainingPeriodDao.findTrainingPeriodById(id);
  }

  Future<TrainingPeriodEntity?> findTrainingPeriodByStartDate(
      DateTime startDate) async {
    return db.trainingPeriodDao.findTrainingPeriodByStartDate(startDate);
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
