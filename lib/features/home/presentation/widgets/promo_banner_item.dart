import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class PromoBannerItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String buttonText;
  final String urlLaunch;
  final int currentIndex;
  final int totalCount;
  final VoidCallback? onBookNowTap;

  const PromoBannerItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.currentIndex,
    required this.totalCount,
    required this.buttonText,
    required this.urlLaunch,
    this.onBookNowTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTight = constraints.maxHeight <= 140;
        final titleStyle = isTight
            ? AppTextStyles.heading3(color: AppColors.onImage)
            : AppTextStyles.heading2(color: AppColors.onImage);

        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AppCachedNetworkImage.getImageProvider(imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: isTight ? 12.h : 16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(title, style: titleStyle),
                    SizedBox(height: 4.h),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.onImage.withValues(alpha: 0.85),
                        ),
                        maxLines: isTight ? 1 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: isTight ? 6.h : 10.h),
                    SizedBox(
                      height: isTight ? 30.h : 34.h,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerStart,
                        child: GestureDetector(
                          onTap: () async =>
                              await launchUrl(Uri.parse(urlLaunch)),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: isTight ? 7.h : 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Text(
                              buttonText,
                              style: AppTextStyles.bodyMedium(
                                color: AppColors.darkText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                end: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                    start: 14.w,
                    end: 10.w,
                    top: 8.h,
                    bottom: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.shadow.withValues(alpha: 0.48),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${currentIndex + 1}/$totalCount',
                        style: AppTextStyles.subtitle(color: AppColors.onImage)
                            .copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Iconsax.clipboard,
                        color: AppColors.onImage,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
