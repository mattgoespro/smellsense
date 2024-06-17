import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

class SmellSenseAppBar extends AppBar {
  SmellSenseAppBar({super.key})
      : super(
          toolbarHeight: 50,
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: SvgPicture.asset(
            'assets/svg/smellsense_logo.svg',
            width: 30,
          ),
        );
}
