import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smellsense/app/application/providers/infrastructure.provider.dart';
import 'package:smellsense/app/router/router_route_data.dart';
import 'package:smellsense/app/pages/scent_selection/scent_selection_checkbox_group.widget.dart';
import 'package:smellsense/app/pages/training_session_history/training_session_history.route.dart';
import 'package:smellsense/app/shared/modules/training_scent/training_scent.module.dart';
import 'package:smellsense/app/shared/theme/theme.dart';
import 'package:smellsense/app/shared/utils/colorutils.mixin.dart';
import 'package:smellsense/app/shared/utils/datetimeutils.dart';
import 'package:smellsense/app/shared/utils/logger.dart';
import 'package:smellsense/app/shared/utils/utils.dart';

class ScentSelectionPage extends StatefulWidget {
  static int maxSelectionCount = 4;

  const ScentSelectionPage({super.key});

  @override
  ScentSelectionPageState createState() => ScentSelectionPageState();
}

class ScentSelectionPageState extends State<ScentSelectionPage> {
  List<TrainingScentName> selectedScents = [];
  ValueNotifier<bool> isSubmitting = ValueNotifier(false);

  bool isSelectionComplete() =>
      selectedScents.length ==
      ScentSelectionCheckboxGroupWidget.maxSelectionCount;

  Future<void> storeScentSelections() async {
    Infrastructure infrastructure = Infrastructure.of(context);

    await infrastructure.databaseService.createTrainingPeriod(
      DateTimeUtils.date(),
      selectedScents
          .map(
            (scent) => TrainingScent(
              id: uuid(),
              name: scent,
            ),
          )
          .toList(),
    );

    Output.trace('Training period created');
  }

  void Function()? get onNextButtonPressed => isSelectionComplete()
      ? () async {
          try {
            setState(() {
              isSubmitting.value = true;
            });

            await storeScentSelections();

            if (mounted) {
              setState(() {
                isSubmitting.value = false;
              });

              TrainingSessionHistoryRouteData().go(context);
              return;
            }

            Output.error(
              'Tried to navigate to the home screen when the scent selection screen is no longer mounted!',
            );
          } catch (exception, stackTrace) {
            Output.error(exception);
            Output.trace(stackTrace);
          } finally {
            setState(() {
              isSubmitting.value = false;
            });
          }
        }
      : null;

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            if (isSubmitting.value)
              Container(
                color: theme.colorScheme.surface.lightenPercent(50),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    'pages.scent_selection.select_scents_headline'.tr(),
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ScentSelectionCheckboxGroupWidget(
                      onSelectionChange: (List<TrainingScentName> scents) {
                        setState(
                          () {
                            selectedScents = scents;
                          },
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: OutlinedButton(
                    onPressed: onNextButtonPressed,
                    child: Text(
                      'shared.next_button_text'.tr(),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
