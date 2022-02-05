import 'package:flutter/material.dart';

class RoundedBorderRect extends StatelessWidget {
  final Color? borderColor;
  final Widget? child;

  const RoundedBorderRect(Key key, {this.borderColor, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Container(
        decoration: BoxDecoration(
          color: borderColor,
          border: Border.all(
            width: 1,
            color: borderColor!,
          ),
          shape: BoxShape.rectangle,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 4,
                color: Colors.white,
              ),
              shape: BoxShape.rectangle,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
