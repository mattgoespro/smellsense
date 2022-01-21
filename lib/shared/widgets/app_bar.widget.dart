import 'package:flutter/material.dart';

class SmellSenseAppBar extends AppBar {
  SmellSenseAppBar({Key? key})
      : super(
          key: key,
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/images/logos/smell_sense_logo.png',
            width: 100,
            height: 60,
          ),
        );
}
