import 'package:flutter/material.dart';

class FadeAnimate extends StatefulWidget {
  final Widget child;
  final Duration fadeInDuration;
  final Duration? fadeOutDuration;
  final Duration? idleDuration;
  final void Function()? onComplete;

  const FadeAnimate({
    super.key,
    required this.child,
    required this.fadeInDuration,
    this.fadeOutDuration = Duration.zero,
    this.idleDuration = Duration.zero,
    this.onComplete,
  });

  @override
  FadeAnimateState createState() => FadeAnimateState();
}

class FadeAnimateState extends State<FadeAnimate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool shouldIdle() => widget.idleDuration != Duration.zero;

  bool shouldFadeOut() => widget.fadeOutDuration != Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.fadeInDuration +
          widget.idleDuration! +
          widget.fadeOutDuration!,
    )..forward();

    List<TweenSequenceItem<double>> tweenSequenceItems = [
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 1),
        weight: widget.fadeInDuration.inMilliseconds.toDouble(),
      ),
    ];

    if (shouldIdle()) {
      tweenSequenceItems.add(
        TweenSequenceItem(
          tween: ConstantTween(1.0),
          weight: widget.idleDuration!.inMilliseconds.toDouble() / 1000,
        ),
      );
    }

    if (shouldFadeOut()) {
      tweenSequenceItems.add(
        TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 0.0),
          weight: widget.fadeOutDuration!.inMilliseconds.toDouble(),
        ),
      );
    }
    _animation = TweenSequence<double>(tweenSequenceItems).animate(_controller);

    if (widget.onComplete != null) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();

          if (shouldFadeOut()) {
            _controller.forward();
          }

          if (widget.onComplete != null) {
            widget.onComplete!();
          }
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
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
