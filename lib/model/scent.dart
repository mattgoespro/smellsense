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
      color: ScentColors.LIME,
      image: 'assets/images/scents/lemon_1.png',
    ),
    Scent(
      name: 'Rose',
      color: ScentColors.PINK,
      image: 'assets/images/scents/rose_1.png',
    ),
    Scent(
      name: 'Eucalyptus',
      color: ScentColors.GREEN_DARK,
      image: 'assets/images/scents/eucalyptus_1.png',
    ),
    Scent(
      name: 'Clove',
      color: ScentColors.BROWN_LIGHT,
      image: 'assets/images/scents/clove_1.png',
    ),
    Scent(
      name: 'Orange',
      color: ScentColors.ORANGE,
      image: 'assets/images/scents/orange_1.png',
    ),
    Scent(
      name: 'Grapefruit',
      color: ScentColors.RED,
      image: 'assets/images/scents/grapefruit_1.png',
    ),
    Scent(
      name: 'Cinnamon',
      color: ScentColors.BROWN,
      image: 'assets/images/scents/cinnamon_1.png',
    ),
    Scent(
      name: 'Mint',
      color: ScentColors.GREEN,
      image: 'assets/images/scents/mint_1.png',
    ),
    Scent(
      name: 'Lavendar',
      color: ScentColors.PURPLE_DARK,
      image: 'assets/images/scents/lavender_1.png',
    ),
    Scent(
      name: 'Citronella',
      color: ScentColors.LIME_LIGHT,
      image: 'assets/images/scents/citronella_1.png',
    ),
    Scent(
      name: 'Rosemary',
      color: ScentColors.PURPLE_LIGHT,
      image: 'assets/images/scents/rosemary_1.png',
    ),
    Scent(
      name: 'Chamomile',
      color: ScentColors.ORANGE_LIGHT,
      image: 'assets/images/scents/chamomile_1.png',
    ),
    Scent(
      name: 'Tea Tree',
      color: ScentColors.TURQOISE,
      image: 'assets/images/scents/teatree_1.png',
    ),
  ];
}
