import 'package:flutter/material.dart';

class TrainingScentDisplay {
  final String displayName;
  final Color displayColor;
  final String displayImage;

  const TrainingScentDisplay({
    required this.displayName,
    required this.displayColor,
    required this.displayImage,
  });

  static TrainingScentDisplay getScent(String scent) => _scents[scent]!;

  static List<TrainingScentDisplay> getScents() => _scents.values.toList();

  static const Map<String, TrainingScentDisplay> _scents = {
    "lemon": TrainingScentDisplay(
        displayName: 'Lemon',
        displayColor: Color(0xFFD4E157),
        displayImage: 'assets/images/scents/lemon_1.png'),
    "rose": TrainingScentDisplay(
        displayName: "Rose",
        displayColor: Color(0xFFF48FB1),
        displayImage: 'assets/images/scents/rose_1.png'),
    "eucalyptus": TrainingScentDisplay(
        displayName: "Eucalyptus",
        displayColor: Color(0xFF4CAF50),
        displayImage: 'assets/images/scents/eucalyptus_1.png'),
    "clove": TrainingScentDisplay(
        displayName: "Clove",
        displayColor: Color(0xFFA1887F),
        displayImage: 'assets/images/scents/clove_1.png'),
    "orange": TrainingScentDisplay(
        displayName: "Orange",
        displayColor: Color(0xFFFFB74D),
        displayImage: 'assets/images/scents/orange_1.png'),
    "grapefruit": TrainingScentDisplay(
        displayName: "Grapefruit",
        displayColor: Color(0xFFE57373),
        displayImage: 'assets/images/scents/grapefruit_1.png'),
    "cinnamon": TrainingScentDisplay(
        displayName: "Cinnamon",
        displayColor: Color(0xFF5D4037),
        displayImage: 'assets/images/scents/cinnamon_1.png'),
    "mint": TrainingScentDisplay(
        displayName: "Mint",
        displayColor: Color(0xFF81C784),
        displayImage: 'assets/images/scents/mint_1.png'),
    "lavender": TrainingScentDisplay(
        displayName: "Lavender",
        displayColor: Color(0xFFB39DDB),
        displayImage: 'assets/images/scents/lavender_1.png'),
    "citronella": TrainingScentDisplay(
        displayName: "Citronella",
        displayColor: Color(0xFFC0CA33),
        displayImage: 'assets/images/scents/citronella_1.png'),
    "rosemary": TrainingScentDisplay(
        displayName: "Rosemary",
        displayColor: Color(0xFF9FA8DA),
        displayImage: 'assets/images/scents/rosemary_1.png'),
    "chamomile": TrainingScentDisplay(
        displayName: "Chamomile",
        displayColor: Color(0xFFFFE082),
        displayImage: 'assets/images/scents/chamomile_1.png'),
    "tea-tree": TrainingScentDisplay(
        displayName: "Tea Tree",
        displayColor: Color(0xFF80DEEA),
        displayImage: 'assets/images/scents/teatree_1.png')
  };
}
