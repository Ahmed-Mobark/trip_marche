import 'package:flutter/material.dart';
import 'package:trip_marche/core/config/dimensions/select_activities_figma_tokens.dart';
import 'package:trip_marche/features/booking/domain/entities/activity.dart';
import 'activity_card.dart';
import 'traveler_header.dart';

class TravelerActivitiesSection extends StatelessWidget {
  const TravelerActivitiesSection({
    super.key,
    required this.travelerName,
    required this.travelerIndexLabel,
    required this.activities,
    required this.currency,
    required this.selectedActivityIds,
    required this.onActivityToggled,
    this.showSameAsTravelerOne = false,
    this.sameAsTravelerOne = false,
    this.onSameAsTravelerOneChanged,
    this.sameAsTravelerOneLabel,
    this.activitiesEnabled = true,
  });

  final String travelerName;
  final String travelerIndexLabel;
  final List<Activity> activities;
  final String currency;
  final Set<String> selectedActivityIds;
  final ValueChanged<String> onActivityToggled;
  final bool showSameAsTravelerOne;
  final bool sameAsTravelerOne;
  final ValueChanged<bool>? onSameAsTravelerOneChanged;
  final String? sameAsTravelerOneLabel;
  final bool activitiesEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TravelerHeader(
          travelerName: travelerName,
          travelerIndexLabel: travelerIndexLabel,
          showSameAsTravelerOne: showSameAsTravelerOne,
          sameAsTravelerOne: sameAsTravelerOne,
          sameAsTravelerOneLabel: sameAsTravelerOneLabel,
          onSameAsTravelerOneChanged: onSameAsTravelerOneChanged,
        ),
        SizedBox(height: SelectActivitiesFigmaTokens.headerBottom),
        for (var i = 0; i < activities.length; i++) ...[
          if (i > 0) SizedBox(height: SelectActivitiesFigmaTokens.activityGap),
          ActivityCard(
            activity: activities[i],
            currency: currency,
            isSelected: selectedActivityIds.contains(activities[i].id),
            enabled: activitiesEnabled,
            onTap: () => onActivityToggled(activities[i].id),
          ),
        ],
      ],
    );
  }
}
