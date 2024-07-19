import 'package:flutter/material.dart';

class FadeAndScale extends StatefulWidget {
  final Widget child;
  final AnimationController? controller;
  final bool fade;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final bool scale;
  final double initialScale;
  final double endScale;
  final void Function() onComplete;

  const FadeAndScale({
    super.key,
    required this.child,
    required this.onComplete,
    this.controller,
    this.fade = true,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.fadeOutDuration = const Duration(milliseconds: 300),
    this.initialScale = 0,
    this.endScale = 1,
    this.scale = true,
  });

  @override
  FadeAndScaleState createState() => FadeAndScaleState();
}

class FadeAndScaleState extends State<FadeAndScale>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(
          duration: widget.fadeInDuration,
          vsync: this,
          reverseDuration: widget.fadeOutDuration,
        );

    _controller.forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.initialScale,
      end: widget.endScale,
    ).animate(_fadeAnimation);

    _fadeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
        dispose();
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
        alignment: Alignment.center,
        child: animatedWidget,
      );
    }

    return animatedWidget;
  }
}
