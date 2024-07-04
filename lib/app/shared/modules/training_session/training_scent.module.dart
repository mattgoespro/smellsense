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

  getDisplay() => TrainingScentDisplay.getScent(name.toString());
}
