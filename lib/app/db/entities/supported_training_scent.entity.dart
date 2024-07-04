import 'package:floor/floor.dart' show ColumnInfo, entity, primaryKey;

@entity
class SupportedTrainingScentEntity {
  @ColumnInfo(name: 'id')
  @primaryKey
  final String id;

  @ColumnInfo(name: 'name')
  final String name;

  SupportedTrainingScentEntity({
    required this.id,
    required this.name,
  });
}
