import 'package:flutter/material.dart';
import 'package:smellsense/theme/colors.dart';

class Button extends ElevatedButton {
  Button.primary({Key? key, required text, onPressed})
      : super(
          key: key,
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
          onPressed: onPressed,
        );

  Button.secondary({Key? key, required text, onPressed})
      : super(
          key: key,
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
          onPressed: onPressed,
        );
}
