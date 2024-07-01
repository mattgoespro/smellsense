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

  TrainingSessionEntity({
    required this.id,
    required this.periodId,
  });
}
