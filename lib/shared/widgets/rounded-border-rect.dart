import 'package:flutter/material.dart';

class RoundedBorderRect extends StatelessWidget {
  final Color borderColor;
  final Widget child;

  RoundedBorderRect({this.borderColor, this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        decoration: BoxDecoration(
          color: borderColor,
          border: Border.all(
            width: 1,
            color: borderColor,
          ),
          shape: BoxShape.rectangle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 4,
                color: Colors.white,
              ),
              shape: BoxShape.rectangle,
            ),
            child: this.child,
          ),
        ),
      ),
    );
  }
}
