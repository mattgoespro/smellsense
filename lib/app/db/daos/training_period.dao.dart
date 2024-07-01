import 'package:floor/floor.dart';
import 'package:smellsense/app/db/entities/training_period.entity.dart';

@dao
abstract class TrainingPeriodDao {
  @Query('SELECT id, start_date FROM TrainingPeriod')
  Stream<List<TrainingPeriodEntity>> listTrainingPeriods();

  @Query(
      'SELECT id, start_date FROM TrainingPeriod ORDER BY start_date DESC LIMIT 1')
  Future<TrainingPeriodEntity?> findCurrentTrainingPeriod();

  @Query('SELECT id, start_date FROM TrainingPeriod WHERE id = :id')
  Future<TrainingPeriodEntity?> findTrainingPeriodById(String id);

  @insert
  Future<void> insertTrainingPeriod(TrainingPeriodEntity period);

  @update
  Future<void> updateTrainingPeriod(TrainingPeriodEntity period);

  @delete
  Future<void> deleteTrainingPeriod(TrainingPeriodEntity period);
}
