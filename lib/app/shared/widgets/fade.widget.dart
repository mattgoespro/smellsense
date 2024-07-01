import 'dart:async';

import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final Widget? child;
  final bool reverse;
  final int? waitSecondsBetween;
  final Function? onComplete;

  const FadeAnimation(
      {super.key,
      this.child,
      required this.reverse,
      this.waitSecondsBetween,
      this.onComplete});

  @override
  FadeAnimationState createState() => FadeAnimationState();
}

class FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed && widget.reverse) {
        Timer(Duration(seconds: widget.waitSecondsBetween!), () {
          if (mounted) {
            _controller.reverse();
          }
        });
      } else if (status == AnimationStatus.dismissed) {
        widget.onComplete!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
