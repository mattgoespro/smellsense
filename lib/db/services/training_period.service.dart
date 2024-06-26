import 'package:smellsense/db/entities/training_period.entity.dart';
import 'package:smellsense/db/entities/training_scent.entity.dart';
import 'package:smellsense/db/services/database_provider.service.dart';
import 'package:smellsense/db/services/util.service.dart';
import 'package:smellsense/db/smellsense.db.dart';
import 'package:smellsense/shared/model/training_period.model.dart';
import 'package:smellsense/shared/model/training_scent.model.dart';

class TrainingPeriodService {
  Future<TrainingPeriodEntity?> findTrainingPeriodById(String id) async {
    return DatabaseProvider.database.trainingPeriodDao
        .findTrainingPeriodById(id);
  }

  Future<void> createTrainingPeriod(
      TrainingPeriod period, List<TrainingScent> scents) async {
    final periodId = generateUuid();
    final startDate = period.startDate.toIso8601String();

    try {
      await DatabaseProvider.database.trainingPeriodDao.insertTrainingPeriod(
        TrainingPeriodEntity(
          id: periodId,
          startDate: startDate,
        ),
      );
    } catch (e) {
      throw SmellSenseDatabaseException(
          "Error creating training period: ${e.toString()}");
    }

    for (var scent in scents) {
      try {
        await DatabaseProvider.database.trainingScentDao.insertTrainingScent(
          TrainingScentEntity(
            id: generateUuid(),
            periodId: periodId,
            name: scent.name,
          ),
        );
      } catch (e) {
        // delete scents and period if one fails
        try {
          List<TrainingScentEntity>? scentEntities = await DatabaseProvider
              .database.trainingScentDao
              .findTrainingScentsByPeriod(periodId);

          for (var scentEntity in scentEntities ?? []) {
            await DatabaseProvider.database.trainingScentDao
                .deleteTrainingScent(scentEntity);
          }
        } catch (e) {
          throw SmellSenseDatabaseException(
              "Failed to roll back creating of training period: ${e.toString()}");
        }
      }
    }
  }
}
