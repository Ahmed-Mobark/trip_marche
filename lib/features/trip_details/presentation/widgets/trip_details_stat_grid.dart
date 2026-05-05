import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'trip_details_info_card.dart';

class TripDetailsStatGrid extends StatelessWidget {
  const TripDetailsStatGrid({super.key, required this.cells});

  final List<TripDetailsStatCellData> cells;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 1.45,
      children: cells.map((c) => TripDetailsStatCell(data: c)).toList(),
    );
  }
}

class TripDetailsStatCellData {
  const TripDetailsStatCellData({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

class TripDetailsStatCell extends StatelessWidget {
  const TripDetailsStatCell({super.key, required this.data});

  final TripDetailsStatCellData data;

  static final Color _cardBorder =
      AppColors.border.withValues(alpha: 0.42);

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      padding: EdgeInsetsDirectional.all(16.w),
      borderRadius: 14.r,
      borderColor: _cardBorder,
      withShadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            data.icon,
            color: AppColors.tripDetailsStatIconPurple,
            size: 24.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            data.label,
            style: AppTextStyles.caption(
              color: AppColors.tripDetailsSecondaryGrey,
            ).copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            data.value,
            style: AppTextStyles.bodyMedium(
              color: AppColors.darkText,
            ).copyWith(
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
