import 'package:flutter/material.dart';
import 'package:smellsense/app/theme.dart' show AppTheme;

class ActionButtonBorderShape {
  static final rounded = WidgetStateProperty.resolveWith<OutlinedBorder>(
    (states) => RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3),
    ),
  );
}

enum ActionButtonType {
  primary,
  secondary,
}

class ButtonStyles {
  static backgroundColor(ActionButtonType type) =>
      WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return states.contains(WidgetState.disabled)
              ? AppTheme.colors().buttonDisabled
              : AppTheme.colors().buttonPrimary;
        },
      );
}

class ActionButton extends ElevatedButton {
  ActionButton({
    super.key,
    required ActionButtonType type,
    required String text,
    super.onPressed,
    super.autofocus,
    super.clipBehavior,
    super.focusNode,
    super.iconAlignment,
    super.onFocusChange,
    super.onHover,
    super.onLongPress,
    super.statesController,
  }) : super(
          style: ButtonStyle(
            backgroundColor: ButtonStyles.backgroundColor(type),
            shape: ActionButtonBorderShape.rounded,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: type == ActionButtonType.primary
                  ? AppTheme.colors().white
                  : AppTheme.colors().blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
}
