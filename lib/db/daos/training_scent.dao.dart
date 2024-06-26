import 'package:floor/floor.dart';
import 'package:smellsense/db/entities/training_scent.entity.dart';

@dao
abstract class TrainingScentDao {
  @Query('SELECT id, name FROM TrainingScent WHERE period_id = :periodId')
  Future<List<TrainingScentEntity>?> findTrainingScentsByPeriod(
      String periodId);

  @insert
  Future<void> insertTrainingScent(TrainingScentEntity scent);

  @update
  Future<void> updateTrainingScent(TrainingScentEntity scent);

  @delete
  Future<void> deleteTrainingScent(TrainingScentEntity scent);
}
