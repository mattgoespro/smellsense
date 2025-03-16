import 'package:flutter_test/flutter_test.dart';
import 'package:smellsense/app/application/providers/supported_training_scent.provider.dart';
import 'package:smellsense/app/db/services/training_period.service.dart';
import 'package:smellsense/app/db/services/training_scent.service.dart';
import 'package:smellsense/app/db/services/training_session.service.dart';
import 'package:smellsense/app/db/services/training_session_entry.service.dart';
import 'package:smellsense/app/db/smellsense.db.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/modules/training_scent/training_scent.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry.module.dart';

import '../data/modules/training_period.data.dart';

void main() {
  group('Test: TrainingSessionService', () {
    late SmellSenseDatabase db;
    late TrainingSessionEntryService trainingSessionEntryService;
    late TrainingScentService trainingScentService;
    late TrainingPeriodService trainingPeriodService;
    late TrainingSessionService trainingSessionService;
    TrainingPeriod trainingPeriod = testTrainingPeriod;
    TrainingSession trainingSession = testTrainingPeriod.sessions![0];

    SupportedTrainingScentProvider supportedTrainingScentProvider =
        SupportedTrainingScentProvider();

    setUp(() async {
      db = await $FloorSmellSenseDatabase.inMemoryDatabaseBuilder().build();
      supportedTrainingScentProvider = SupportedTrainingScentProvider();
      trainingScentService = TrainingScentService(
        db: db,
        supportedTrainingScentProvider: supportedTrainingScentProvider,
      );
      trainingSessionEntryService = TrainingSessionEntryService(
        db: db,
        trainingScentService: trainingScentService,
        supportedTrainingScentProvider: supportedTrainingScentProvider,
      );
      trainingSessionService = TrainingSessionService(
        db: db,
        trainingSessionEntryService: trainingSessionEntryService,
      );
      trainingPeriodService = TrainingPeriodService(
        db: db,
        trainingSessionService: trainingSessionService,
      );

      await trainingPeriodService.createTrainingPeriod(testTrainingPeriod);

      List<TrainingScent> scents = trainingSession.entries
          .map(
            TrainingScent.of,
          )
          .toList();

      for (TrainingScent scent in scents) {
        await trainingScentService.createTrainingScent(
          trainingPeriod,
          scent,
        );
      }
    });

    tearDown(() {
      db.close();
    });

    test('should record a new training session for the given period', () async {
      await trainingSessionService.recordTrainingSession(
        trainingPeriod,
        trainingSession,
      );

      for (TrainingSessionEntry entry in trainingSession.entries) {
        await trainingSessionEntryService.recordTrainingSessionEntry(
          trainingSession.id,
          entry,
        );
      }

      final retrievedSessions =
          await trainingSessionService.getTrainingSessions(
        trainingPeriod.id,
      );

      expect(
        retrievedSessions,
        hasLength(1),
        reason:
            "A single training session should be recorded for the given period.",
      );

      expect(
        retrievedSessions.first,
        equals(trainingSession),
        reason:
            "The retrieved training session should be the training session that was recorded.",
      );
    });
  });
}
