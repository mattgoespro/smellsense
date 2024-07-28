import 'package:flutter/material.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent_display.module.dart';

class ScentSelectionCheckboxGroupWidget extends StatefulWidget {
  static const maxSelectionCount = 4;

  final void Function(List<TrainingScentName>) onSelectionChange;

  const ScentSelectionCheckboxGroupWidget({
    super.key,
    required this.onSelectionChange,
  });

  @override
  ScentSelectionCheckboxGroupWidgetState createState() =>
      ScentSelectionCheckboxGroupWidgetState();
}

class ScentSelectionCheckboxGroupWidgetState
    extends State<ScentSelectionCheckboxGroupWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = true;

  late final Map<TrainingScentName, bool> selectedScents;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    selectedScents = TrainingScentName.values
        .fold<Map<TrainingScentName, bool>>(
            {}, (acc, element) => acc..[element] = false);
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      setState(() {
        _isAtBottom = _scrollController.position.pixels != 0;
      });
    } else {
      setState(() {
        _isAtBottom = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Stack(
      children: [
        ListView(
          itemExtent: 48,
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.antiAlias,
          children: [
            for (TrainingScentDisplay scent in TrainingScentDisplay.getScents())
              CheckboxListTile(
                dense: true,
                checkboxShape: theme.checkboxTheme.shape,
                title: Text(
                  scent.displayName,
                  style: textTheme.bodyMedium!.copyWith(
                    color: scent.displayColor,
                  ),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      var scentSelection = getScentSelection();

                      if (value == true &&
                          scentSelection.length ==
                              ScentSelectionCheckboxGroupWidget
                                  .maxSelectionCount) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'You have already selected ${ScentSelectionCheckboxGroupWidget.maxSelectionCount} scents.',
                            ),
                          ),
                        );
                      }
                      selectedScents[scent.name] = value ?? false;
                      widget.onSelectionChange(scentSelection);
                    },
                  );
                },
                value: selectedScents[scent.name],
                controlAffinity: ListTileControlAffinity.leading,
              ),
          ],
        ),
        if (!_isAtBottom)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                '...',
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }

  List<TrainingScentName> getScentSelection() {
    return selectedScents.keys
        .takeWhile(
          (element) => selectedScents[element]!,
        )
        .toList();
  }
}
