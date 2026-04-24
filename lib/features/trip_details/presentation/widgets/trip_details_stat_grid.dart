import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_info_card.dart';

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
      childAspectRatio: 1.55,
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

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      padding: EdgeInsetsDirectional.all(14.r),
      borderRadius: 16.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(data.icon, color: AppColors.primary, size: 22.sp),
          SizedBox(height: 10.h),
          Text(
            data.label,
            style: AppTextStyles.caption(color: AppColors.greyText),
          ),
          SizedBox(height: 4.h),
          Flexible(
            child: Text(
              data.value,
              style: AppTextStyles.bodyMedium(
                color: AppColors.darkText,
              ).copyWith(fontWeight: FontWeight.w700),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
