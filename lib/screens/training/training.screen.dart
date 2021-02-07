import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:im_stepper/stepper.dart';
import 'package:smellsense/model/scent.dart';
import 'package:smellsense/model/training.dart';
import 'package:smellsense/providers/scent.provider.dart';
import 'package:smellsense/screens/training/train-scent/train-scent.dart';
import 'package:smellsense/shared/widgets/app-bar.dart';
import 'package:smellsense/shared/widgets/button.widget.dart';
import 'package:smellsense/storage/model/scent-rating.model.dart';
import 'package:smellsense/storage/model/scent-ratings.model.dart';
import 'package:smellsense/storage/storage.dart';

class SmellTrainingScreen extends StatefulWidget {
  final List<Scent> scents;

  SmellTrainingScreen(this.scents);

  @override
  _SmellTrainingScreenState createState() => _SmellTrainingScreenState();
}

class _SmellTrainingScreenState extends State<SmellTrainingScreen> {
  int _activeStep = 0;
  bool _timerActive = true;
  var _answers = {};
  PageController pageController = PageController();
  ScentProvider _scentProvider = GetIt.I<ScentProvider>();
  SmellSenseStorage _storage = GetIt.I<SmellSenseStorage>();

  _onScentAnswerSelection(Scent scent, String answer) {
    setState(() {
      this._answers[scent.name] = answer;
      this._scentProvider.scentRatings[scent.name] =
          Training.answerOptions.indexOf(answer) + 1;
    });
  }

  void onTimerStatusChange(bool active) {
    setState(() {
      this._timerActive = active;
    });
  }

  Widget get _stepperWidget => Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: DotStepper(
          dotRadius: 7,
          spacing: 30,
          dotCount: widget.scents.length,
          activeStep: this._activeStep,
          indicator: Indicator.jump,
          fixedDotDecoration: FixedDotDecoration(
            color: Colors.white,
            strokeWidth: 1,
          ),
          indicatorDecoration: IndicatorDecoration(
            color: Colors.blue,
            style: PaintingStyle.stroke,
            strokeWidth: 1,
          ),
          tappingEnabled: this._timerActive,
          onDotTapped: (tappedDotIndex) {
            this.pageController.animateToPage(
                  tappedDotIndex,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeIn,
                );
          },
          lineConnectorsEnabled: true,
          lineConnectorDecoration: LineConnectorDecoration(strokeWidth: 0.1),
        ),
      );

  void _showDoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
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
              String dateString = "${now.year}/${now.month}/${now.day}";
              List<ScentRating> ratings = [];

              for (String key in _scentProvider.scentRatings.keys) {
                ratings.add(ScentRating(key, _scentProvider.scentRatings[key]));
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
      appBar: SmellSenseAppBar(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: 4,
                  onPageChanged: (pageNumber) {
                    setState(() {
                      this._activeStep = pageNumber;
                    });
                  },
                  controller: this.pageController,
                  itemBuilder: (context, index) {
                    return TrainScent(
                      scent: widget.scents[index],
                      answers: this._answers,
                      onAnswer: this._onScentAnswerSelection,
                      onTimerStatusChange: this.onTimerStatusChange,
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Button.primary(
                  text: 'Back',
                  onPressed: this._timerActive
                      ? () {
                          this.pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                        }
                      : null,
                ),
                this._stepperWidget,
                Button.primary(
                  text: this._activeStep == 3 ? 'Done' : 'Next',
                  onPressed: this._timerActive
                      ? () {
                          if (this._activeStep == 3) {
                            if (this._answers.keys.length == 4) {
                              this._showDoneDialog();
                            } else {
                              Fluttertoast.showToast(
                                msg:
                                    "Train and rate all your scents before proceeding.",
                              );
                            }
                          } else {
                            this.pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
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
