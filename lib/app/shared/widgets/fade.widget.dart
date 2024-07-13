import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final Widget child;
  final Curve easing;
  final int duration;
  final double scale;

  const FadeAnimation({
    super.key,
    required this.child,
    required this.scale,
    required this.duration,
    required this.easing,
  });

  @override
  FadeAnimationState createState() => FadeAnimationState();
}

class FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _opacityController;
  late AnimationController _scaleController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _opacityController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration,
      ),
      lowerBound: 0,
      upperBound: 1,
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration,
      ),
      lowerBound: 0,
      upperBound: widget.scale,
    );

    _animation = Tween(begin: 0.0, end: 1.0)
        .chain(
          CurveTween(curve: widget.easing),
        )
        .animate(_scaleController);

    _animation.addStatusListener((status) {});
  }

  @override
  void dispose() {
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _opacityController.forward();
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, widget) {
        return ScaleTransition(
          scale: _animation,
          child: Opacity(
            opacity: _opacityController.value,
            child: widget,
          ),
        );
      },
    );
  }
}
