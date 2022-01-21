import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:im_stepper/stepper.dart';
import 'package:smellsense/model/scent_training_rating.dart';
import 'package:smellsense/model/scent.dart';
import 'package:smellsense/model/training.dart';
import 'package:smellsense/providers/scent.provider.dart';
import 'package:smellsense/screens/training/train_scent/train_scent.dart';
import 'package:smellsense/shared/widgets/app_bar.widget.dart';
import 'package:smellsense/shared/widgets/button.widget.dart';
import 'package:smellsense/storage/model/scent_rating.model.dart';
import 'package:smellsense/storage/model/scent_ratings.model.dart';
import 'package:smellsense/storage/storage.dart';

class SmellTrainingScreen extends StatefulWidget {
  final List<Scent> scents;

  const SmellTrainingScreen(Key key, this.scents) : super(key: key);

  @override
  _SmellTrainingScreenState createState() => _SmellTrainingScreenState();
}

class _SmellTrainingScreenState extends State<SmellTrainingScreen> {
  int _activeStep = 0;
  bool _timerActive = true;

  // Map to group checkbox selections per scent
  final _answers = {};

  PageController pageController = PageController();
  final ScentProvider _scentProvider = GetIt.I<ScentProvider>();
  final SmellSenseStorage _storage = GetIt.I<SmellSenseStorage>();

  _onScentAnswerSelection(
    Scent scent,
    String answer,
    String comment,
    String severity,
    int feelingIndex,
  ) {
    setState(() {
      _answers[scent.name] = answer;
      _scentProvider.scentRatings[scent.name] = ScentTrainingRating(
        Training.answerOptions.indexOf(answer) + 1,
        comment,
        severity,
        feelingIndex,
      );
    });
  }

  void onTimerStatusChange(bool active) {
    setState(() {
      _timerActive = active;
    });
  }

  Widget get _stepperWidget => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: DotStepper(
          dotRadius: 7,
          spacing: 30,
          dotCount: widget.scents.length,
          activeStep: _activeStep,
          indicator: Indicator.jump,
          fixedDotDecoration: const FixedDotDecoration(
            color: Colors.white,
            strokeWidth: 1,
          ),
          indicatorDecoration: const IndicatorDecoration(
            color: Colors.blue,
            strokeWidth: 1,
          ),
          tappingEnabled: _timerActive,
          onDotTapped: (tappedDotIndex) {
            pageController.animateToPage(
              tappedDotIndex,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
          },
          lineConnectorsEnabled: true,
          lineConnectorDecoration:
              const LineConnectorDecoration(strokeWidth: 0.1),
        ),
      );

  void _showDoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Are you sure you are done training?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
        actions: [
          Button.secondary(
            text: 'No',
            onPressed: () => Navigator.of(context).pop(),
          ),
          Button.primary(
            text: 'Yes',
            onPressed: () async {
              DateTime now = DateTime.now();
              String dateString =
                  "${now.year}/${now.month >= 10 ? now.month : "0${now.month}"}/${now.day >= 10 ? now.day : "0${now.day}"}";
              List<ScentRating> ratings = [];

              for (String key in _scentProvider.scentRatings.keys) {
                ScentTrainingRating rating = _scentProvider.scentRatings[key]!;
                ratings.add(
                  ScentRating(
                    key,
                    rating.rating,
                    rating.comment,
                    rating.severity,
                    rating.feeling < 0 ? null : rating.feeling,
                  ),
                );
              }

              await _storage.storeDatedScentRatings(
                dateString,
                ScentRatings(ratings),
              );
              Navigator.of(context)
                ..pop()
                ..pop()
                ..pushNamed('/training-progress');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SmellSenseAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: 4,
                  onPageChanged: (pageNumber) {
                    setState(() {
                      _activeStep = pageNumber;
                    });
                  },
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return TrainScent(
                      Key(widget.scents[index].toString()),
                      scent: widget.scents[index],
                      answers: _answers,
                      onAnswer: _onScentAnswerSelection,
                      onTimerStatusChange: onTimerStatusChange,
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Button.primary(
                  text: 'Back',
                  onPressed: _timerActive
                      ? () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                ),
                _stepperWidget,
                Button.primary(
                  text: _activeStep == 3 ? 'Done' : 'Next',
                  onPressed: _timerActive
                      ? () {
                          if (_activeStep == 3) {
                            if (_answers.keys.length == 4) {
                              _showDoneDialog();
                            } else {
                              Fluttertoast.showToast(
                                msg:
                                    "Train and rate all your scents before proceeding.",
                              );
                            }
                          } else {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
