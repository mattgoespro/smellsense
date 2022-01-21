import 'package:hive/hive.dart';
import 'package:smellsense/storage/model/scent_ratings.model.dart';

part 'training_rating.model.g.dart';

@HiveType(typeId: 2)
class TrainingRating extends HiveObject {
  /// Store the training rating for each date.
  ///
  /// For each date, we can have a list of ratings.
  /// Each rating contains a list of the scores for
  /// each scent.
  @HiveField(0)
  Map<String, List<ScentRatings>>? dateRatings;

  TrainingRating() {
    dateRatings = <String, List<ScentRatings>>{};
  }
}
