import 'package:smellsense/app/db/data/supported_training_scent_data.dart';

class SupportedTrainingScentService {
  late SupportedTrainingScentData _supportedTrainingScentLoader;
  SupportedTrainingScentService() {
    _supportedTrainingScentLoader = SupportedTrainingScentData();
  }

  SupportedTrainingScent findSupportedTrainingScent(String id) {
    if (_supportedTrainingScentLoader.scents == null) {
      throw Exception('Supported training scent data is not loaded');
    }

    return _supportedTrainingScentLoader.scents!.firstWhere(
      (element) => element.id == id,
      orElse: () => throw Exception('Supported training scent not found'),
    );
  }
}
