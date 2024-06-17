import 'package:flutter/material.dart';
import 'package:smellsense/theme/colors.dart' show AppColors;

class Button extends ElevatedButton {
  Button.primary({super.key, required text, super.onPressed})
      : super(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                return states.contains(WidgetState.disabled)
                    ? AppColors.buttonPrimaryDisabled
                    : AppColors.buttonPrimary;
              },
            ),
            shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        );

  Button.secondary({super.key, required text, super.onPressed})
      : super(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) => Colors.white),
            shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
              (states) => RoundedRectangleBorder(
                side: BorderSide(color: AppColors.blue, width: 2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
}
