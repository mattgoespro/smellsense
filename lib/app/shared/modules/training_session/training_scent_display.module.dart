import 'package:flutter/material.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';

class TrainingScentDisplay {
  final TrainingScentName name;
  final String displayName;
  final Color displayColor;
  final String displayImage;

  const TrainingScentDisplay({
    required this.name,
    required this.displayName,
    required this.displayColor,
    required this.displayImage,
  });

  static TrainingScentDisplay getScent(TrainingScentName scent) =>
      _scents[scent]!;

  static List<TrainingScentDisplay> getScents() => _scents.values.toList();

  static const Map<TrainingScentName, TrainingScentDisplay> _scents = {
    TrainingScentName.cinnamon: TrainingScentDisplay(
      name: TrainingScentName.cinnamon,
      displayName: "Cinnamon",
      displayColor: Color(0xFF5D4037),
      displayImage: 'assets/scent_png/cinnamon.png',
    ),
    TrainingScentName.citronella: TrainingScentDisplay(
      name: TrainingScentName.citronella,
      displayName: "Citronella",
      displayColor: Color(0xFFC0CA33),
      displayImage: 'assets/scent_png/citronella.png',
    ),
    TrainingScentName.chamomile: TrainingScentDisplay(
      name: TrainingScentName.chamomile,
      displayName: "Chamomile",
      displayColor: Color(0xFFFFE082),
      displayImage: 'assets/scent_png/chamomile.png',
    ),
    TrainingScentName.clove: TrainingScentDisplay(
      name: TrainingScentName.clove,
      displayName: "Clove",
      displayColor: Color(0xFFA1887F),
      displayImage: 'assets/scent_png/clove.png',
    ),
    TrainingScentName.eucalyptus: TrainingScentDisplay(
      name: TrainingScentName.eucalyptus,
      displayName: "Eucalyptus",
      displayColor: Color(0xFF4CAF50),
      displayImage: 'assets/scent_png/eucalyptus.png',
    ),
    TrainingScentName.garlic: TrainingScentDisplay(
      name: TrainingScentName.garlic,
      displayName: "Garlic",
      displayColor: Color(0xFF8D6E63),
      displayImage: 'assets/scent_png/garlic.png',
    ),
    TrainingScentName.grapefruit: TrainingScentDisplay(
      name: TrainingScentName.grapefruit,
      displayName: "Grapefruit",
      displayColor: Color(0xFFE57373),
      displayImage: 'assets/scent_png/grapefruit.png',
    ),
    TrainingScentName.lavender: TrainingScentDisplay(
      name: TrainingScentName.lavender,
      displayName: "Lavender",
      displayColor: Color(0xFFB39DDB),
      displayImage: 'assets/scent_png/lavender.png',
    ),
    TrainingScentName.lemon: TrainingScentDisplay(
      name: TrainingScentName.lemon,
      displayName: 'Lemon',
      displayColor: Color(0xFFD4E157),
      displayImage: 'assets/scent_png/lemon.png',
    ),
    TrainingScentName.rose: TrainingScentDisplay(
      name: TrainingScentName.rose,
      displayName: "Rose",
      displayColor: Color(0xFFF48FB1),
      displayImage: 'assets/scent_png/rose.png',
    ),
    TrainingScentName.mint: TrainingScentDisplay(
      name: TrainingScentName.mint,
      displayName: "Mint",
      displayColor: Color(0xFF81C784),
      displayImage: 'assets/scent_png/mint.png',
    ),
    TrainingScentName.orange: TrainingScentDisplay(
      name: TrainingScentName.orange,
      displayName: "Orange",
      displayColor: Color(0xFFFFB74D),
      displayImage: 'assets/scent_png/orange.png',
    ),
    TrainingScentName.rosemary: TrainingScentDisplay(
      name: TrainingScentName.rosemary,
      displayName: "Rosemary",
      displayColor: Color(0xFF9FA8DA),
      displayImage: 'assets/scent_png/rosemary.png',
    ),
    TrainingScentName.teaTree: TrainingScentDisplay(
        name: TrainingScentName.teaTree,
        displayName: "Tea Tree",
        displayColor: Color(0xFF80DEEA),
        displayImage: 'assets/scent_png/teatree.png')
  };
}
