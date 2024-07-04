enum TrainingSessionEntryParosmiaSeverity { none, mild, moderate, severe }

enum TrainingSessionEntryParosmiaReaction {
  none,
  angry,
  disgusted,
  unhappy,
  neutral,
  pleased,
  happy
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

  static const Map<TrainingSessionEntryParosmiaSeverity, String>
      _reactionSeverities = {
    TrainingSessionEntryParosmiaSeverity.mild: "Mild",
    TrainingSessionEntryParosmiaSeverity.moderate: "Moderate",
    TrainingSessionEntryParosmiaSeverity.severe: "Severe",
  };

  static String getParosmiaReactionEmoji(String reaction) {
    return _reactions[reaction]!;
  }

  static Iterable<MapEntry<String, String>> getParosmiaReactions() {
    return _reactions.entries;
  }

  static Iterable<MapEntry<TrainingSessionEntryParosmiaSeverity, String>>
      getParosmiaSeverities() {
    return _reactionSeverities.entries;
  }

  static String getParosmiaSeverityDisplayValue(
      TrainingSessionEntryParosmiaSeverity severity) {
    return _reactionSeverities[severity]!;
  }
}
