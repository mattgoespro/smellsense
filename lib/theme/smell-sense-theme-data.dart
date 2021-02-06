class SmellSenseThemeData {
  static String primaryTextColor = "rgb(120, 144, 156)";
  final String secondaryTextColor = "rgb(38, 50, 56)";

  static int extractRGB(String rgb, int rgbIndex) {
    return rgb.substring(3).split(', ')[rgbIndex] as int;
  }
}
