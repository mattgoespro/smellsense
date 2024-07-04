import 'package:floor/floor.dart';
import 'package:smellsense/app/db/entities/supported_training_scent.entity.dart';

@dao
abstract class SupportedTrainingScentDao {
  @Query('SELECT id, name FROM SupportedTrainingScent')
  Future<List<SupportedTrainingScentEntity>> listSupportedTrainingScents();

  @Query('SELECT id, name FROM SupportedTrainingScent WHERE name = :name')
  Future<SupportedTrainingScentEntity?> findSupportedTrainingScentByName(
      String name);

  @Query('SELECT id, name FROM SupportedTrainingScent WHERE name = :name')
  Future<SupportedTrainingScentEntity?> findSupportedTrainingScentById(
      String name);
}
