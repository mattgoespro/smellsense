import 'package:smellsense/app/db/daos/training_session.dao.dart';
import 'package:smellsense/app/db/entities/training_session.entity.dart';
import 'package:smellsense/app/db/services/training_session_entry.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry.module.dart';
import 'package:smellsense/app/shared/utils/stringbuilder.dart';

class TrainingSessionService {
  final SmellSenseDatabase db;
  final TrainingSessionEntryService _trainingSessionEntryService;
  late final TrainingSessionDao _trainingSessionDao;

  TrainingSessionService({
    required this.db,
    required TrainingSessionEntryService trainingSessionEntryService,
  }) : _trainingSessionEntryService = trainingSessionEntryService {
    _trainingSessionDao = db.trainingSessionDao;
  }

  Future<void> recordTrainingSession(
    TrainingPeriod period,
    TrainingSession session,
  ) async {
    try {
      await _trainingSessionDao.insertTrainingSession(
        TrainingSessionEntity(
          id: session.id,
          date: session.date,
          periodId: period.id,
        ),
      );
    } catch (e, stackTrace) {
      throw SmellSenseDatabaseException(
        StringBuilder.builder()
            .append("Error adding session for period '$period'.")
            .appendLine(e.toString())
            .appendLine(stackTrace.toString())
            .build(),
      );
    }
  }

  Future<List<TrainingSession>> getTrainingSessions(
    String periodId,
  ) async {
    List<TrainingSession> sessions = [];

    try {
      List<TrainingSessionEntity> sessionEntities =
          await _trainingSessionDao.findTrainingSessionsByPeriodId(periodId);

      for (TrainingSessionEntity sessionEntity in sessionEntities) {
        List<TrainingSessionEntry> sessionEntries =
            await _trainingSessionEntryService
                .getTrainingSessionEntries(sessionEntity.id);

        sessions.add(
          TrainingSession(
            id: sessionEntity.id,
            date: sessionEntity.date,
            entries: sessionEntries,
          ),
        );
      }

      return sessions;
    } catch (e) {
      throw SmellSenseDatabaseException(
        StringBuilder.builder()
            .append("Error getting sessions for period '$periodId'.")
            .appendLine(e.toString())
            .build(),
      );
    }
  }
}
