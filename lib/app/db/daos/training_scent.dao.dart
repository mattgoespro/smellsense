import 'package:floor/floor.dart';
import 'package:smellsense/app/db/entities/training_scent.entity.dart';

@dao
abstract class TrainingScentDao {
  @Query(
      'SELECT id, supported_scent_id, period_id FROM TrainingScent WHERE period_id = :periodId')
  Future<List<TrainingScentEntity>?> findTrainingScentsByPeriodId(
      String periodId);

  @insert
  Future<void> insertTrainingScent(TrainingScentEntity scent);

  @update
  Future<void> updateTrainingScent(TrainingScentEntity scent);

  @delete
  Future<void> deleteTrainingScent(TrainingScentEntity scent);
}
