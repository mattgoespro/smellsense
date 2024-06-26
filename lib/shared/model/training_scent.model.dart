import 'package:smellsense/db/entities/training_scent.entity.dart';

class TrainingScent {
  final String name;

  TrainingScent({
    required this.name,
  });

  static TrainingScent fromEntity(TrainingScentEntity entity) => TrainingScent(
        name: entity.name,
      );
}
