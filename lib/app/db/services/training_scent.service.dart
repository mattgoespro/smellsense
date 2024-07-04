import 'package:smellsense/app/db/daos/training_scent.dao.dart';
import 'package:smellsense/app/db/entities/training_period.entity.dart';
import 'package:smellsense/app/db/entities/training_scent.entity.dart'
    show TrainingScentEntity;
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart'
    show TrainingScent, TrainingScentName;

class TrainingScentService {
  final SmellSenseDatabase db;

  late TrainingScentDao _trainingScentDao;

  TrainingScentService({required this.db}) {
    _trainingScentDao = db.trainingScentDao;
  }

  Future<List<TrainingScent>?> findTrainingScentsForPeriod(
    TrainingPeriod period,
  ) async {
    try {
      TrainingPeriodEntity? periodEntity = await db.trainingPeriodDao
          .findTrainingPeriodByStartDate(period.startDate);

      List<TrainingScentEntity>? entities = await _trainingScentDao
          .findTrainingScentsByPeriodId(periodEntity!.id);

      if (entities == null || entities.isEmpty) {
        throw SmellSenseDatabaseException(
            "Error retrieving scents for period: No scents found for period with ID '$period'.");
      }

      var trainingScents = entities.map<Future<TrainingScent>>(
        (entity) async {
          var supportedScent = await db.supportedTrainingScentDao
              .findSupportedTrainingScentById(entity.supportedScentId);
          return TrainingScent(
            name: TrainingScentName.fromString(supportedScent!.name),
          );
        },
      ).toList();

      return Future.wait(trainingScents);
    } catch (e) {
      throw SmellSenseDatabaseException(
          "Error retrieving scents for period: ${e.toString()}");
    }
  }
}
