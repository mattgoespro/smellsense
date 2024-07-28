import 'package:flutter/material.dart';

class ScaleAnimate extends StatefulWidget {
  final Widget child;
  final double initialScale;
  final double finalScale;
  final Duration duration;
  final void Function()? onComplete;

  const ScaleAnimate({
    super.key,
    required this.child,
    required this.initialScale,
    required this.finalScale,
    required this.duration,
    this.onComplete,
  });

  @override
  ScaleAnimateState createState() => ScaleAnimateState();
}

class ScaleAnimateState extends State<ScaleAnimate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _animation = Tween<double>(
      begin: widget.initialScale,
      end: widget.finalScale,
    ).animate(_controller);

    if (widget.onComplete != null) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete!();
          _controller.reset();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
