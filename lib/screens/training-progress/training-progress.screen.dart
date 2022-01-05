import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:smellsense/model/feeling.dart';
import 'package:smellsense/model/scent.dart';
import 'package:smellsense/model/training.dart';
import 'package:smellsense/shared/widgets/app-bar.dart';
import 'package:smellsense/storage/model/scent-rating.model.dart';
import 'package:smellsense/storage/model/scent-ratings.model.dart';
import 'package:smellsense/storage/storage.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ViewTrainingProgressScreen extends StatefulWidget {
  @override
  _ViewTrainingProgressScreenState createState() =>
      _ViewTrainingProgressScreenState();
}

class _ViewTrainingProgressScreenState
    extends State<ViewTrainingProgressScreen> {
  SmellSenseStorage _storage = GetIt.I<SmellSenseStorage>();
  Map<String, List<ScentRatings>> _trainingRatings;
  List<String> _scentSelections;
  String _selectedDate = '';
  String _startingViewport = '';

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  List<ScentRating> getHighestTrainingRatings(String date) {
    int maxTrainingRating = -1;
    ScentRatings maxTrainingScentRatings;

    for (ScentRatings ratings in this._trainingRatings[date]) {
      int totalRating = ratings.getTotalScentRating();
      if (totalRating > maxTrainingRating) {
        maxTrainingRating = totalRating;
        maxTrainingScentRatings = ratings;
      }
    }

    return maxTrainingScentRatings.ratings;
  }

  /// Create series list with multiple series
  List<charts.Series<OrdinalScentRatings, String>> getTrainingRatings() {
    List<String> sortedDates = this._trainingRatings.keys.toList()..sort();

    Map<String, List<OrdinalScentRatings>> data = {};

    for (String date in sortedDates) {
      List<ScentRating> scentRatings = this.getHighestTrainingRatings(date);
      for (String scentName in this._scentSelections) {
        var scentRating;

        for (var rating in scentRatings) {
          if (rating.scentName == scentName) {
            scentRating = rating;
            break;
          }
        }

        if (scentRating != null) {
          if (data[scentName] == null) {
            data[scentName] = <OrdinalScentRatings>[
              OrdinalScentRatings(
                date,
                scentRating.rating,
              )
            ];
          } else {
            data[scentName].add(
              OrdinalScentRatings(
                date,
                scentRating.rating,
              ),
            );
          }
        }
      }
    }

    this._startingViewport = data.keys.first;

    return [
      for (String scent in data.keys)
        charts.Series<OrdinalScentRatings, String>(
          id: scent,
          domainFn: (OrdinalScentRatings rating, _) => rating.date,
          measureFn: (OrdinalScentRatings rating, _) => rating.rating,
          data: data[scent],
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Scent.scents
              .firstWhere((element) => element.name == scent)
              .color),
          fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Scent.scents
              .firstWhere((element) => element.name == scent)
              .color),
        )
    ];
  }

  List<ScentRating> _getBestScentRatingData(List<ScentRatings> data) {
    int max = -1;
    List<ScentRating> bestRatings;

    for (ScentRatings ratings in data) {
      int totalRating = ratings.getTotalScentRating();

      if (ratings.getTotalScentRating() > max) {
        max = totalRating;
        bestRatings = ratings.ratings;
      }
    }

    return bestRatings;
  }

  Widget createScentRating(ScentRating scentRating) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.black54,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              scentRating.scentName,
              style: TextStyle(
                color: Scent.scents
                    .firstWhere((scent) => scent.name == scentRating.scentName)
                    .color,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                left: 30,
                bottom: 10,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: RichText(
                        text: TextSpan(
                          text: 'Rating: ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '${Training.answerOptions[scentRating.rating - 1]}',
                              style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (scentRating.rating == 2 &&
                        scentRating.severity != null) ...[
                      Text(
                        'Severity: ${scentRating.severity}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Feeling: ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          SvgPicture.asset(
                            Feeling.feelings[scentRating.feeling - 1].emoji,
                            width: 20,
                            height: 20,
                          )
                        ],
                      ),
                    ],
                    Text('Comment:'),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 10,
                      ),
                      child: Text(
                        scentRating.comment != null
                            ? scentRating.comment
                            : '- None -',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _showTrainingDataDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        List<ScentRatings> datedScentRatings =
            this._storage.getDatedScentRatingsByDate(this._selectedDate);
        List<ScentRating> bestRatings =
            this._getBestScentRatingData(datedScentRatings);

        return SimpleDialog(
          titlePadding: EdgeInsets.all(10),
          title: Column(
            children: [
              Center(
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              )
            ],
          ),
          contentPadding: EdgeInsets.zero,
          children: [
            Center(
              child: Text(
                'Date: ${this._selectedDate}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            for (ScentRating rating in bestRatings)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: this.createScentRating(rating),
              )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    this._scentSelections = this._storage.getScentSelectionHistory();
    this._trainingRatings = this._storage.getDatedScentRatings();
    var chart = this._trainingRatings.keys.length > 0 ? GroupedFillColorBarChart(
      this.getTrainingRatings(),
      onBarHover: (charts.SelectionModel selection) {
        if (selection.hasDatumSelection) {
          List<charts.SeriesDatum<dynamic>> data = selection.selectedDatum;

          OrdinalScentRatings rating = data[0].datum;

          setState(() {
            this._selectedDate = rating.date;
          });

          this._showTrainingDataDialog();
        }
      },
      startingViewport: this._startingViewport,
    ) : null;

    return Scaffold(
      appBar: SmellSenseAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Training Progress',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w100,
                  fontSize: Theme.of(context).textTheme.headline5.fontSize,
                ),
              ),
            ),
          ),
          if (chart != null) ...[
            Text(
              this._selectedDate != ''
                  ? 'Date: ${this._selectedDate}'
                  : 'Touch bar to show details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w100,
                fontSize: Theme.of(context).textTheme.headline6.fontSize,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: chart,
              ),
            ),
          ] else
            Text(
              'No training data to show.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w100,
                fontSize: Theme.of(context).textTheme.headline6.fontSize,
              ),
            )
        ],
      ),
    );
  }
}

class GroupedFillColorBarChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final Function onBarHover;
  final String startingViewport;

  GroupedFillColorBarChart(
    this.seriesList, {
    this.animate,
    this.onBarHover,
    this.startingViewport,
  });

  @override
  _GroupedFillColorBarChartState createState() =>
      _GroupedFillColorBarChartState();
}

class _GroupedFillColorBarChartState extends State<GroupedFillColorBarChart> {
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      widget.seriesList,
      animate: widget.animate,
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          updatedListener: widget.onBarHover,
        )
      ],
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 2.0,
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        // 6 ticks on Y axis including 0
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
        viewport: charts.OrdinalViewport(widget.startingViewport, 15),
      ),
      behaviors: [
        charts.SeriesLegend(
          entryTextStyle: charts.TextStyleSpec(fontSize: 10),
          position: charts.BehaviorPosition.bottom,
          outsideJustification: charts.OutsideJustification.middleDrawArea,
          desiredMaxColumns: 4,
        ),
        charts.PanAndZoomBehavior()
      ],
    );
  }
}

class OrdinalScentRatings {
  final String date;
  final int rating;

  OrdinalScentRatings(this.date, this.rating);
}
