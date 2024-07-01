import 'package:smellsense/app/shared/modules/training_session/training_session_entry.module.dart';

typedef TrainingSessionEncouragement = Map<int, String>;

class TrainingSession {
  final DateTime date;
  final List<TrainingSessionEntry> entries;

  const TrainingSession({
    required this.date,
    required this.entries,
  });
}

class TrainingSessionEncouragements {
  static int currentIndex = 0;

  static const TrainingSessionEncouragement encouragements = {
    0: "Try to remember exactly how this substance should smell",
    1: "Imagine yourself holding the real thing in your hands...the look, colours, texture and smell.",
    2: "Can you recall your last vivid memory of this smell?",
    3: "What positive associations can you make with this smell?",
  };

  static String getNextEncouragement() {
    return encouragements[currentIndex]!;
  }
}
