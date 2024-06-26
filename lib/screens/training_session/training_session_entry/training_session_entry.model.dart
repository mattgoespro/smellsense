import 'package:smellsense/screens/training_session/training_session_entry/training_session_entry_reaction.model.dart';

class TrainingSessionEntry {
  final String scentName;
  final String date;
  final TrainingSessionEntryRating rating;
  final String comment;
  final TrainingSessionEntryParosmiaSeverity parosmiaSeverity;
  final String reaction;

  const TrainingSessionEntry({
    required this.scentName,
    required this.date,
    required this.rating,
    required this.comment,
    required this.parosmiaSeverity,
    required this.reaction,
  });
}

enum TrainingSessionEntryRating { none, weak, normal, heightened, parosmia }

class TrainingSessionRatings {
  static final Map<double, TrainingSessionEntryRating> _ratings = {
    1: TrainingSessionEntryRating.none,
    2: TrainingSessionEntryRating.weak,
    3: TrainingSessionEntryRating.normal,
    4: TrainingSessionEntryRating.heightened,
    5: TrainingSessionEntryRating.parosmia,
  };

  static final Map<TrainingSessionEntryRating, String> _ratingText = {
    TrainingSessionEntryRating.none: "No smell at all",
    TrainingSessionEntryRating.weak: "Slight smell",
    TrainingSessionEntryRating.normal: "Moderate smell",
    TrainingSessionEntryRating.heightened: "Strong smell",
    TrainingSessionEntryRating.parosmia: "I smell something different",
  };

  static String? getRatingText(TrainingSessionEntryRating rating) {
    return _ratingText[rating];
  }

  static getRatings() {
    return _ratings;
  }

  static TrainingSessionEntryRating getRating(double value) {
    return _ratings[value]!;
  }
}
