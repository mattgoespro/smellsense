import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_parosmia_reaction.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_rating.module.dart';

class TrainingSessionEntry {
  final TrainingScent scent;
  final TrainingSessionEntryRating rating;
  final TrainingSessionEntryParosmiaReactionSeverity? parosmiaReactionSeverity;
  final TrainingSessionEntryParosmiaReaction? parosmiaReaction;
  final String? comment;

  const TrainingSessionEntry({
    required this.scent,
    required this.rating,
    required this.comment,
    required this.parosmiaReaction,
    required this.parosmiaReactionSeverity,
  });
}
