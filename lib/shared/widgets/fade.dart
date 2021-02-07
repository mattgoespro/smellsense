import 'dart:async';

import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final Widget child;
  final bool reverse;
  final int waitSecondsBetween;
  Function onComplete;

  FadeAnimation(
      {this.child,
      @required this.reverse,
      this.waitSecondsBetween,
      this.onComplete});

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    this._controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    this._animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(this._controller);

    this._animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed && widget.reverse) {
        Timer(Duration(seconds: widget.waitSecondsBetween), () {
          if (mounted) {
            this._controller.reverse();
          }
        });
      } else if (status == AnimationStatus.dismissed) {
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this._controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
