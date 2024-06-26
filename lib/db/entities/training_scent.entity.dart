import 'package:floor/floor.dart'
    show ColumnInfo, ForeignKey, entity, primaryKey;
import 'package:smellsense/db/entities/training_period.entity.dart';

@entity
class TrainingScentEntity {
  @ColumnInfo(name: 'id')
  @primaryKey
  final String id;

  @ColumnInfo(name: 'period_id')
  @ForeignKey(
    childColumns: ['period_id'],
    parentColumns: ['id'],
    entity: TrainingPeriodEntity,
  )
  final String periodId;

  @ColumnInfo(name: 'name')
  final String name;

  TrainingScentEntity({
    required this.id,
    required this.periodId,
    required this.name,
  });
}
