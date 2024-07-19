///
/// Generated from Material Theme Builder
/// https://material-foundation.github.io/material-theme-builder/
///
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006689),
      surfaceTint: Color(0xff006689),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4da7d2),
      onPrimaryContainer: Color(0xff00121b),
      secondary: Color(0xff854e5f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffc2d3),
      onSecondaryContainer: Color(0xff5f2f3f),
      tertiary: Color(0xff4c6079),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd4e5ff),
      onTertiaryContainer: Color(0xff364a62),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff7fafd),
      onSurface: Color(0xff181c1f),
      onSurfaceVariant: Color(0xff3f484e),
      outline: Color(0xff6f787f),
      outlineVariant: Color(0xffbec8cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3134),
      inversePrimary: Color(0xff7ad1fe),
      primaryFixed: Color(0xffc3e8ff),
      onPrimaryFixed: Color(0xff001e2c),
      primaryFixedDim: Color(0xff7ad1fe),
      onPrimaryFixedVariant: Color(0xff004c68),
      secondaryFixed: Color(0xffffd9e2),
      onSecondaryFixed: Color(0xff350c1d),
      secondaryFixedDim: Color(0xfff9b3c7),
      onSecondaryFixedVariant: Color(0xff6a3748),
      tertiaryFixed: Color(0xffd1e4ff),
      onTertiaryFixed: Color(0xff051d33),
      tertiaryFixedDim: Color(0xffb3c8e5),
      onTertiaryFixedVariant: Color(0xff344860),
      surfaceDim: Color(0xffd7dade),
      surfaceBright: Color(0xfff7fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f7),
      surfaceContainer: Color(0xffebeef2),
      surfaceContainerHigh: Color(0xffe5e8ec),
      surfaceContainerHighest: Color(0xffe0e3e6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff7ad1fe),
      surfaceTint: Color(0xff7ad1fe),
      onPrimary: Color(0xff003549),
      primaryContainer: Color(0xff0a7da7),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xffffeff1),
      onSecondary: Color(0xff4f2132),
      secondaryContainer: Color(0xfffbb5c9),
      onSecondaryContainer: Color(0xff572839),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff1d3249),
      tertiaryContainer: Color(0xffc1d6f4),
      onTertiaryContainer: Color(0xff2d4158),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101417),
      onSurface: Color(0xffe0e3e6),
      onSurfaceVariant: Color(0xffbec8cf),
      outline: Color(0xff899299),
      outlineVariant: Color(0xff3f484e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e6),
      inversePrimary: Color(0xff006689),
      primaryFixed: Color(0xffc3e8ff),
      onPrimaryFixed: Color(0xff001e2c),
      primaryFixedDim: Color(0xff7ad1fe),
      onPrimaryFixedVariant: Color(0xff004c68),
      secondaryFixed: Color(0xffffd9e2),
      onSecondaryFixed: Color(0xff350c1d),
      secondaryFixedDim: Color(0xfff9b3c7),
      onSecondaryFixedVariant: Color(0xff6a3748),
      tertiaryFixed: Color(0xffd1e4ff),
      onTertiaryFixed: Color(0xff051d33),
      tertiaryFixedDim: Color(0xffb3c8e5),
      onTertiaryFixedVariant: Color(0xff344860),
      surfaceDim: Color(0xff101417),
      surfaceBright: Color(0xff363a3d),
      surfaceContainerLowest: Color(0xff0b0f11),
      surfaceContainerLow: Color(0xff181c1f),
      surfaceContainer: Color(0xff1c2023),
      surfaceContainerHigh: Color(0xff262a2d),
      surfaceContainerHighest: Color(0xff313538),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );
}

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
