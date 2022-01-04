import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smellsense/model/feeling.dart';
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
  String _answer;
  String _comment;
  String _severity;
  int _feelingIndex;

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
                ringColor: Colors.blue,
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
                          this._answer = answer;
                          this._comment = null;
                          this._severity = null;
                          this._feelingIndex = null;

                          setState(() {
                            widget.onAnswer(
                              widget.scent,
                              this._answer,
                              this._comment,
                              this._severity,
                              this._feelingIndex,
                            );
                          });

                          int answerIndex =
                              Training.answerOptions.indexOf(answer);

                          this._showAddCommentDialog(answerIndex == 1);
                        },
                ),
              ),
          ],
        ),
      );

  void _showAddCommentDialog(bool parosmia) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          titlePadding: EdgeInsets.only(top: 10),
          title: Column(
            children: [
              Center(
                child: Text(
                  parosmia ? 'Parosmia' : 'Add a comment',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
              Divider(
                color: Colors.black,
              )
            ],
          ),
          children: [
            if (parosmia) ...[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RichText(
                    text: TextSpan(
                      text: 'Severity',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize:
                            Theme.of(context).textTheme.headline6.fontSize,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: AppColors.ERROR,
                            fontWeight: FontWeight.w300,
                            fontSize:
                                Theme.of(context).textTheme.headline6.fontSize,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              for (int i = 0; i < Training.severities.length; i++)
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: RadioListTile(
                    title: Text(
                      Training.severities[i],
                    ),
                    groupValue: this._severity,
                    value: Training.severities[i],
                    onChanged: (value) {
                      setState(() => this._severity = value);
                    },
                  ),
                ),
              Divider(
                color: Colors.black,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'How are you feeling?',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                    ),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: AppColors.ERROR,
                          fontWeight: FontWeight.w300,
                          fontSize:
                              Theme.of(context).textTheme.headline6.fontSize,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < Feeling.feelings.length; i++)
                    Flexible(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          IconButton(
                            onPressed: () => setState(
                              () => this._feelingIndex = i,
                            ),
                            icon: SvgPicture.asset(
                              Feeling.feelings[i].emoji,
                            ),
                          ),
                          if (this._feelingIndex == i)
                            SvgPicture.asset(
                              "assets/images/other/checkmark.svg",
                              width: 20,
                              height: 20,
                            ),
                        ],
                      ),
                    )
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Text(
                    'Comment',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                    ),
                  ),
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Optional',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                onChanged: (value) => this._comment = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Button.primary(
                        text: 'Ok',
                        onPressed: () {
                          if (parosmia &&
                              (this._severity == null ||
                                  this._severity.isEmpty ||
                                  this._feelingIndex == null)) {
                            Fluttertoast.showToast(
                                msg: 'Please fill in the required fields.');
                          } else {
                            setState(() {
                              widget.onAnswer(
                                widget.scent,
                                this._answer,
                                this._comment,
                                this._severity,
                                this._feelingIndex != null
                                    ? this._feelingIndex + 1
                                    : -1,
                              );
                            });
                            Navigator.of(context).pop();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
