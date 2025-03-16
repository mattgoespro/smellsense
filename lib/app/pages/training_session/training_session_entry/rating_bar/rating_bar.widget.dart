import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smellsense/app/pages/training_session/training_session_entry/training_session_entry.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_rating.module.dart';
import 'package:smellsense/app/shared/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class RatingBarWidget extends StatefulWidget {
  const RatingBarWidget({
    super.key,
  });

  @override
  RatingBarWidgetState createState() => RatingBarWidgetState();
}

class RatingBarWidgetState extends State<RatingBarWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    MaterialTheme theme = MaterialTheme.of(context);

    return RatingBar.builder(
      direction: Axis.vertical,
      itemCount: TrainingSessionEntryRating.values.length,
      minRating: 1,
      itemBuilder: (context, rating) {
        TrainingSessionEntryRating option =
            TrainingSessionEntryRating.fromValue(rating.toInt());

        return Text(
          "screens.training_session.training_session_entry.rating_bar.option.${option.rating}"
              .tr(),
          style: theme.textTheme.bodyMedium,
        );
      },
      onRatingUpdate: (rating) {
        TrainingSessionEntryWidgetState entryWidget =
            TrainingSessionEntryWidget.of(context);

        return entryWidget.updateEntry(
          (entry) {
            entry.update(
              rating: TrainingSessionEntryRating.fromValue(rating.toInt()),
            );
          },
        );
      },
      glow: true,
      glowColor: Theme.of(context).primaryColor,
      unratedColor: Theme.of(context).primaryColor.withAlpha(50),
    );
  }
}
