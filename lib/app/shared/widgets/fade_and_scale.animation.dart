import 'package:flutter/material.dart';

class FadeAndScale extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool fade;
  final bool scale;
  final double initialScale;
  final double endScale;
  final void Function() onComplete;

  const FadeAndScale({
    super.key,
    required this.child,
    required this.duration,
    required this.onComplete,
    this.fade = true,
    this.initialScale = 0,
    this.endScale = 1,
    this.scale = true,
  });

  @override
  FadeAndScaleState createState() => FadeAndScaleState();
}

class FadeAndScaleState extends State<FadeAndScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.initialScale,
      end: widget.endScale,
    ).animate(_fadeAnimation);

    _scaleAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
        _controller.dispose();
      }
    });

    _scaleAnimation.addListener(() {
      setState(() => widget.onComplete());
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedWidget = widget.child;

    if (widget.fade) {
      animatedWidget = FadeTransition(
        opacity: _fadeAnimation,
        child: animatedWidget,
      );
    }

    if (widget.scale) {
      animatedWidget = ScaleTransition(
        scale: _scaleAnimation,
        child: animatedWidget,
      );
    }

    return animatedWidget;
  }
}
