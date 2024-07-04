import 'package:floor/floor.dart'
    show ColumnInfo, ForeignKey, entity, primaryKey;
import 'package:smellsense/app/db/entities/supported_training_scent.entity.dart';
import 'package:smellsense/app/db/entities/training_period.entity.dart';

@entity
class TrainingScentEntity {
  @ColumnInfo(name: 'id')
  @primaryKey
  final String id;

  @ColumnInfo(name: 'supported_scent_id')
  @ForeignKey(
    childColumns: ['supported_scent_id'],
    parentColumns: ['id'],
    entity: SupportedTrainingScentEntity,
  )
  final String supportedScentId;

  TrainingScentEntity({
    required this.id,
    required this.periodId,
    required this.supportedScentId,
  });

  @ColumnInfo(name: 'period_id')
  @ForeignKey(
    childColumns: ['period_id'],
    parentColumns: ['id'],
    entity: TrainingPeriodEntity,
  )
  final String periodId;
}
