import 'package:flutter/material.dart';
import 'package:smellsense/app/shared/theme/theme.dart';

class VerticalEllipses extends StatelessWidget {
  const VerticalEllipses({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme.of(context);
    Padding box = Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withAlpha(80),
          shape: BoxShape.circle,
        ),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        box,
        box,
        box,
      ],
    );
  }
}
