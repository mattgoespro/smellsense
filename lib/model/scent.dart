import 'package:flutter/material.dart';
import 'package:smellsense/theme/colors.dart';

class Scent {
  String name;
  Color color;
  String image;

  Scent(this.name, this.color, this.image);

  static final List<Scent> scents = [
    Scent(
      'Lemon',
      ScentColors.lime,
      'assets/images/scents/lemon_1.png',
    ),
    Scent(
      'Rose',
      ScentColors.pink,
      'assets/images/scents/rose_1.png',
    ),
    Scent(
      'Eucalyptus',
      ScentColors.greenDark,
      'assets/images/scents/eucalyptus_1.png',
    ),
    Scent(
      'Clove',
      ScentColors.brownLight,
      'assets/images/scents/clove_1.png',
    ),
    Scent(
      'Orange',
      ScentColors.orange,
      'assets/images/scents/orange_1.png',
    ),
    Scent(
      'Grapefruit',
      ScentColors.red,
      'assets/images/scents/grapefruit_1.png',
    ),
    Scent(
      'Cinnamon',
      ScentColors.brown,
      'assets/images/scents/cinnamon_1.png',
    ),
    Scent(
      'Mint',
      ScentColors.green,
      'assets/images/scents/mint_1.png',
    ),
    Scent(
      'Lavendar',
      ScentColors.purpleDark,
      'assets/images/scents/lavender_1.png',
    ),
    Scent(
      'Citronella',
      ScentColors.limeLight,
      'assets/images/scents/citronella_1.png',
    ),
    Scent(
      'Rosemary',
      ScentColors.purpleLight,
      'assets/images/scents/rosemary_1.png',
    ),
    Scent(
      'Chamomile',
      ScentColors.orangeLight,
      'assets/images/scents/chamomile_1.png',
    ),
    Scent(
      'Tea Tree',
      ScentColors.turquoise,
      'assets/images/scents/teatree_1.png',
    ),
  ];
}
