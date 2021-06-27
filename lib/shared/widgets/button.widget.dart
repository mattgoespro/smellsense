import 'package:flutter/material.dart';
import 'package:smellsense/theme/colors.dart';

class Button extends ElevatedButton {
  Button.primary({text, onPressed})
      : super(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? AppColors.BUTTON_PRIMARY_DISABLED
                    : AppColors.BUTTON_PRIMARY;
              },
            ),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: onPressed,
        );

  Button.secondary({text, onPressed})
      : super(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) => Colors.white),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (states) => RoundedRectangleBorder(
                side: BorderSide(color: AppColors.BLUE, width: 2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: onPressed,
        );
}
