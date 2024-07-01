import 'package:smellsense/app/db/entities/training_scent.entity.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent_display.module.dart';

enum TrainingScentName {
  lemon("lemon"),
  rose("rose"),
  eucalyptus("eucalyptus"),
  clove("clove"),
  orange("orange"),
  grapefruit("grapefruit"),
  cinnamon("cinnamon"),
  mint("mint"),
  lavender("lavender"),
  citronella("citronella"),
  rosemary("rosemary"),
  chamomile("chamomile"),
  teaTree("teaTree");

  final String name;

  const TrainingScentName(this.name);

  static fromString(String name) {
    return TrainingScentName.values.firstWhere(
      (element) => element.name == name,
    );
  }

  @override
  toString() => name;
}

class TrainingScent {
  final TrainingScentName name;

  TrainingScent({
    required this.name,
  });

  static TrainingScent fromEntity(TrainingScentEntity entity) =>
      TrainingScent(name: TrainingScentName.fromString(entity.name));

  getDisplay() => TrainingScentDisplay.getScent(name.toString());
}
