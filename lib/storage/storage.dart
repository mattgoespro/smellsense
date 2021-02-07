import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smellsense/storage/model/scent-rating.model.dart';
import 'package:smellsense/storage/model/scent-ratings.model.dart';
import 'package:smellsense/storage/model/training-rating.model.dart';

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

    this.storage = await Hive.openBox("storage");

    if (!storage.containsKey("trainingRatings")) {
      await storage.put("trainingRatings", TrainingRating());
    }
  }

  Future<void> updateScentSelections(List<String> scentSelections) async {
    if (this.storage == null) {
      await this.initStorage();
    }

    List<String> scentSelectionHistory = await this.getScentSelectionHistory();

    if (scentSelectionHistory == null) {
      scentSelectionHistory = scentSelections;
    } else {
      scentSelectionHistory.addAll(scentSelections);
    }

    return storage.put('scentSelections', scentSelectionHistory);
  }

  Future<List<String>> getScentSelectionHistory() async {
    if (this.storage == null) {
      await initStorage();
    }

    return storage.get("scentSelections");
  }

  Future<List<String>> getCurrentScentSelections() async {
    if (this.storage == null) {
      await this.initStorage();
    }

    List<String> scentSelectionHistory = await this.getScentSelectionHistory();

    if (scentSelectionHistory == null) {
      return null;
    }

    return scentSelectionHistory.sublist(
      scentSelectionHistory.length - 4,
      scentSelectionHistory.length,
    );
  }

  Future<void> storeDatedScentRatings(String date, ScentRatings ratings) async {
    if (this.storage == null) {
      await initStorage();
    }

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

  Future<Map<String, List<ScentRatings>>> getDatedScentRatings() async {
    if (this.storage == null) {
      await initStorage();
    }

    return storage.get("trainingRatings").dateRatings;
  }
}
