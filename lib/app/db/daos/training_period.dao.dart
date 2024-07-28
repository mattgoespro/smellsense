import 'package:floor/floor.dart';
import 'package:smellsense/app/db/entities/training_period.entity.dart';

@dao
abstract class TrainingPeriodDao {
  @Query('SELECT id, start_date FROM TrainingPeriod')
  Future<List<TrainingPeriodEntity>> listTrainingPeriods();

  @Query(
      'SELECT id, start_date FROM TrainingPeriod ORDER BY start_date DESC LIMIT 1')
  Future<TrainingPeriodEntity?> findActiveTrainingPeriod();

  @Query('SELECT id, start_date FROM TrainingPeriod WHERE id = :id')
  Future<TrainingPeriodEntity?> findTrainingPeriodById(String id);

  @Query(
      'SELECT id, start_date FROM TrainingPeriod WHERE start_date = :startDate')
  Future<TrainingPeriodEntity?> findTrainingPeriodByStartDate(
      DateTime startDate);

  @insert
  Future<void> insertTrainingPeriod(TrainingPeriodEntity period);

  @update
  Future<void> updateTrainingPeriod(TrainingPeriodEntity period);

  @delete
  Future<void> deleteTrainingPeriod(TrainingPeriodEntity period);
}
