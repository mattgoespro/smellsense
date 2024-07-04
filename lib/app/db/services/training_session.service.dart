import 'package:smellsense/app/db/daos/training_session.dao.dart';
import 'package:smellsense/app/db/entities/training_session.entity.dart';
import 'package:smellsense/app/db/services/util.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session.module.dart';

class TrainingSessionService {
  final SmellSenseDatabase db;

  late TrainingSessionDao _trainingSessionDao;

  TrainingSessionService({required this.db}) {
    _trainingSessionDao = db.trainingSessionDao;
  }

  Future<void> addTrainingSessionsForPeriodId(
    String periodId,
    List<TrainingSession> sessions,
  ) async {
    try {
      for (var session in sessions) {
        var sessionId = uuid();

        await _trainingSessionDao.insertTrainingSession(
          TrainingSessionEntity(
            id: sessionId,
            periodId: periodId,
            date: session.date,
          ),
        );
      }
    } catch (e) {
      throw SmellSenseDatabaseException(
          "Error creating session for period '$periodId': ${e.toString()}");
    }
  }
}
