import 'package:flutter/material.dart';

class AppTheme {
  static _Colors colors() => _Colors();
}

class _Colors {
  final Color white = const Color(0xFFF0F0F0);
  final Color orange = const Color(0xFFFFB74D);
  final Color orangeLight = const Color(0xFFFFE082);
  final Color lime = const Color(0xFFD4E157);
  final Color limeLight = const Color(0xFFC0CA33);
  final Color red = const Color(0xFFE57373);
  final Color brown = const Color(0xFF5D4037);
  final Color brownLight = const Color(0xFFA1887F);
  final Color green = const Color(0xFF81C784);
  final Color pink = const Color(0xFFF48FB1);
  final Color purpleDark = const Color(0xFFB39DDB);
  final Color purpleLight = const Color(0xFF9FA8DA);
  final Color turquoise = const Color(0xFF80DEEA);
  final Color greenDark = const Color(0xFF4CAF50);
  final Color blue = Colors.blue;
  final Color blueLight = Colors.blue.shade100;
  late final Color buttonPrimary = blue;
  late final Color buttonDisabled = blueLight;
  final Color error = Colors.red.shade700;
}
