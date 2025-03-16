import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smellsense/app/application/providers/database_service.provider.dart';
import 'package:smellsense/app/application/providers/supported_training_scent.provider.dart';
import 'package:smellsense/app/db/services/database.service.dart';
import 'package:smellsense/app/shared/utils/logger.dart';

class Infrastructure {
  late final DatabaseService databaseService;
  late final SupportedTrainingScentProvider supportedTrainingScentProvider;

  Infrastructure({
    required this.databaseService,
    required this.supportedTrainingScentProvider,
  });

  Infrastructure.of(BuildContext context) {
    Infrastructure infrastructure = context.read<Infrastructure>();

    databaseService = infrastructure.databaseService;
    supportedTrainingScentProvider =
        infrastructure.supportedTrainingScentProvider;
  }

  ///
  /// Get the infrastructure that is provided to all widgets.
  ///
  /// This method should only be called once throughout the application lifecycle.
  ///
  static Future<Infrastructure> getInfrastructure() async {
    try {
      final databaseService = await DatabaseServiceProvider.create();

      return Infrastructure(
        databaseService: databaseService,
        supportedTrainingScentProvider: SupportedTrainingScentProvider(),
      );
    } catch (exception, stackTrace) {
      Output.error(exception.toString());
      Output.trace(stackTrace.toString());
      throw Exception(
        "An error occurred while trying to create the infrastructure.",
      );
    }
  }

  Infrastructure.empty() {
    supportedTrainingScentProvider = SupportedTrainingScentProvider();
  }
}
