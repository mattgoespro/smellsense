import 'package:flutter/material.dart';

class TrainingSessionEntryRatingFormTimerWidget extends StatefulWidget {
  final int time;
  final void Function() onStartFn;
  final void Function() onCompleteFn;
  final Widget replaceDoneTimerWidget;

  const TrainingSessionEntryRatingFormTimerWidget({
    super.key,
    required this.time,
    required this.onStartFn,
    required this.onCompleteFn,
    required this.replaceDoneTimerWidget,
  });

  @override
  State<TrainingSessionEntryRatingFormTimerWidget> createState() =>
      TrainingSessionEntryRatingFormTimerWidgetState();
}

class TrainingSessionEntryRatingFormTimerWidgetState
    extends State<TrainingSessionEntryRatingFormTimerWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Stack(
              children: [
                if (controller.isAnimating) ...[
                  CircularProgressIndicator(
                    value: controller.value,
                    strokeCap: StrokeCap.round,
                  ),
                  Text(
                    controller.value.toStringAsFixed(2),
                  )
                ],
                if (!controller.isAnimating) widget.replaceDoneTimerWidget
              ],
            ),
          ),
          if (controller.isCompleted)
            TextButton(
              onPressed: () {
                controller.reset();
              },
              child: const Text('Start'),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.time,
      ),
      lowerBound: 0,
      upperBound: widget.time.toDouble(),
    )..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.completed:
            widget.onCompleteFn();
            break;
          case AnimationStatus.forward:
            widget.onStartFn();
            break;
          case AnimationStatus.dismissed:
            widget.onStartFn();
            break;
          default:
            break;
        }
      });
  }
}
