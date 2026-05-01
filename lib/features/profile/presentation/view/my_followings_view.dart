import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../company_profile/presentation/view/company_profile_view.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/app_images.dart';
import '../widgets/followings_empty_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class MyFollowingsView extends StatefulWidget {
  const MyFollowingsView({super.key});

  @override
  State<MyFollowingsView> createState() => _MyFollowingsViewState();
}

class _MyFollowingsViewState extends State<MyFollowingsView> {
  final List<Map<String, dynamic>> _companies = [
    {
      'name': 'Travel Agency',
      'logo': AppImages.companyPlaceholder,
      'isFollowing': true,
    },
    {
      'name': 'Travel Agency',
      'logo': AppImages.companyPlaceholder,
      'isFollowing': true,
    },
    {
      'name': 'Travel Agency',
      'logo': AppImages.companyPlaceholder,
      'isFollowing': true,
    },
    {
      'name': 'Travel Agency',
      'logo': AppImages.companyPlaceholder,
      'isFollowing': true,
    },
    {
      'name': 'Travel Agency',
      'logo': AppImages.companyPlaceholder,
      'isFollowing': true,
    },
    {
      'name': 'Travel Agency',
      'logo': AppImages.companyPlaceholder,
      'isFollowing': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkText,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.followingsTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: _companies.isEmpty
          ? const FollowingsEmptyState()
          : ListView.separated(
              padding: EdgeInsetsDirectional.only(
                start: 18.w,
                end: 18.w,
                top: 10.h,
                bottom: 24.h,
              ),
              itemCount: _companies.length + 1,
              separatorBuilder: (_, index) =>
                  index == 0 ? SizedBox(height: 10.h) : SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Text(
                    context.tr.followingsCountTitle(_companies.length),
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.darkText,
                    ).copyWith(fontWeight: FontWeight.w700),
                  );
                }

                final i = index - 1;
                final company = _companies[i];
                final isFollowing = company['isFollowing'] as bool;

                return _FollowingCompanyCard(
                  name: company['name'] as String,
                  logoAsset: company['logo'] as String,
                  ratingValue: '4.9',
                  ratingCount: '112',
                  onTap: () => sl<AppNavigator>().push(
                    screen: const CompanyProfileView(),
                  ),
                  actionText: context.tr.followingsUnfollow,
                  isActive: isFollowing,
                  onAction: () {
                    setState(() {
                      _companies[i]['isFollowing'] = !isFollowing;
                    });
                  },
                );
              },
            ),
    );
  }
}

class _FollowingCompanyCard extends StatelessWidget {
  const _FollowingCompanyCard({
    required this.name,
    required this.logoAsset,
    required this.ratingValue,
    required this.ratingCount,
    required this.actionText,
    required this.isActive,
    required this.onTap,
    required this.onAction,
  });

  final String name;
  final String logoAsset;
  final String ratingValue;
  final String ratingCount;
  final String actionText;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColors.border.withValues(alpha: 0.8);

    return Material(
      color: AppColors.cardBg,
      borderRadius: BorderRadius.circular(18.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsetsDirectional.all(14.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Container(
                width: 54.r,
                height: 54.r,
                decoration: BoxDecoration(
                  color: AppColors.lightBg,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Image.asset(
                    logoAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Iconsax.building,
                      color: AppColors.greyText,
                      size: 22.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.darkText,
                      ).copyWith(fontWeight: FontWeight.w800, fontSize: 16.sp),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.star1,
                          size: 14.sp,
                          color: AppColors.starYellow,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          ratingValue,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.darkText,
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '($ratingCount)',
                          style: AppTextStyles.bodySmall(
                            color: AppColors.greyText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              OutlinedButton(
                onPressed: onAction,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.error, width: 1),
                  foregroundColor: AppColors.error,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  actionText,
                  style: AppTextStyles.bodySmall(
                    color: AppColors.error,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
