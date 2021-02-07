import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:smellsense/model/scent.dart';
import 'package:smellsense/model/training.dart';
import 'package:smellsense/shared/widgets/button.widget.dart';
import 'package:smellsense/shared/widgets/fade.dart';
import 'package:smellsense/shared/widgets/rounded-border-rect.dart';
import 'package:smellsense/theme/colors.dart';

class TrainScent extends StatefulWidget {
  final Scent scent;
  final Function onAnswer;
  final Function onTimerStatusChange;
  final answers;

  TrainScent({
    this.scent,
    this.answers,
    this.onAnswer,
    this.onTimerStatusChange,
  });

  @override
  _TrainScentState createState() => _TrainScentState();
}

class _TrainScentState extends State<TrainScent>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CountDownController _controller = CountDownController();
  bool _trainingTimerDone = true;
  bool _firstStart = true;
  bool _encouragementVisible = false;
  int _encouragement = 0;

  @override
  bool get wantKeepAlive => true;

  Widget get _timerWidget => Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (this._trainingTimerDone)
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: RaisedButton(
                  color: AppColors.BUTTON_PRIMARY,
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 50,
                    ),
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                  onPressed: () {
                    setState(() {
                      this._trainingTimerDone = false;
                      this._firstStart = false;
                      this._encouragementVisible = true;
                    });

                    widget.onTimerStatusChange(this._trainingTimerDone);
                  },
                ),
              )
            else
              CircularCountDownTimer(
                controller: this._controller,
                duration: 20,
                width: double.infinity,
                height: double.infinity,
                fillColor: Colors.white,
                color: Colors.blue,
                textFormat: CountdownTextFormat.SS,
                isReverse: true,
                onComplete: () {
                  setState(() {
                    this._trainingTimerDone = true;
                  });

                  widget.onTimerStatusChange(this._trainingTimerDone);
                },
              ),
          ],
        ),
      );

  Widget get _answersWidget => FadeAnimation(
        reverse: false,
        child: Column(
          children: [
            for (String option in Training.answerOptions)
              Expanded(
                child: RadioListTile(
                  title: Text(
                    option,
                  ),
                  value: option,
                  groupValue: widget.answers[widget.scent.name],
                  onChanged: !this._trainingTimerDone
                      ? null
                      : (answer) {
                          setState(() {
                            widget.onAnswer(widget.scent, answer);
                          });
                        },
                ),
              ),
          ],
        ),
      );

  Widget get _titleWidget => Text(
        widget.scent.name,
        style: TextStyle(
          color: widget.scent.color,
          fontWeight: FontWeight.w100,
          fontSize: Theme.of(context).textTheme.headline3.fontSize,
        ),
      );

  Widget get imageWidget => RoundedBorderRect(
        borderColor: widget.scent.color,
        child: Image.asset(
          widget.scent.image,
          scale: 4,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          this._titleWidget,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: this.imageWidget,
          ),
          if (this._trainingTimerDone && !this._firstStart)
            FadeAnimation(
              reverse: false,
              child: Button.primary(
                text: 'Restart',
                onPressed: () {
                  setState(() {
                    this._trainingTimerDone = true;
                    this._firstStart = true;
                    this._encouragementVisible = false;
                  });
                },
              ),
            )
          else ...[
            if (this._encouragementVisible)
              Expanded(
                child: Center(
                  child: FadeAnimation(
                    child: Text(
                      Training.encouragements[this._encouragement],
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    reverse: true,
                    waitSecondsBetween: 3,
                    onComplete: () {
                      setState(() {
                        this._encouragementVisible = true;
                        this._encouragement = (this._encouragement + 1) %
                            Training.encouragements.length;
                      });
                    },
                  ),
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Container(
                    child: Text(
                      'Press the timer\nto start...',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: this._timerWidget,
            )
          ],
          if (this._trainingTimerDone && !this._firstStart)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 5,
                  bottom: 12,
                ),
                child: this._answersWidget,
              ),
            )
        ],
      ),
    );
  }
}
