import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/select_activities_figma_tokens.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/bottom_booking_bar.dart';
import 'package:trip_marche/features/booking/domain/entities/activity.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_activities.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data_builder.dart';
import 'package:trip_marche/features/booking/domain/entities/traveler_contact.dart';
import '../widgets/traveler_activities_section.dart';
import 'review_view.dart';

class _TravelerActivitiesEntry {
  _TravelerActivitiesEntry({required this.traveler})
      : selectedActivityIds = <String>{},
        sameAsTravelerOne = false;

  final TravelerContact traveler;
  Set<String> selectedActivityIds;
  bool sameAsTravelerOne;
}

class SelectActivitiesView extends StatefulWidget {
  const SelectActivitiesView({
    required this.travelers,
    required this.flowContext,
    super.key,
  });

  final List<TravelerContact> travelers;
  final BookingFlowContext flowContext;

  @override
  State<SelectActivitiesView> createState() => _SelectActivitiesViewState();
}

class _SelectActivitiesViewState extends State<SelectActivitiesView> {
  late final List<_TravelerActivitiesEntry> _entries;

  @override
  void initState() {
    super.initState();
    _entries = widget.travelers
        .map((traveler) => _TravelerActivitiesEntry(traveler: traveler))
        .toList(growable: false);
  }

  List<Activity> _availableActivities(BuildContext context) {
    final tr = context.tr;
    return [
      Activity(id: 'camping', name: tr.bookingActivityCamping, price: 70),
      Activity(id: 'fishing', name: tr.bookingActivityFishing, price: 30),
      Activity(id: 'diving', name: tr.bookingActivityDiving, price: 80),
    ];
  }

  void _syncFromTravelerOne() {
    if (_entries.isEmpty) {
      return;
    }
    final source = Set<String>.from(_entries.first.selectedActivityIds);
    for (var i = 1; i < _entries.length; i++) {
      if (_entries[i].sameAsTravelerOne) {
        _entries[i].selectedActivityIds = Set<String>.from(source);
      }
    }
  }

  void _toggleActivity(int travelerIndex, String activityId) {
    final entry = _entries[travelerIndex];
    if (entry.sameAsTravelerOne) {
      return;
    }

    setState(() {
      if (entry.selectedActivityIds.contains(activityId)) {
        entry.selectedActivityIds.remove(activityId);
      } else {
        entry.selectedActivityIds.add(activityId);
      }

      if (travelerIndex == 0) {
        _syncFromTravelerOne();
      }
    });
  }

  void _onSameAsTravelerOneChanged(int travelerIndex, bool value) {
    setState(() {
      final entry = _entries[travelerIndex];
      entry.sameAsTravelerOne = value;
      if (value) {
        entry.selectedActivityIds =
            Set<String>.from(_entries.first.selectedActivityIds);
      }
    });
  }

  void _onContinue(BuildContext context) {
    final activitiesCatalog = {
      for (final activity in _availableActivities(context)) activity.id: activity,
    };

    final result = _entries
        .map(
          (entry) => BookingActivities(
            traveler: entry.traveler,
            activities: entry.selectedActivityIds
                .map((id) => activitiesCatalog[id])
                .whereType<Activity>()
                .toList(growable: false),
          ),
        )
        .toList(growable: false);

    final reviewData = BookingReviewDataBuilder.fromBookingFlow(
      context: context,
      activities: result,
      dateRange: widget.flowContext.dateRange,
      travelersCount: widget.flowContext.travelersCount,
      roomName: widget.flowContext.roomName,
      roomPrice: widget.flowContext.roomPrice,
    );

    sl<AppNavigator>().push(
      screen: ReviewView(data: reviewData),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;
    final activities = _availableActivities(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: SelectActivitiesFigmaTokens.screenBackground,
      ),
      child: Scaffold(
        backgroundColor: SelectActivitiesFigmaTokens.screenBackground,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: SelectActivitiesFigmaTokens.titleTop,
                  bottom: SelectActivitiesFigmaTokens.titleBottom,
                ),
                child: Text(
                  tr.bookingSelectActivitiesTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading3(
                    color: AppColors.tripDetailsFigmaBlack,
                  ).copyWith(
                    fontSize: SelectActivitiesFigmaTokens.titleFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    SelectActivitiesFigmaTokens.screenPadding,
                    0,
                    SelectActivitiesFigmaTokens.screenPadding,
                    SelectActivitiesFigmaTokens.listBottom,
                  ),
                  itemCount: _entries.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: SelectActivitiesFigmaTokens.sectionGap),
                  itemBuilder: (context, index) {
                    final entry = _entries[index];
                    return TravelerActivitiesSection(
                      travelerName: entry.traveler.fullName,
                      travelerIndexLabel:
                          tr.bookingTravelerParenthetical(index + 1),
                      activities: activities,
                      selectedActivityIds: entry.selectedActivityIds,
                      onActivityToggled: (activityId) =>
                          _toggleActivity(index, activityId),
                      showSameAsTravelerOne: index > 0,
                      sameAsTravelerOne: entry.sameAsTravelerOne,
                      sameAsTravelerOneLabel: tr.bookingSameAsTravelerOne,
                      onSameAsTravelerOneChanged: index > 0
                          ? (value) => _onSameAsTravelerOneChanged(index, value)
                          : null,
                      activitiesEnabled: !entry.sameAsTravelerOne,
                    );
                  },
                ),
              ),
              SafeArea(
                top: false,
                child: BottomBookingBar(
                  backButtonCircular: true,
                  onBack: () => Navigator.pop(context),
                  onContinue: () => _onContinue(context),
                  continueLabel: tr.bookingContinue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
