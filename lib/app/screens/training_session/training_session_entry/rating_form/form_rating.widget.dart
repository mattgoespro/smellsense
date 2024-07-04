import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smellsense/app/providers/infrastructure.provider.dart';
import 'package:smellsense/app/screens/training_session/training_session_entry/rating_form/rating_form.widget.dart';
import 'package:smellsense/app/shared/modules/training_session/training_scent.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_rating.module.dart';
import 'package:smellsense/app/shared/modules/training_session/training_session_entry_reaction.module.dart';
import 'package:smellsense/app/theme.dart';

class TrainingSessionEntryRatingFormRatingWidget extends StatefulWidget {
  static const timerDuration = 15;

  final TrainingScent scent;

  const TrainingSessionEntryRatingFormRatingWidget(
      {super.key, required this.scent});

  @override
  TrainingSessionEntryRatingFormRatingWidgetState createState() =>
      TrainingSessionEntryRatingFormRatingWidgetState();
}

class TrainingSessionEntryRatingFormRatingWidgetState
    extends State<TrainingSessionEntryRatingFormRatingWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late Infrastructure _infrastructure;

  bool busy = false;
  String? currentEncouragement;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _infrastructure = context.read<Infrastructure>();

    return RatingBar.builder(
      direction: Axis.vertical,
      itemCount: TrainingSessionEntryRatings.getRatings().length,
      minRating: 1,
      itemBuilder: (context, rating) =>
          _infrastructure.getAssetProvider().getIcon(
                TrainingSessionEntryRatings.getRating(
                  rating,
                ).name,
              ),
      onRatingUpdate: (rating) =>
          TrainingSessionEntryRatingFormWidget.of(context).updateEntry(
        TrainingSessionEntry(
          scent: TrainingScent(name: widget.scent.name),
          rating: TrainingSessionEntryRatings.getRating(rating),
          comment: '',
          parosmiaSeverity: TrainingSessionEntryParosmiaSeverity.none,
          reaction: TrainingSessionEntryParosmiaReaction.none,
        ),
      ),
      glow: true,
      glowColor: AppTheme.colors().orange,
      unratedColor: AppTheme.colors().blueLight,
    );
  }
}
