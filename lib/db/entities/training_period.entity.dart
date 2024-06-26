import 'package:floor/floor.dart' show ColumnInfo, entity, primaryKey;

@entity
class TrainingPeriodEntity {
  @ColumnInfo(name: 'id')
  @primaryKey
  final String id;

  @ColumnInfo(name: 'start_date')
  final String startDate; // Unix timestamp

  TrainingPeriodEntity({
    required this.id,
    required this.startDate,
  });
}
