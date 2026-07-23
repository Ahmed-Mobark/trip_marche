import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/extensions/localization.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../../company_profile/presentation/view/company_profile_view.dart';
import '../../domain/usecases/get_followings_usecase.dart';
import '../../domain/usecases/toggle_follow_vendor_usecase.dart';
import '../cubit/followings_cubit.dart';
import '../cubit/followings_state.dart';
import '../widgets/followings_empty_state.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/toast/app_toast.dart';

class MyFollowingsRoute extends MaterialPageRoute<void> {
  MyFollowingsRoute() : super(builder: (context) => const MyFollowingsView());
}

class MyFollowingsView extends StatefulWidget {
  const MyFollowingsView({super.key});

  @override
  State<MyFollowingsView> createState() => _MyFollowingsViewState();
}

class _MyFollowingsViewState extends State<MyFollowingsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FollowingsCubit(
        GetFollowingsUseCase(sl<ProfileRepository>()),
        ToggleFollowVendorUseCase(sl<ProfileRepository>()),
      )..fetchFollowings(),
      child: BlocConsumer<FollowingsCubit, FollowingsState>(
        listenWhen: (previous, current) =>
            (current.status == FollowingsStatus.failure &&
                previous.status != FollowingsStatus.failure) ||
            current.toggleMessage != previous.toggleMessage,
        listener: (context, state) {
          if (state.errorMessage != null && state.companies.isEmpty) {
            appToast(
              context: context,
              type: ToastType.error,
              message: state.errorMessage ?? 'Something went wrong',
            );
          }
          if (state.toggleMessage != null) {
            appToast(
              context: context,
              type: state.toggleMessageIsError
                  ? ToastType.error
                  : ToastType.success,
              message: state.toggleMessage!,
            );
            context.read<FollowingsCubit>().clearToggleMessage();
          }
        },
        builder: (context, state) {
          final companies = state.companies;
          final isLoading = state.status == FollowingsStatus.loading;
          final isError = state.status == FollowingsStatus.failure;

          if (isLoading && companies.isEmpty) {
            return Scaffold(
              backgroundColor: AppColors.background(context),
              appBar: AppBar(
                backgroundColor: AppColors.background(context),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.darkText(context),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  context.tr.followingsTitle,
                  style: AppTextStyles.subtitle(
                    color: AppColors.darkText(context),
                  ),
                ),
                centerTitle: true,
              ),
              body: const Center(
                child: CustomLoading(size: 36, strokeWidth: 2.5),
              ),
            );
          }

          if (isError && companies.isEmpty) {
            return Scaffold(
              backgroundColor: AppColors.background(context),
              appBar: AppBar(
                backgroundColor: AppColors.background(context),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.darkText(context),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  context.tr.followingsTitle,
                  style: AppTextStyles.subtitle(
                    color: AppColors.darkText(context),
                  ),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.greyText(context),
                      ),
                      SizedBox(height: 12),
                      Text(
                        state.errorMessage ?? 'Something went wrong',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.greyText(context),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<FollowingsCubit>().fetchFollowings(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Retry',
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.onPrimary(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (companies.isEmpty) {
            return Scaffold(
              backgroundColor: AppColors.background(context),
              appBar: AppBar(
                backgroundColor: AppColors.background(context),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.darkText(context),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  context.tr.followingsTitle,
                  style: AppTextStyles.subtitle(
                    color: AppColors.darkText(context),
                  ),
                ),
                centerTitle: true,
              ),
              body: const FollowingsEmptyState(),
            );
          }

          return Scaffold(
            backgroundColor: AppColors.background(context),
            appBar: AppBar(
              backgroundColor: AppColors.background(context),
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.darkText(context),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                context.tr.followingsTitle,
                style: AppTextStyles.subtitle(
                  color: AppColors.darkText(context),
                ),
              ),
              centerTitle: true,
            ),
            body: ListView.builder(
              padding: EdgeInsetsDirectional.only(
                start: 18.w,
                end: 18.w,
                top: 10.h,
                bottom: 24.h,
              ),
              itemCount: 2 * companies.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Text(
                    context.tr.followingsCountTitle(companies.length),
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.darkText(context),
                    ).copyWith(fontWeight: FontWeight.w700),
                  );
                }

                final gapIndex = index - 1;
                if (gapIndex % 2 == 1) {
                  return SizedBox(height: gapIndex == 1 ? 10.h : 12.h);
                }

                final companyIndex = gapIndex ~/ 2;
                final company = companies[companyIndex];

                return _FollowingCompanyCard(
                  name: company.name,
                  logoAsset: company.avatar,
                  ratingValue: company.rating.toStringAsFixed(2),
                  ratingCount: company.reviewsCount.toString(),
                  onTap: () =>
                       sl<AppNavigator>().push(screen: CompanyProfileView(vendorId: company.id)),
                  actionText: company.isFollowing
                      ? context.tr.followingsUnfollow
                      : context.tr.follow,
                  isActive: company.isFollowing,
                  vendorId: company.id,
                  onAction: () => context
                      .read<FollowingsCubit>()
                      .toggleFollowVendor(company.id),
                );
              },
            ),
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
    required this.onTap,
    required this.actionText,
    required this.isActive,
    required this.vendorId,
    required this.onAction,
  });

  final String name;
  final String logoAsset;
  final String ratingValue;
  final String ratingCount;
  final VoidCallback onTap;
  final String actionText;
  final bool isActive;
  final int vendorId;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final isActionLoading = context.select<FollowingsCubit, bool>(
      (cubit) => cubit.isFollowBusy(vendorId),
    );

    final borderColor = AppColors.border(context).withValues(alpha: 0.8);

    return Material(
      color: AppColors.cardBg(context),
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
                  color: AppColors.lightBg(context),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.border(context)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Image.network(
                    logoAsset,
                    fit: BoxFit.cover,
                    width: 54.r,
                    height: 54.r,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(
                        child: SizedBox(
                          width: 20.r,
                          height: 20.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Icon(
                      Iconsax.building,
                      color: AppColors.greyText(context),
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
                        color: AppColors.darkText(context),
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
                            color: AppColors.darkText(context),
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '($ratingCount)',
                          style: AppTextStyles.bodySmall(
                            color: AppColors.greyText(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              OutlinedButton(
                onPressed: isActionLoading ? null : onAction,
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
                child: isActionLoading
                    ? SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.error,
                        ),
                      )
                    : Text(
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
