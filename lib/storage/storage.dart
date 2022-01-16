import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smellsense/storage/model/scent_rating.model.dart';
import 'package:smellsense/storage/model/scent_ratings.model.dart';
import 'package:smellsense/storage/model/training_rating.model.dart';

class SmellSenseStorage {
  Box storage;

  Future<void> initStorage() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);

    if (!Hive.isAdapterRegistered(0) &&
        !Hive.isAdapterRegistered(1) &&
        !Hive.isAdapterRegistered(2)) {
      Hive
        ..registerAdapter(ScentRatingAdapter())
        ..registerAdapter(ScentRatingsAdapter())
        ..registerAdapter(TrainingRatingAdapter());
    }

    storage = await Hive.openBox("storage");

    if (!storage.containsKey("trainingRatings")) {
      await storage.put("trainingRatings", TrainingRating());
    }
  }

  Future<void> updateScentSelections(List<String> scentSelections) {
    List<String> scentSelectionHistory = getScentSelectionHistory();
    List<String> newSelectionHistory = [];

    if (scentSelectionHistory == null) {
      newSelectionHistory = scentSelections;
    } else {
      newSelectionHistory = [...scentSelectionHistory, ...scentSelections];
    }

    return storage.put('scentSelections', newSelectionHistory);
  }

  List<String> getScentSelectionHistory() {
    return storage.get("scentSelections")?.cast<String>();
  }

  List<String> getCurrentScentSelections() {
    List<String> scentSelectionHistory = getScentSelectionHistory();

    if (scentSelectionHistory == null) {
      return null;
    }

    return scentSelectionHistory.sublist(
      scentSelectionHistory.length - 4,
      scentSelectionHistory.length,
    );
  }

  Future<void> storeDatedScentRatings(String date, ScentRatings ratings) async {
    TrainingRating trainingRating = storage.get("trainingRatings");

    if (trainingRating.dateRatings[date] == null) {
      trainingRating.dateRatings[date] = [];
    }

    // concatenate scent names in ratings to form ID
    String id = ratings.ratings.map((e) => e.scentName).join();

    // remove all old scent option ratings that are no longer related to
    // the new scent option set
    trainingRating.dateRatings[date].removeWhere((ratings) {
      String ratingId = ratings.ratings.map((e) => e.scentName).join();
      return id != ratingId;
    });

    trainingRating.dateRatings[date].add(ratings);

    return trainingRating.save();
  }

  Map<String, List<ScentRatings>> getDatedScentRatings() {
    Map<String, List<ScentRatings>> datedScentRatings =
        storage.get("trainingRatings").dateRatings;

    return _correctDates(datedScentRatings);
  }

  _correctDates(Map<String, List<ScentRatings>> datedScentRatings) {
    Map<String, List<ScentRatings>> correctedDateScentRatings = {};

    for (String date in datedScentRatings.keys) {
      String dateString = date;

      if (date.length < 10) {
        List<String> dateUnits = date.split('/');
        dateString =
            "${dateUnits[0]}/${int.parse(dateUnits[1]) >= 10 ? dateUnits[1] : "0${dateUnits[1]}"}/${int.parse(dateUnits[2]) >= 10 ? dateUnits[2] : "0${dateUnits[2]}"}";
      }

      correctedDateScentRatings[dateString] = datedScentRatings[date];
    }

    return correctedDateScentRatings;
  }

  List<ScentRatings> getDatedScentRatingsByDate(String date) {
    Map<String, List<ScentRatings>> dateRatings = getDatedScentRatings();
    return dateRatings[date];
  }
}
