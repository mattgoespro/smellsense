import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:smellsense/model/scent.dart';
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
  List<String> scentSelections;
  String _selectedDate = '';

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

      for (String scentName in scentSelections) {
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

  _getData() async {
    var data = {};
    data['scents'] = await this._storage.getScentSelectionHistory();
    data['trainingRatings'] = await this._storage.getDatedScentRatings();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmellSenseAppBar(),
      body: FutureBuilder(
        future: this._getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            this.scentSelections = snapshot.data['scents'];
            this._trainingRatings = snapshot.data['trainingRatings'];

            return Column(
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
                        fontSize:
                            Theme.of(context).textTheme.headline5.fontSize,
                      ),
                    ),
                  ),
                ),
                if (this._trainingRatings.length > 0) ...[
                  Text(
                    this._selectedDate != ''
                        ? 'Date: ${this._selectedDate}'
                        : 'Touch chart to show date',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GroupedFillColorBarChart(
                        this.getTrainingRatings(),
                        onBarHover: (charts.SelectionModel selection) {
                          if (selection.hasDatumSelection) {
                            List<charts.SeriesDatum<dynamic>> data =
                                selection.selectedDatum;

                            setState(() {
                              this._selectedDate = data[0].datum.date;
                            });
                          }
                        },
                      ),
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
            );
          }
        },
      ),
    );
  }
}

class GroupedFillColorBarChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final Function onBarHover;

  GroupedFillColorBarChart(this.seriesList, {this.animate, this.onBarHover});

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
      ),
      behaviors: [
        charts.SeriesLegend(
          entryTextStyle: charts.TextStyleSpec(fontSize: 10),
          position: charts.BehaviorPosition.bottom,
          outsideJustification: charts.OutsideJustification.middleDrawArea,
          desiredMaxColumns: 4,
        ),
        charts.SelectNearest(
          eventTrigger: charts.SelectionTrigger.tapAndDrag,
        ),
      ],
    );
  }
}

class OrdinalScentRatings {
  final String date;
  final int rating;

  OrdinalScentRatings(this.date, this.rating);
}
