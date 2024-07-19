import 'package:flutter/material.dart';

class AnimationSequence extends StatefulWidget {
  final List<Widget> children;
  final Duration duration;

  const AnimationSequence({
    super.key,
    required this.children,
    required this.duration,
  });

  @override
  AnimationSequenceState createState() => AnimationSequenceState();
}

class AnimationSequenceState extends State<AnimationSequence>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_fadeAnimation);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_currentIndex < widget.children.length - 1) {
          setState(() {
            _currentIndex++;
            _controller.reset();
            _controller.forward();
          });
        }
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _currentIndex < widget.children.length
          ? FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: widget.children[_currentIndex],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
