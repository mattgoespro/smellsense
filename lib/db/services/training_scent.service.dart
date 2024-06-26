import 'package:smellsense/db/entities/training_period.entity.dart';
import 'package:smellsense/db/entities/training_scent.entity.dart'
    show TrainingScentEntity;
import 'package:smellsense/db/services/database_provider.service.dart'
    show DatabaseProvider;
import 'package:smellsense/db/services/training_period.service.dart';
import 'package:smellsense/db/services/util.service.dart';
import 'package:smellsense/db/smellsense.db.dart';
import 'package:smellsense/shared/model/training_scent.model.dart'
    show TrainingScent;

class TrainingScentService {
  final TrainingPeriodService _trainingPeriodService = TrainingPeriodService();

  Future<void> insertTrainingScentsForPeriod(
    String periodId,
    List<TrainingScent> scents,
  ) async {
    return Future.forEach(
        scents,
        (TrainingScent scent) =>
            DatabaseProvider.database.trainingScentDao.insertTrainingScent(
              TrainingScentEntity(
                id: generateUuid(),
                periodId: periodId,
                name: scent.name,
              ),
            ));
  }

  Future<List<TrainingScent>> findTrainingScentsForPeriod(
    String periodId,
  ) async {
    TrainingPeriodEntity? period =
        await _trainingPeriodService.findTrainingPeriodById(periodId);

    if (period == null) {
      throw SmellSenseDatabaseException(
          "Error retrieving scents for period: Period with ID '$periodId' not found.");
    }

    List<TrainingScentEntity>? entities = await DatabaseProvider
        .database.trainingScentDao
        .findTrainingScentsByPeriod(periodId);

    if ((entities ??= []).isEmpty) {
      throw SmellSenseDatabaseException(
          "Error retrieving scents for period: No scents found for period with ID '$periodId'.");
    }

    return entities
        .map<TrainingScent>((entity) => TrainingScent.fromEntity(entity))
        .toList();
  }
}
