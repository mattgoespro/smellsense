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
        displayImage: 'assets/scent_png/lemon.png'),
    "rose": TrainingScentDisplay(
        displayName: "Rose",
        displayColor: Color(0xFFF48FB1),
        displayImage: 'assets/scent_png/rose.png'),
    "eucalyptus": TrainingScentDisplay(
        displayName: "Eucalyptus",
        displayColor: Color(0xFF4CAF50),
        displayImage: 'assets/scent_png/eucalyptus.png'),
    "clove": TrainingScentDisplay(
        displayName: "Clove",
        displayColor: Color(0xFFA1887F),
        displayImage: 'assets/scent_png/clove.png'),
    "orange": TrainingScentDisplay(
        displayName: "Orange",
        displayColor: Color(0xFFFFB74D),
        displayImage: 'assets/scent_png/orange.png'),
    "grapefruit": TrainingScentDisplay(
        displayName: "Grapefruit",
        displayColor: Color(0xFFE57373),
        displayImage: 'assets/scent_png/grapefruit.png'),
    "cinnamon": TrainingScentDisplay(
        displayName: "Cinnamon",
        displayColor: Color(0xFF5D4037),
        displayImage: 'assets/scent_png/cinnamon.png'),
    "mint": TrainingScentDisplay(
        displayName: "Mint",
        displayColor: Color(0xFF81C784),
        displayImage: 'assets/scent_png/mint.png'),
    "lavender": TrainingScentDisplay(
        displayName: "Lavender",
        displayColor: Color(0xFFB39DDB),
        displayImage: 'assets/scent_png/lavender.png'),
    "citronella": TrainingScentDisplay(
        displayName: "Citronella",
        displayColor: Color(0xFFC0CA33),
        displayImage: 'assets/scent_png/citronella.png'),
    "rosemary": TrainingScentDisplay(
        displayName: "Rosemary",
        displayColor: Color(0xFF9FA8DA),
        displayImage: 'assets/scent_png/rosemary.png'),
    "chamomile": TrainingScentDisplay(
        displayName: "Chamomile",
        displayColor: Color(0xFFFFE082),
        displayImage: 'assets/scent_png/chamomile.png'),
    "tea-tree": TrainingScentDisplay(
        displayName: "Tea Tree",
        displayColor: Color(0xFF80DEEA),
        displayImage: 'assets/scent_png/teatree.png')
  };
}
