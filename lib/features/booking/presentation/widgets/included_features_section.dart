import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/review_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class IncludedFeaturesSection extends StatelessWidget {
  const IncludedFeaturesSection({
    super.key,
    required this.title,
    required this.features,
  });

  final String title;
  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.all(ReviewFigmaTokens.includedPadding),
      decoration: BoxDecoration(
        color: ReviewFigmaTokens.includedBg,
        borderRadius: BorderRadius.circular(ReviewFigmaTokens.includedRadius),
        border: Border.all(color: ReviewFigmaTokens.includedBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppTextStyles.subtitle(
              color: AppColors.tripDetailsFigmaBlack,
            ).copyWith(
              fontSize: ReviewFigmaTokens.bodySize,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = (constraints.maxWidth - 12.w) / 2;
              return Wrap(
                spacing: 12.w,
                runSpacing: 10.h,
                children: [
                  for (final feature in features)
                    SizedBox(
                      width: itemWidth,
                      child: _IncludedFeatureItem(label: feature),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _IncludedFeatureItem extends StatelessWidget {
  const _IncludedFeatureItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Iconsax.tick_circle,
          size: 16.sp,
          color: AppColors.tripDetailsInclusionCheck,
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium(
              color: AppColors.tripDetailsFigmaBlack,
            ).copyWith(
              fontSize: ReviewFigmaTokens.smallSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
