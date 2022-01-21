import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:smellsense/model/feeling.dart';
import 'package:smellsense/model/scent.dart';
import 'package:smellsense/model/training.dart';
import 'package:smellsense/shared/widgets/app_bar.widget.dart';
import 'package:smellsense/storage/model/scent_rating.model.dart';
import 'package:smellsense/storage/model/scent_ratings.model.dart';
import 'package:smellsense/storage/storage.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ViewTrainingProgressScreen extends StatefulWidget {
  const ViewTrainingProgressScreen({Key? key}) : super(key: key);

  @override
  _ViewTrainingProgressScreenState createState() =>
      _ViewTrainingProgressScreenState();
}

class _ViewTrainingProgressScreenState
    extends State<ViewTrainingProgressScreen> {
  final SmellSenseStorage _storage = GetIt.I<SmellSenseStorage>();
  late Map<String, List<ScentRatings>> _trainingRatings;
  List<String>? _scentSelections;
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

  List<ScentRating>? getHighestTrainingRatings(String date) {
    int maxTrainingRating = -1;
    late ScentRatings maxTrainingScentRatings;

    for (ScentRatings ratings in _trainingRatings[date]!) {
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
    List<String> sortedDates = _trainingRatings.keys.toList()..sort();

    Map<String, List<OrdinalScentRatings>> data = {};

    for (String date in sortedDates) {
      List<ScentRating>? scentRatings = getHighestTrainingRatings(date);
      for (String scentName in _scentSelections!) {
        ScentRating? scentRating;

        for (var rating in scentRatings!) {
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
            data[scentName]!.add(
              OrdinalScentRatings(
                date,
                scentRating.rating,
              ),
            );
          }
        }
      }
    }

    _startingViewport = data.keys.first;

    return [
      for (String scent in data.keys)
        charts.Series<OrdinalScentRatings, String>(
          id: scent,
          domainFn: (OrdinalScentRatings rating, _) => rating.date,
          measureFn: (OrdinalScentRatings rating, _) => rating.rating,
          data: data[scent]!,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Scent.scents
              .firstWhere((element) => element.name == scent)
              .color),
          fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Scent.scents
              .firstWhere((element) => element.name == scent)
              .color),
        )
    ];
  }

  List<ScentRating>? _getBestScentRatingData(List<ScentRatings> data) {
    int max = -1;
    List<ScentRating>? bestRatings;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: RichText(
                    text: TextSpan(
                      text: 'Rating: ',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: Training.answerOptions[scentRating.rating - 1],
                          style: const TextStyle(
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
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Feeling: ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      SvgPicture.asset(
                        Feeling.feelings[scentRating.feeling! - 1].emoji!,
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                ],
                const Text('Comment:'),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 10,
                  ),
                  child: Text(
                    _getComment(scentRating.comment),
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }

  String _getComment(String? comment) {
    return (comment != null && comment.trim().isNotEmpty)
        ? '- None -'
        : comment!;
  }

  void _showTrainingDataDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        List<ScentRatings> datedScentRatings =
            _storage.getDatedScentRatingsByDate(_selectedDate)!;
        List<ScentRating> bestRatings =
            _getBestScentRatingData(datedScentRatings)!;

        return SimpleDialog(
          titlePadding: const EdgeInsets.all(10),
          title: Column(
            children: const [
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
                'Date: $_selectedDate',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            for (ScentRating rating in bestRatings)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: createScentRating(rating),
              )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _scentSelections = _storage.getScentSelectionHistory();
    _trainingRatings = _storage.getDatedScentRatings();
    var chart = _trainingRatings.keys.isNotEmpty
        ? GroupedFillColorBarChart(
            Key(toString()),
            getTrainingRatings(),
            onBarHover: (charts.SelectionModel selection) {
              if (selection.hasDatumSelection) {
                List<charts.SeriesDatum<dynamic>> data =
                    selection.selectedDatum;

                OrdinalScentRatings? rating = data[0].datum;

                setState(() {
                  _selectedDate = rating!.date;
                });

                _showTrainingDataDialog();
              }
            },
            startingViewport: _startingViewport,
          )
        : null;

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
                  fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                ),
              ),
            ),
          ),
          if (chart != null) ...[
            Text(
              _selectedDate != ''
                  ? 'Date: $_selectedDate'
                  : 'Touch bar to show details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w100,
                fontSize: Theme.of(context).textTheme.headline6!.fontSize,
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
                fontSize: Theme.of(context).textTheme.headline6!.fontSize,
              ),
            )
        ],
      ),
    );
  }
}

class GroupedFillColorBarChart extends StatefulWidget {
  final List<charts.Series<OrdinalScentRatings, String>> seriesList;
  final bool? animate;
  final Function? onBarHover;
  final String? startingViewport;

  const GroupedFillColorBarChart(
    Key key,
    this.seriesList, {
    this.animate,
    this.onBarHover,
    this.startingViewport,
  }) : super(key: key);

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
          updatedListener: widget.onBarHover as void Function(
              charts.SelectionModel<String>)?,
        )
      ],
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 2.0,
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        // 6 ticks on Y axis including 0
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: const charts.NoneRenderSpec(),
        viewport: charts.OrdinalViewport(widget.startingViewport!, 15),
      ),
      behaviors: [
        charts.SeriesLegend(
          entryTextStyle: const charts.TextStyleSpec(fontSize: 10),
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
  final int? rating;

  OrdinalScentRatings(this.date, this.rating);
}
