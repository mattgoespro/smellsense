import 'package:hive/hive.dart';

part 'scent-rating.model.g.dart';

@HiveType(typeId: 0)
class ScentRating extends HiveObject {
  @HiveField(0)
  String scentName;

  @HiveField(1)
  int rating;

  ScentRating(this.scentName, this.rating);
}
