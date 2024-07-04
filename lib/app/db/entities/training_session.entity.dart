import 'package:floor/floor.dart'
    show ColumnInfo, ForeignKey, entity, primaryKey;
import 'package:smellsense/app/db/entities/training_period.entity.dart';

@entity
class TrainingSessionEntity {
  @primaryKey
  final String id;

  @ForeignKey(
    entity: TrainingPeriodEntity,
    parentColumns: ['id'],
    childColumns: ['period_id'],
  )
  @ColumnInfo(name: 'period_id')
  final String periodId;

  @ColumnInfo(name: 'date')
  final DateTime date;

  TrainingSessionEntity({
    required this.id,
    required this.periodId,
    required this.date,
  });
}
