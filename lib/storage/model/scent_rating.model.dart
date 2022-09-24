import 'package:hive/hive.dart';

part 'scent_rating.model.g.dart';

@HiveType(typeId: 0)
class ScentRating extends HiveObject {
  @HiveField(0)
  String scentName;

  @HiveField(1)
  int rating;

  @HiveField(2)
  String? comment;

  @HiveField(3)
  String? severity;

  @HiveField(4)
  int? feeling;

  ScentRating(
    this.scentName,
    this.rating,
    this.comment,
    this.severity,
    this.feeling,
  );

  @override
  String toString() {
    return '($scentName, $rating, $comment, $severity, $feeling)';
  }
}
