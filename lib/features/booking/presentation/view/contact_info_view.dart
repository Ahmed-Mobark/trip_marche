import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/contact_info_figma_tokens.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/bottom_booking_bar.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'package:trip_marche/features/booking/domain/entities/traveler_contact.dart';
import 'package:trip_marche/features/booking/presentation/models/traveler_data.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import '../widgets/traveler_contact_card.dart';
import 'select_activities_view.dart';

class ContactInfoView extends StatefulWidget {
  const ContactInfoView({
    required this.travelersCount,
    required this.flowContext,
    super.key,
  });

  final int travelersCount;
  final BookingFlowContext flowContext;

  @override
  State<ContactInfoView> createState() => _ContactInfoViewState();
}

class _ContactInfoViewState extends State<ContactInfoView> {
  final _formKey = GlobalKey<FormState>();
  late final List<TravelerData> _travelers;
  bool _validateOnSubmit = false;
  int? _selectedMeetingPointId;

  @override
  void initState() {
    super.initState();
    final totalTravelers = widget.travelersCount < 1
        ? 1
        : widget.travelersCount;
    _travelers = List.generate(totalTravelers, (_) => TravelerData());
    _selectedMeetingPointId = widget.flowContext.selectedMeetingPointId;
  }

  @override
  void dispose() {
    for (final traveler in _travelers) {
      traveler.dispose();
    }
    super.dispose();
  }

  AutovalidateMode get _autovalidateMode => _validateOnSubmit
      ? AutovalidateMode.onUserInteraction
      : AutovalidateMode.disabled;

  void _onContinue() {
    setState(() => _validateOnSubmit = true);
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final meetingPoints = widget.flowContext.trip.meetingPoints;
    if (meetingPoints.isNotEmpty && _selectedMeetingPointId == null) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingMeetingPointRequired,
      );
      return;
    }

    final contacts = List<TravelerContact>.generate(_travelers.length, (index) {
      final traveler = _travelers[index];
      return TravelerContact(
        fullName: traveler.fullNameController.text.trim(),
        phoneNumber: traveler.phoneController.text.trim(),
        countryCode: traveler.selectedCountry,
      );
    });

    sl<AppNavigator>().push(
      screen: SelectActivitiesView(
        travelers: contacts,
        flowContext: widget.flowContext.copyWith(
          selectedMeetingPointId: _selectedMeetingPointId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppColors.isDark(context)
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: AppColors.scaffoldBg(context),
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: AppColors.scaffoldBg(context),
            ),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBg(context),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: ContactInfoFigmaTokens.titleTop,
                  bottom: ContactInfoFigmaTokens.titleBottom,
                ),
                child: Text(
                  tr.bookingContactInfoTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading3(color: AppColors.ink(context))
                      .copyWith(
                        fontSize: ContactInfoFigmaTokens.titleFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: ListView.separated(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      ContactInfoFigmaTokens.screenPadding,
                      0,
                      ContactInfoFigmaTokens.screenPadding,
                      16.h,
                    ),
                    itemCount:
                        _travelers.length +
                        (widget.flowContext.trip.meetingPoints.isEmpty ? 0 : 1),
                    separatorBuilder: (_, __) =>
                        SizedBox(height: ContactInfoFigmaTokens.cardGap),
                    itemBuilder: (context, index) {
                      if (index == _travelers.length) {
                        return _MeetingPointsSection(
                          meetingPoints: widget.flowContext.trip.meetingPoints,
                          selectedMeetingPointId: _selectedMeetingPointId,
                          onSelected: (id) {
                            setState(() => _selectedMeetingPointId = id);
                          },
                        );
                      }
                      final traveler = _travelers[index];
                      return TravelerContactCard(
                        travelerTitle: tr.bookingTravelerTitle(index + 1),
                        fullNameLabel: tr.bookingContactFullNameLabel,
                        fullNameHint: tr.bookingContactFullNameHint,
                        phoneLabel: tr.bookingContactPhoneLabel,
                        phoneHint: tr.bookingContactPhoneNumberHint,
                        nameController: traveler.fullNameController,
                        phoneController: traveler.phoneController,
                        countryCode: traveler.selectedCountry,
                        onCountryCodeChanged: (code) {
                          setState(() => traveler.selectedCountry = code);
                        },
                        requiredErrorText: tr.errorFieldRequired,
                        autovalidateMode: _autovalidateMode,
                        // Every traveler uses the same contact card. Only the
                        // primary traveler's phone number is required.
                        showPhone: true,
                        requirePhone: index == 0,
                      );
                    },
                  ),
                ),
              ),
              BottomBookingBar(
                backButtonCircular: true,
                onBack: () => Navigator.pop(context),
                onContinue: _onContinue,
                continueLabel: tr.bookingContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeetingPointsSection extends StatelessWidget {
  const _MeetingPointsSection({
    required this.meetingPoints,
    required this.selectedMeetingPointId,
    required this.onSelected,
  });

  final List<TripMeetingPoint> meetingPoints;
  final int? selectedMeetingPointId;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.tr.bookingMeetingPointTitle,
          style: AppTextStyles.subtitle(color: AppColors.ink(context)).copyWith(
            fontSize: ContactInfoFigmaTokens.travelerTitleSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: ContactInfoFigmaTokens.cardGap),
        for (var index = 0; index < meetingPoints.length; index++) ...[
          if (index > 0) SizedBox(height: ContactInfoFigmaTokens.cardGap),
          _MeetingPointCard(
            meetingPoint: meetingPoints[index],
            selected: meetingPoints[index].id == selectedMeetingPointId,
            onTap: () => onSelected(meetingPoints[index].id),
          ),
        ],
      ],
    );
  }
}

class _MeetingPointCard extends StatelessWidget {
  const _MeetingPointCard({
    required this.meetingPoint,
    required this.selected,
    required this.onTap,
  });

  final TripMeetingPoint meetingPoint;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? AppColors.primary
        : AppColors.softBorder(context);
    final secondaryColor = AppColors.greyText(context);

    return Material(
      color: AppColors.cardBg(context),
      borderRadius: BorderRadius.circular(ContactInfoFigmaTokens.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ContactInfoFigmaTokens.cardRadius),
        child: Container(
          padding: EdgeInsetsDirectional.all(
            ContactInfoFigmaTokens.cardPadding,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ContactInfoFigmaTokens.cardRadius,
            ),
            border: Border.all(color: borderColor, width: selected ? 1.5 : 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: selected ? AppColors.primary : secondaryColor,
                size: 22.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meetingPoint.name,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.ink(context),
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (meetingPoint.address != null) ...[
                      SizedBox(height: 6.h),
                      Text(
                        meetingPoint.address!,
                        style: AppTextStyles.bodySmall(color: secondaryColor),
                      ),
                    ],
                    if (meetingPoint.time != null) ...[
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 16.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            meetingPoint.time!,
                            style: AppTextStyles.bodySmall(
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
