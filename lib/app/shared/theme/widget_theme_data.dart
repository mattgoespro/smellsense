import 'package:flutter/material.dart';

class WidgetThemeData {
  static TextButtonThemeData getTextButtonTheme(
      ColorScheme colorScheme, TextTheme textTheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: textTheme.displaySmall,
      ),
    );
  }

  static OutlinedButtonThemeData getOutlinedButtonTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStateProperty.resolveWith<BorderSide>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(
              color: colorScheme.onSurface
                  .withAlpha(40), // Grey color when disabled
              width: 1,
            );
          }
          return BorderSide(
            color: colorScheme.primary,
            width: 1,
          );
        }),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
          (Set<WidgetState> states) {
            double borderWidth = 1.0;
            BorderRadius borderRadius = BorderRadius.circular(4);

            if (states.contains(WidgetState.disabled)) {
              return RoundedRectangleBorder(
                borderRadius: borderRadius,
                side: BorderSide(
                  color: colorScheme.outlineVariant,
                  width: borderWidth,
                ),
              );
            }

            return RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: BorderSide(
                color: colorScheme.outlineVariant,
                width: borderWidth,
              ),
            );
          },
        ),
      ),
    );
  }

  static CheckboxThemeData getCheckboxThemeData(ColorScheme colorScheme) =>
      CheckboxThemeData(
        checkColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            bool isDisabled = states.contains(WidgetState.disabled);
            bool isChecked = states.contains(WidgetState.selected);

            if (isDisabled) {
              return isChecked
                  ? colorScheme.primaryContainer.withAlpha(80)
                  : colorScheme.surfaceContainer;
            }

            if (isChecked) {
              return colorScheme.primaryContainer;
            }

            return colorScheme.surface;
          },
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
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) =>
      SnackBarThemeData(
        backgroundColor: colorScheme.secondaryContainer,
        contentTextStyle: textTheme.displaySmall,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        behavior: SnackBarBehavior.floating,
        actionTextColor: colorScheme.onSecondaryContainer,
        dismissDirection: DismissDirection.none,
      );

  static ListTileThemeData getListTileThemeData(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return ListTileThemeData(
      tileColor: colorScheme.surface,
      iconColor: colorScheme.onSurface,
      textColor: colorScheme.onSurface,
      selectedColor: colorScheme.onPrimary,
      horizontalTitleGap: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      style: ListTileStyle.list,
    );
  }
}
