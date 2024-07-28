enum TrainingSessionEntryRating {
  none,
  weak,
  normal,
  heightened,
  parosmia,
}

class TrainingSessionEntryRatings {
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
