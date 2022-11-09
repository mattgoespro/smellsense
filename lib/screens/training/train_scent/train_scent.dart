import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smellsense/model/feeling.dart';
import 'package:smellsense/model/scent.dart';
import 'package:smellsense/model/training.dart';
import 'package:smellsense/shared/widgets/button.widget.dart';
import 'package:smellsense/shared/widgets/fade.widget.dart';
import 'package:smellsense/shared/widgets/rounded_border_rect.widget.dart';
import 'package:smellsense/theme/colors.dart';

class TrainScent extends StatefulWidget {
  // Training time in seconds.
  static const timerDuration = 15;
  // static const timerDuration = 1;

  final Scent scent;
  final Function onAnswer;
  final Function onTimerStatusChange;
  final Map answers;

  const TrainScent(
    Key key, {
    required this.scent,
    required this.answers,
    required this.onAnswer,
    required this.onTimerStatusChange,
  }) : super(key: key);

  @override
  TrainScentState createState() => TrainScentState();
}

class TrainScentState extends State<TrainScent>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final CountDownController _controller = CountDownController();
  bool _trainingTimerDone = true;
  bool _firstStart = true;
  bool _encouragementVisible = false;
  int _encouragement = 0;
  String? _answer;
  String? _comment;
  String? _severity;
  int? _feelingIndex;

  @override
  bool get wantKeepAlive => true;

  Widget get _timerWidget {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_trainingTimerDone)
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return AppColors.buttonPrimary;
                    },
                  ),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (states) => const CircleBorder(),
                  ),
                  padding: MaterialStateProperty.resolveWith<EdgeInsets>(
                    (states) => const EdgeInsets.all(15.0),
                  ),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 50,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _trainingTimerDone = false;
                    _firstStart = false;
                    _encouragementVisible = true;
                  });

                  widget.onTimerStatusChange(_trainingTimerDone);
                },
              ),
            )
          else
            CircularCountDownTimer(
              controller: _controller,
              duration: TrainScent.timerDuration,
              width: double.infinity,
              height: double.infinity,
              fillColor: Colors.white,
              ringColor: Colors.blue,
              textFormat: CountdownTextFormat.SS,
              isReverse: true,
              onComplete: () {
                setState(() {
                  _trainingTimerDone = true;
                });

                widget.onTimerStatusChange(_trainingTimerDone);
              },
            ),
        ],
      ),
    );
  }

  Widget get _answersWidget => FadeAnimation(
        const Key('fade-answers'),
        reverse: false,
        child: Column(
          children: [
            for (String option in Training.answerOptions)
              Expanded(
                child: RadioListTile(
                  title: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  value: option,
                  groupValue: widget.answers[widget.scent.name],
                  onChanged: !_trainingTimerDone
                      ? null
                      : (dynamic answer) {
                          _answer = answer;
                          _comment = '';
                          _severity = '';
                          _feelingIndex = -1;

                          setState(() {
                            widget.onAnswer(
                              widget.scent,
                              _answer,
                              _comment,
                              _severity,
                              _feelingIndex,
                            );
                          });

                          int answerIndex =
                              Training.answerOptions.indexOf(answer);

                          _showAddCommentDialog(answerIndex == 1);
                        },
                ),
              ),
          ],
        ),
      );

  void _showAddCommentDialog(bool parosmia) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          titlePadding: const EdgeInsets.only(top: 10),
          title: Column(
            children: [
              Center(
                child: Text(
                  parosmia ? 'Parosmia' : 'Add a comment',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const Divider(
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
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.w300,
                            fontSize:
                                Theme.of(context).textTheme.titleLarge!.fontSize,
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
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    groupValue: _severity,
                    value: Training.severities[i],
                    onChanged: (dynamic value) {
                      setState(() => _severity = value);
                    },
                  ),
                ),
              const Divider(
                color: Colors.black,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'How are you feeling?',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    ),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.w300,
                          fontSize:
                              Theme.of(context).textTheme.titleLarge!.fontSize,
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
                              () => _feelingIndex = i,
                            ),
                            icon: SvgPicture.asset(
                              Feeling.feelings[i].emoji!,
                            ),
                          ),
                          if (_feelingIndex == i)
                            SvgPicture.asset(
                              "assets/svg/icons/checkmark.svg",
                              width: 20,
                              height: 20,
                            ),
                        ],
                      ),
                    )
                ],
              ),
              const Divider(
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
                      fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    ),
                  ),
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                decoration: const InputDecoration(
                  hintText: 'Optional',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                onChanged: (value) => _comment = value,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
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
                              (_severity == null ||
                                  _severity!.isEmpty ||
                                  _feelingIndex == null)) {
                            Fluttertoast.showToast(
                                msg: 'Please fill in the required fields.');
                          } else {
                            setState(() {
                              widget.onAnswer(
                                widget.scent,
                                _answer,
                                _comment,
                                _severity,
                                _feelingIndex != null ? _feelingIndex! + 1 : -1,
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
          fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
        ),
      );

  Widget get imageWidget => RoundedBorderRect(
        Key(widget.scent.name),
        borderColor: widget.scent.color,
        child: Image.asset(
          widget.scent.image,
          scale: 4,
        ),
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          _titleWidget,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: imageWidget,
          ),
          if (_trainingTimerDone && !_firstStart)
            FadeAnimation(
              const Key('fade-btn'),
              reverse: false,
              child: Button.primary(
                text: 'Restart',
                onPressed: () {
                  setState(() {
                    _trainingTimerDone = true;
                    _firstStart = true;
                    _encouragementVisible = false;
                  });
                },
              ),
            )
          else ...[
            if (_encouragementVisible)
              Expanded(
                child: Center(
                  child: FadeAnimation(
                    const Key('fade-encouragement'),
                    reverse: true,
                    waitSecondsBetween: 3,
                    onComplete: () {
                      setState(() {
                        _encouragementVisible = true;
                        _encouragement = (_encouragement + 1) %
                            Training.encouragements.length;
                      });
                    },
                    child: Text(
                      Training.encouragements[_encouragement],
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            else
              const Expanded(
                child: Center(
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
            Expanded(
              child: _timerWidget,
            )
          ],
          if (_trainingTimerDone && !_firstStart)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 5,
                  bottom: 12,
                ),
                child: _answersWidget,
              ),
            )
        ],
      ),
    );
  }
}
