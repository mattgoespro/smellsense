import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SmellSenseAppBar extends AppBar {
  SmellSenseAppBar({Key? key})
      : super(
          key: key,
          toolbarHeight: 50,
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: SvgPicture.asset(
            'assets/svg/smellsense_logo.svg',
            width: 30,
          ),
        );
}
