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
  group('Test: TrainingSessionEntryService', () {
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

      await trainingSessionService.recordTrainingSession(
        trainingPeriod,
        trainingSession,
      );
    });

    tearDown(() {
      db.close();
    });

    test('should create a new training session entry', () async {
      for (TrainingSessionEntry entry in trainingSession.entries) {
        await trainingSessionEntryService.recordTrainingSessionEntry(
          trainingSession.id,
          entry,
        );
      }

      final retrievedEntries = await trainingSessionEntryService
          .getTrainingSessionEntries(trainingSession.id);

      expect(
        retrievedEntries.length,
        equals(4),
        reason:
            "The retrieved training session entries should have a length of 4.",
      );

      expect(
        retrievedEntries,
        equals(trainingSession.entries),
        reason:
            "The retrieved training session entry should be the training session entry that was created.",
      );
    });
  });
}
