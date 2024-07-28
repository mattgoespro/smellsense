enum TrainingSessionEntryParosmiaReactionSeverity {
  none(0),
  mild(1),
  moderate(2),
  severe(3);

  final int severity;

  const TrainingSessionEntryParosmiaReactionSeverity(this.severity);

  static fromValue(int value) {
    return TrainingSessionEntryParosmiaReactionSeverity.values.firstWhere(
      (element) => element.index == value,
    );
  }
}

enum TrainingSessionEntryParosmiaReaction {
  none(0),
  angry(1),
  disgusted(2),
  unhappy(3),
  neutral(4),
  pleased(5),
  happy(6);

  final int reaction;

  const TrainingSessionEntryParosmiaReaction(this.reaction);

  static fromValue(int value) {
    return TrainingSessionEntryParosmiaReaction.values.firstWhere(
      (element) => element.reaction == value,
    );
  }
}

class TrainingSessionEntryParosmia {
  static const Map<String, String> _reactions = {
    'angry': 'assets/svg/emojis/angry.svg',
    'disgusted': 'assets/svg/emojis/disgusted.svg',
    'unhappy': 'assets/svg/emojis/unhappy.svg',
    'neutral': 'assets/svg/emojis/neutral.svg',
    'pleased': 'assets/svg/emojis/pleased.svg',
    'happy': 'assets/svg/emojis/happy.svg',
  };

  static const Map<TrainingSessionEntryParosmiaReactionSeverity, String>
      _reactionSeverities = {
    TrainingSessionEntryParosmiaReactionSeverity.mild: "Mild",
    TrainingSessionEntryParosmiaReactionSeverity.moderate: "Moderate",
    TrainingSessionEntryParosmiaReactionSeverity.severe: "Severe",
  };

  static String getParosmiaReactionEmoji(String reaction) {
    return _reactions[reaction]!;
  }

  static Iterable<MapEntry<String, String>> getParosmiaReactions() {
    return _reactions.entries;
  }

  static Iterable<
          MapEntry<TrainingSessionEntryParosmiaReactionSeverity, String>>
      getParosmiaSeverities() {
    return _reactionSeverities.entries;
  }

  static String getParosmiaSeverityDisplayValue(
      TrainingSessionEntryParosmiaReactionSeverity severity) {
    return _reactionSeverities[severity]!;
  }
}
