import 'package:floor/floor.dart';
import 'package:smellsense/app/db/entities/training_session_entry.entity.dart';

@dao
abstract class TrainingSessionEntryDao {
  @Query(
      'SELECT id, session_id, date, scent, rating, comment, severity, response FROM TrainingSessionEntry as tse INNER JOIN TrainingSession as ts ON ts.id = tse.session_id WHERE ts.id = :sessionId')
  Future<List<TrainingSessionEntryEntity>>
      findTrainingSessionEntriesBySessionId(String sessionId);

  @insert
  Future<void> insertTrainingSessionEntries(TrainingSessionEntryEntity entry);

  @delete
  Future<void> deleteTrainingSessionEntry(TrainingSessionEntryEntity entry);

  @transaction
  Future<void> deleteTrainingSessionEntriesBySessionId(String sessionId) async {
    final entries = await findTrainingSessionEntriesBySessionId(sessionId);

    for (final entry in entries) {
      deleteTrainingSessionEntry(entry);
    }
  }
}
