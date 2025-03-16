import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smellsense/app/shared/modules/training_period.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_rating.module.dart';

class TrainingSessionHistoryChartWidget extends StatefulWidget {
  final List<TrainingPeriod> periods;

  const TrainingSessionHistoryChartWidget({
    super.key,
    required this.periods,
  });

  @override
  State<StatefulWidget> createState() =>
      TrainingSessionHistoryChartWidgetState();
}

class TrainingSessionHistoryChartWidgetState
    extends State<TrainingSessionHistoryChartWidget> {
  final double width = 7;

  late List<BarChartGroupData> ratingBarGroups;
  late List<BarChartGroupData> visibleRatingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    List<TrainingPeriod> periods = widget.periods;

    // TODO: Create bar chart series for all of the sessions done
    // in each period, in order of the period start date
    ratingBarGroups = [];

    visibleRatingBarGroups = ratingBarGroups;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
        // children: <Widget>[
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     // makeTransactionsIcon(),
        //     const SizedBox(
        //       width: 38,
        //     ),
        //     const Text(
        //       'Transactions',
        //       style: TextStyle(color: Colors.white, fontSize: 22),
        //     ),
        //     const SizedBox(
        //       width: 4,
        //     ),
        //     const Text(
        //       'state',
        //       style: TextStyle(color: Color(0xff77839a), fontSize: 16),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        // height: 38,
        // ),
        // BarChart(
        //   BarChartData(
        //     maxY: 20,
        //     barTouchData: BarTouchData(
        //       touchTooltipData: BarTouchTooltipData(
        //         getTooltipColor: ((group) {
        //           return Colors.grey;
        //         }),
        //         getTooltipItem: (a, b, c, d) => null,
        //       ),
        //       touchCallback: (FlTouchEvent event, response) {
        //         if (response == null || response.spot == null) {
        //           setState(() {
        //             touchedGroupIndex = -1;
        //             visibleRatingBarGroups = List.of(ratingBarGroups);
        //           });
        //           return;
        //         }

        //         touchedGroupIndex = response.spot!.touchedBarGroupIndex;

        //         setState(() {
        //           if (!event.isInterestedForInteractions) {
        //             touchedGroupIndex = -1;
        //             visibleRatingBarGroups = List.of(ratingBarGroups);
        //             return;
        //           }
        //           visibleRatingBarGroups = List.of(ratingBarGroups);
        //           if (touchedGroupIndex != -1) {
        //             double sum = 0.0;
        //             for (final rod
        //                 in visibleRatingBarGroups[touchedGroupIndex]
        //                     .barRods) {
        //               sum += rod.toY;
        //             }
        //             final avg = sum /
        //                 visibleRatingBarGroups[touchedGroupIndex]
        //                     .barRods
        //                     .length;

        //             visibleRatingBarGroups[touchedGroupIndex] =
        //                 visibleRatingBarGroups[touchedGroupIndex].copyWith(
        //               barRods: visibleRatingBarGroups[touchedGroupIndex]
        //                   .barRods
        //                   .map((rod) {
        //                 return rod.copyWith(
        //                   toY: avg,
        //                   color: Colors.yellow,
        //                 );
        //               }).toList(),
        //             );
        //           }
        //         });
        //       },
        //     ),
        //     titlesData: FlTitlesData(
        //       show: true,
        //       rightTitles: const AxisTitles(
        //         sideTitles: SideTitles(showTitles: false),
        //       ),
        //       topTitles: const AxisTitles(
        //         sideTitles: SideTitles(showTitles: false),
        //       ),
        //       bottomTitles: AxisTitles(
        //         sideTitles: SideTitles(
        //           showTitles: true,
        //           getTitlesWidget: bottomTitles,
        //           reservedSize: 42,
        //         ),
        //       ),
        //       leftTitles: AxisTitles(
        //         sideTitles: SideTitles(
        //           showTitles: true,
        //           reservedSize: 28,
        //           interval: 1,
        //           getTitlesWidget: leftTitles,
        //         ),
        //       ),
        //     ),
        //     borderData: FlBorderData(
        //       show: false,
        //     ),
        //     barGroups: visibleRatingBarGroups,
        //     gridData: const FlGridData(show: false),
        //   ),
        // ),
        // const SizedBox(
        // height: 12,
        // ),
        // ],
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeSessionRatingGroup(
    TrainingSession session,
    int datePosition,
  ) {
    return BarChartGroupData(
      x: datePosition,
      barRods: createSessionRatingBars(session),
    );
  }

  List<BarChartRodData> createSessionRatingBars(TrainingSession session) {
    List<BarChartRodData> bars = [];

    // TODO: Ideally use scent colors for the rating bar segments
    List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
    ];

    // create a stacked rating bar for each entry where the height of the bar segment
    // is the rating value of the entry and the color of the bar segment is the rating color
    // of the entry
    double barPosition = 0;

    for (int i = 0; i < session.entries.length; i++) {
      TrainingSessionEntry entry = session.entries[i];
      double barHeight = entry.rating.value.toDouble();

      bars.add(
        BarChartRodData(
          toY: TrainingSessionEntryRating.maxValue.toDouble(),
          rodStackItems: [
            BarChartRodStackItem(
              barPosition,
              barPosition + barHeight,
              colors[entry.rating.value],
            ),
          ],
        ),
      );
      barPosition += barHeight;
    }

    return bars;
  }

  // Widget makeTransactionsIcon() {
  //   const width = 4.5;
  //   const space = 3.5;
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: <Widget>[
  //       Container(
  //         width: width,
  //         height: 10,
  //         color: Colors.white.withAlpha(40),
  //       ),
  //       const SizedBox(
  //         width: space,
  //       ),
  //       Container(
  //         width: width,
  //         height: 28,
  //         color: Colors.white.withAlpha(80),
  //       ),
  //       const SizedBox(
  //         width: space,
  //       ),
  //       Container(
  //         width: width,
  //         height: 42,
  //         color: Colors.white.withAlpha(100),
  //       ),
  //       const SizedBox(
  //         width: space,
  //       ),
  //       Container(
  //         width: width,
  //         height: 28,
  //         color: Colors.white.withAlpha(80),
  //       ),
  //       const SizedBox(
  //         width: space,
  //       ),
  //       Container(
  //         width: width,
  //         height: 10,
  //         color: Colors.white.withAlpha(40),
  //       ),
  //     ],
  //   );
  // }
}
