import 'package:flutter/material.dart';
import 'package:smellsense/theme/colors.dart';

class Scent {
  String name;
  Color color;
  String image;

  Scent({this.color, this.name, this.image});

  static final List<Scent> scents = [
    Scent(
      name: 'Lemon',
      color: ScentColors.lime,
      image: 'assets/images/scents/lemon_1.png',
    ),
    Scent(
      name: 'Rose',
      color: ScentColors.pink,
      image: 'assets/images/scents/rose_1.png',
    ),
    Scent(
      name: 'Eucalyptus',
      color: ScentColors.greenDark,
      image: 'assets/images/scents/eucalyptus_1.png',
    ),
    Scent(
      name: 'Clove',
      color: ScentColors.brownLight,
      image: 'assets/images/scents/clove_1.png',
    ),
    Scent(
      name: 'Orange',
      color: ScentColors.orange,
      image: 'assets/images/scents/orange_1.png',
    ),
    Scent(
      name: 'Grapefruit',
      color: ScentColors.red,
      image: 'assets/images/scents/grapefruit_1.png',
    ),
    Scent(
      name: 'Cinnamon',
      color: ScentColors.brown,
      image: 'assets/images/scents/cinnamon_1.png',
    ),
    Scent(
      name: 'Mint',
      color: ScentColors.green,
      image: 'assets/images/scents/mint_1.png',
    ),
    Scent(
      name: 'Lavendar',
      color: ScentColors.purpleDark,
      image: 'assets/images/scents/lavender_1.png',
    ),
    Scent(
      name: 'Citronella',
      color: ScentColors.limeLight,
      image: 'assets/images/scents/citronella_1.png',
    ),
    Scent(
      name: 'Rosemary',
      color: ScentColors.purpleLight,
      image: 'assets/images/scents/rosemary_1.png',
    ),
    Scent(
      name: 'Chamomile',
      color: ScentColors.orangeLight,
      image: 'assets/images/scents/chamomile_1.png',
    ),
    Scent(
      name: 'Tea Tree',
      color: ScentColors.turquoise,
      image: 'assets/images/scents/teatree_1.png',
    ),
  ];
}
