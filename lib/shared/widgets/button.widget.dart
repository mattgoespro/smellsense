import 'package:flutter/material.dart';
import 'package:smellsense/theme/colors.dart';

class Button extends ElevatedButton {
  Button.primary({Key key, text, onPressed})
      : super(key: key, 
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? AppColors.buttonPrimaryDisabled
                    : AppColors.buttonPrimary;
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
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: onPressed,
        );

  Button.secondary({Key key, text, onPressed})
      : super(key: key, 
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) => Colors.white),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
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
