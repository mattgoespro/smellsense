import 'package:flutter/material.dart';

class WidgetThemeData {
  static ButtonThemeData getButtonThemeData(ColorScheme colorScheme) =>
      ButtonThemeData(
        buttonColor: colorScheme.primary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
        ),
        colorScheme: colorScheme,
        height: 48,
        hoverColor: colorScheme.primaryContainer,
        disabledColor: colorScheme.surfaceDim,
        focusColor: colorScheme.primaryContainer,
        highlightColor: colorScheme.primaryContainer,
        layoutBehavior: ButtonBarLayoutBehavior.padded,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        splashColor: colorScheme.primaryContainer,
      );

  static CheckboxThemeData getCheckboxThemeData(ColorScheme colorScheme) =>
      CheckboxThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.onSurface
                  .withOpacity(0.38); // Checked and disabled
            }
            return colorScheme.onSurface
                .withOpacity(0.12); // Unchecked and disabled
          }

          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary; // Checked
          }

          return Colors.transparent; // Default unchecked state
        }),
        checkColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled) &&
                states.contains(WidgetState.selected)) {
              return colorScheme.onSurface
                  .withOpacity(0.54); // Checked and disabled
            }

            if (states.contains(WidgetState.selected)) {
              return colorScheme.onPrimary; // Checked
            }
            return Colors.transparent; // Default unchecked state
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) => Colors.grey.shade300,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: BorderSide(
          color: colorScheme.primary,
          width: 1,
        ),
      );

  static SnackBarThemeData getSnackBarThemeData(
          ColorScheme colorScheme, TextTheme textTheme) =>
      SnackBarThemeData(
        backgroundColor: Colors.grey.shade900,
        contentTextStyle: textTheme.displaySmall,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        behavior: SnackBarBehavior.floating,
        actionTextColor: colorScheme.onTertiaryContainer,
        dismissDirection: DismissDirection.none,
      );
}
