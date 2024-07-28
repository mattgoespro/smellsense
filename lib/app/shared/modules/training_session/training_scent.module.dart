import 'package:smellsense/app/shared/modules/training_session/training_scent_display.module.dart';

enum TrainingScentName {
  chamomile("chamomile"),
  cinnamon("cinnamon"),
  citronella("citronella"),
  clove("clove"),
  eucalyptus("eucalyptus"),
  garlic("garlic"),
  grapefruit("grapefruit"),
  lavender("lavender"),
  lemon("lemon"),
  mint("mint"),
  orange("orange"),
  rose("rose"),
  rosemary("rosemary"),
  teaTree("teaTree");

  final String scentName;

  const TrainingScentName(this.scentName);

  static fromString(String name) {
    return TrainingScentName.values.firstWhere(
      (element) => element.scentName == name,
    );
  }

  @override
  toString() => scentName;
}

class TrainingScent {
  static const maxTrainingScents = 4;

  TrainingScentName name;

  TrainingScent({
    required this.name,
  });

  TrainingScent.fromName(String name)
      : name = TrainingScentName.fromString(name);

  getDisplay() => TrainingScentDisplay.getScent(name);
}
