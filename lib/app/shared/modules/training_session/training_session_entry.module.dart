import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_reaction.module.dart';

class TrainingSessionEntry {
  final DateTime date;
  final TrainingScentName scentName;
  final TrainingSessionEntryRating rating;
  final TrainingSessionEntryParosmiaSeverity parosmiaSeverity;
  final TrainingSessionEntryParosmiaReaction reaction;
  final String comment;

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
  static final Map<int, TrainingSessionEntryRating> _ratings = {
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

  static TrainingSessionEntryRating getRating(num value) {
    return _ratings[value]!;
  }
}
