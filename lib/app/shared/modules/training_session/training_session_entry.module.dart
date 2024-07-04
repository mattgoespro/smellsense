import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_rating.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_reaction.module.dart';

class TrainingSessionEntry {
  final TrainingScent scent;
  final TrainingSessionEntryRating rating;
  final TrainingSessionEntryParosmiaSeverity parosmiaSeverity;
  final TrainingSessionEntryParosmiaReaction reaction;
  final String comment;

  const TrainingSessionEntry({
    required this.scent,
    required this.rating,
    required this.comment,
    required this.parosmiaSeverity,
    required this.reaction,
  });
}
