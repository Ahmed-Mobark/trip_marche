import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/features/wishlist/presentation/widgets/wishlist_trip_card.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = DummyData.popularTrips;
    final headerHeight = 96.h;
    final sheetRadius = 32.r;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
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
                  context.tr.wishlistTitle,
                  style: AppTextStyles.heading3(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: headerHeight,
            child: Container(
              width: double.infinity,
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
                end: 16.w,
                top: 16.h,
                bottom: 16.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(sheetRadius),
                ),
              ),
              child:
                  trips.isEmpty ? _buildEmptyState(context) : _buildList(context, trips),
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
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.heart,
              size: 36,
              color: AppColors.greyText,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.wishlistEmptyTitle,
            style: AppTextStyles.heading3(color: AppColors.secondaryText),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.wishlistEmptyDescription,
            style: AppTextStyles.bodyMedium(color: AppColors.greyText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<TripItem> trips) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _SearchField(hint: context.tr.wishlistSearchHint),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _PillButton(
                  label: context.tr.wishlistSortBy,
                  icon: Iconsax.arrow_down_1,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _PillButton(
                  label: context.tr.wishlistFilters,
                  icon: Iconsax.setting_4,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ListView.separated(
            itemCount: trips.length.clamp(0, 3),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height: 14.h),
            itemBuilder: (context, index) {
              final trip = trips[index];
              final badge = switch (index) {
                0 => (context.tr.wishlistNewInTripMarche, AppColors.primary),
                1 => (context.tr.wishlistRecommended, const Color(0xFFF39C12)),
                _ => (context.tr.wishlistBestPrice, AppColors.success),
              };
              return WishlistTripCard(
                trip: trip,
                badgeText: badge.$1,
                badgeColor: badge.$2,
              );
            },
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

class _PillButton extends StatelessWidget {
  const _PillButton({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18.sp, color: AppColors.greyText),
          SizedBox(width: 8.w),
          Text(
            label,
            style: AppTextStyles.bodyMedium(color: AppColors.darkText)
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
