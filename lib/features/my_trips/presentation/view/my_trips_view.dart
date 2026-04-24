import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trip_booking_card.dart';

class MyTripsView extends StatefulWidget {
  const MyTripsView({super.key});

  @override
  State<MyTripsView> createState() => _MyTripsViewState();
}

class _MyTripsViewState extends State<MyTripsView> {
  int _selectedTab = 0; // 0: Active, 1: Past, 2: Canceled

  @override
  Widget build(BuildContext context) {
    final headerHeight = 120.h;
    final sheetRadius = 32.r;

    final trips = switch (_selectedTab) {
      0 => DummyData.upcomingTrips,
      1 => DummyData.pastTrips,
      _ => DummyData.upcomingTrips,
    };

    final status = switch (_selectedTab) {
      0 => (
        context.tr.myTripsStatusActive,
        AppColors.success,
        context.tr.myTripsViewDetails,
        context.tr.myTripsBookingDetails,
      ),
      1 => (
        context.tr.myTripsStatusPast,
        AppColors.red,
        context.tr.myTripsBookAgain,
        context.tr.myTripsBookingDetails,
      ),
      _ => (
        context.tr.myTripsStatusCanceled,
        AppColors.greyText,
        context.tr.myTripsViewDetails,
        context.tr.myTripsDownloadPdf,
      ),
    };

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
            ),
          ),
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  end: 16.w,
                  top: 12.h,
                ),
                child: Text(
                  context.tr.myTripsTitle,
                  style: AppTextStyles.heading3(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: headerHeight,
            child: Container(
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
                end: 16.w,
                top: 22.h,
                bottom: 16.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(sheetRadius),
                ),
              ),
              child: Column(
                children: [
                  _SearchField(hint: context.tr.myTripsSearchHint),
                  SizedBox(height: 14.h),
                  _TripsTabs(
                    selectedIndex: _selectedTab,
                    onChanged: (index) => setState(() => _selectedTab = index),
                    activeText: context.tr.myTripsTabActive,
                    pastText: context.tr.myTripsTabPastNew,
                    canceledText: context.tr.myTripsTabCanceled,
                  ),
                  SizedBox(height: 14.h),
                  Expanded(
                    child: trips.isEmpty
                        ? _buildEmptyState(context)
                        : ListView.separated(
                            itemCount: trips.length.clamp(0, 3),
                            separatorBuilder: (_, __) => SizedBox(height: 14.h),
                            itemBuilder: (context, index) {
                              final trip = trips[index];
                              final rawLocation = trip.location.trim();
                              final locationText =
                                  rawLocation.startsWith(
                                    context.tr.myTripsFromPrefix,
                                  )
                                  ? rawLocation
                                  : '${context.tr.myTripsFromPrefix} $rawLocation';
                              return MyTripBookingCard(
                                trip: trip,
                                statusText: status.$1,
                                statusColor: status.$2,
                                locationText: locationText,
                                primaryActionText: status.$3,
                                secondaryActionText:
                                    context.tr.myTripsViewReceipt,
                                bottomActionText: status.$4,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.lightBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.map, size: 36, color: AppColors.greyText),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.myTripsEmptyTitle,
            style: AppTextStyles.heading3(color: AppColors.secondaryText),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.myTripsEmptyDescription,
            style: AppTextStyles.bodyMedium(color: AppColors.greyText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 32.w,
                vertical: 14.h,
              ),
            ),
            child: Text(
              context.tr.myTripsExploreTrips,
              style: AppTextStyles.button(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(Iconsax.search_normal, size: 20.sp, color: AppColors.greyText),
          SizedBox(width: 10.w),
          Text(
            hint,
            style: AppTextStyles.bodyMedium(color: AppColors.greyText),
          ),
        ],
      ),
    );
  }
}

class _TripsTabs extends StatelessWidget {
  const _TripsTabs({
    required this.selectedIndex,
    required this.onChanged,
    required this.activeText,
    required this.pastText,
    required this.canceledText,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final String activeText;
  final String pastText;
  final String canceledText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TabPill(
            text: activeText,
            isSelected: selectedIndex == 0,
            onTap: () => onChanged(0),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _TabPill(
            text: pastText,
            isSelected: selectedIndex == 1,
            onTap: () => onChanged(1),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _TabPill(
            text: canceledText,
            isSelected: selectedIndex == 2,
            onTap: () => onChanged(2),
          ),
        ),
      ],
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        height: 35.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected ? null : Border.all(color: AppColors.border),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.bodyMedium(
            color: isSelected ? Colors.white : AppColors.greyText,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
