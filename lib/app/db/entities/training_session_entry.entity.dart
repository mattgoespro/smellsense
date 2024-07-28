import 'package:floor/floor.dart'
    show ColumnInfo, ForeignKey, entity, primaryKey;
import 'package:smellsense/app/db/entities/training_scent.entity.dart';
import 'package:smellsense/app/db/entities/training_session.entity.dart';

@entity
class TrainingSessionEntryEntity {
  @ColumnInfo(name: 'id')
  @primaryKey
  final String id;

  @ColumnInfo(name: 'session_id')
  @ForeignKey(
    entity: TrainingSessionEntity,
    parentColumns: ['id'],
    childColumns: ['sessionId'],
  )
  final String sessionId;

  @ForeignKey(
    entity: TrainingScentEntity,
    parentColumns: ['id'],
    childColumns: ['scent_id'],
  )
  @ColumnInfo(name: 'scent_id')
  final String scentId;

  @ColumnInfo(name: 'rating')
  final int rating;

  @ColumnInfo(name: 'comment')
  final String? comment;

  @ColumnInfo(name: 'parosmia_reaction')
  final int? parosmiaReaction;

  @ColumnInfo(name: 'parosmia_reaction_severity')
  final int? parosmiaReactionSeverity;

  TrainingSessionEntryEntity({
    required this.id,
    required this.sessionId,
    required this.scentId,
    required this.rating,
    this.comment,
    this.parosmiaReactionSeverity,
    this.parosmiaReaction,
  });
}
