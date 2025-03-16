import 'package:flutter/foundation.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session.module.dart';

class TrainingPeriod {
  final String id;
  final DateTime startDate;
  final List<TrainingSession>? sessions;

  TrainingPeriod({
    required this.id,
    required this.startDate,
    this.sessions,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrainingPeriod &&
        other.id == id &&
        other.startDate == startDate &&
        listEquals(other.sessions, sessions);
  }

  @override
  int get hashCode => id.hashCode ^ startDate.hashCode ^ sessions.hashCode;

  @override
  String toString() {
    String sessionsString =
        (sessions ?? []).map((e) => e.toString()).join("\n, ");

    return "TrainingPeriod(startDate: $startDate, sessions: $sessionsString)";
  }
}
