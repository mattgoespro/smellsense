import 'package:smellsense/app/db/daos/training_scent.dao.dart';
import 'package:smellsense/app/db/entities/training_scent.entity.dart'
    show TrainingScentEntity;
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart'
    show TrainingScent;

class TrainingScentService {
  final SmellSenseDatabase db;

  late TrainingScentDao _trainingScentDao;

  TrainingScentService({required this.db}) {
    _trainingScentDao = db.trainingScentDao;
  }

  Future<List<TrainingScent>> findTrainingScentsForPeriod(
    String periodId,
  ) async {
    try {
      List<TrainingScentEntity>? entities =
          await _trainingScentDao.findTrainingScentsByPeriod(periodId);

      if (entities == null || entities.isEmpty) {
        throw SmellSenseDatabaseException(
            "Error retrieving scents for period: No scents found for period with ID '$periodId'.");
      }

      return entities
          .map<TrainingScent>((entity) => TrainingScent.fromEntity(entity))
          .toList();
    } catch (e) {
      throw SmellSenseDatabaseException(
          "Error retrieving scents for period: ${e.toString()}");
    }
  }
}
