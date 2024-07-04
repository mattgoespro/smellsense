import 'package:smellsense/app/shared/modules/training_session/training_session.module.dart';

class TrainingPeriod {
  final DateTime startDate;
  final List<TrainingSession> sessions;

  TrainingPeriod({required this.startDate, required this.sessions});
}
