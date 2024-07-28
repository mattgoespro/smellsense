import 'package:smellsense/app/db/daos/training_session_entry.dao.dart';
import 'package:smellsense/app/db/entities/training_session_entry.entity.dart';
import 'package:smellsense/app/db/services/training_scent.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_parosmia_reaction.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_rating.module.dart';

class TrainingSessionEntryService {
  final SmellSenseDatabase db;

  late TrainingSessionEntryDao _trainingSessionEntryDao;
  late TrainingScentService _trainingScentService;

  TrainingSessionEntryService({required this.db}) {
    _trainingSessionEntryDao = db.trainingSessionEntryDao;
    _trainingScentService = TrainingScentService(db: db);
  }

  Future<List<TrainingSessionEntry>> getTrainingSessionEntries(
    String sessionId,
  ) async {
    List<TrainingSessionEntry> sessionEntries = [];
    try {
      List<TrainingSessionEntryEntity> entryEntities =
          await _trainingSessionEntryDao
              .findTrainingSessionEntriesBySessionId(sessionId);

      for (var entity in entryEntities) {
        TrainingScent scent =
            await _trainingScentService.findTrainingScentById(entity.scentId);

        sessionEntries.add(
          TrainingSessionEntry(
            scent: scent,
            rating: TrainingSessionEntryRatings.getRating(entity.rating),
            comment: entity.comment,
            parosmiaReaction: TrainingSessionEntryParosmiaReaction.fromValue(
                entity.parosmiaReaction ?? 0),
            parosmiaReactionSeverity:
                TrainingSessionEntryParosmiaReactionSeverity.fromValue(
                    entity.parosmiaReactionSeverity ?? 0),
          ),
        );
      }
    } catch (e) {
      throw SmellSenseDatabaseException(
          "Error getting session entries for session '$sessionId': ${e.toString()}");
    }

    return sessionEntries;
  }
}
