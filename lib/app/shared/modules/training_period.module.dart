import 'package:smellsense/app/db/entities/training_period.entity.dart';

class TrainingPeriod {
  final DateTime startDate;

  TrainingPeriod({
    required this.startDate,
  });

  static TrainingPeriod fromEntity(TrainingPeriodEntity entity) {
    return TrainingPeriod(startDate: entity.startDate);
  }
}
