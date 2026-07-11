import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/widgets/app_empty_screen.dart';
import 'package:trip_marche/core/widgets/shimmer_widget.dart';
import 'package:trip_marche/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:trip_marche/features/payment_method/presentation/cubit/payment_methods_cubit.dart';
import 'package:trip_marche/features/payment_method/presentation/cubit/payment_methods_state.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentMethodsCubit>(
      create: (_) => sl<PaymentMethodsCubit>()..loadPaymentMethods(),
      child: const _PaymentMethodsBody(),
    );
  }
}

class _PaymentMethodsBody extends StatelessWidget {
  const _PaymentMethodsBody();

  IconData _mapIconKeyToIconData(String key) {
    switch (key) {
      case 'credit-card':
        return Iconsax.card;
      case 'cash':
        return Iconsax.money;
      case 'mobile':
        return Iconsax.mobile;
      case 'building':
        return Iconsax.building;
      case 'wallet':
        return Iconsax.wallet_3;
      case 'bank':
        return Iconsax.building;
      default:
        return Iconsax.card;
    }
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
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 8.h,
                  bottom: 12.h,
                  start: 16.w,
                  end: 16.w,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.darkText(context),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        tr.bookingPaymentMethodTitle,
                        textAlign: TextAlign.center,
                        style:
                            AppTextStyles.bodyMedium(
                              color: AppColors.darkText(context),
                            ).copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 48.w),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return _buildLoadingShimmer(context);
                    }
                    if (state.isFailure) {
                      return _buildErrorState(context, state.errorMessage);
                    }
                    if (state.isEmpty) {
                      return AppEmptyScreen(
                        title: tr.paymentMethodEmptyTitle,
                        description: tr.paymentMethodEmptyDescription,
                      );
                    }
                    return _buildMethodsList(context, state);
                  },
                ),
              ),
              _buildContinueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 16.h),
      itemCount: 4,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, __) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.cardBg(context),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.softBorder(context)),
          ),
          child: Row(
            children: [
              ShimmerContainer(width: 44.w, height: 44.h, borderRadius: 10.r),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerContainer(
                      width: double.infinity,
                      height: 14.h,
                      borderRadius: 4.r,
                      margin: EdgeInsets.only(bottom: 8.h),
                    ),
                    ShimmerContainer(
                      width: 200.w,
                      height: 12.h,
                      borderRadius: 4.r,
                    ),
                  ],
                ),
              ),
              ShimmerContainer(width: 20.w, height: 20.h, borderRadius: 10.r),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, String? errorMessage) {
    final tr = context.tr;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.warning_2,
              size: 48.w,
              color: AppColors.greyText(context),
            ),
            SizedBox(height: 16.h),
            Text(
              tr.paymentMethodErrorTitle,
              style: AppTextStyles.bodyMedium(
                color: AppColors.darkText(context),
              ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              errorMessage ?? tr.paymentMethodErrorDescription,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall(
                color: AppColors.greyText(context),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: () =>
                  context.read<PaymentMethodsCubit>().loadPaymentMethods(),
              icon: Icon(Iconsax.refresh, size: 18.w, color: AppColors.onImage),
              label: Text(
                tr.paymentMethodRetry,
                style: TextStyles.textViewSemiBold14.copyWith(
                  color: AppColors.onImage,
                  fontSize: 14.sp,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodsList(BuildContext context, PaymentMethodsState state) {
    final cubit = context.read<PaymentMethodsCubit>();
    return ListView.separated(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 16.h),
      itemCount: state.paymentMethods.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final method = state.paymentMethods[index];
        final iconData = _mapIconKeyToIconData(method.icon);
        final isSelected = state.selectedPaymentMethod?.key == method.key;

        return Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.selectedPurpleTint(context)
                : AppColors.cardBg(context),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.softBorder(context),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: RadioListTile<PaymentMethodEntity>(
            value: method,
            groupValue: isSelected ? method : null,
            onChanged: (value) {
              if (value != null) {
                cubit.selectPaymentMethod(value);
              }
            },
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 4.h,
            ),
            secondary: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.border(context).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                iconData,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.greyText(context),
                size: 22.w,
              ),
            ),
            title: Text(
              method.name,
              style: AppTextStyles.bodyMedium(
                color: AppColors.darkText(context),
              ),
            ),
            subtitle: Text(
              method.description,
              style: AppTextStyles.bodySmall(
                color: AppColors.greyText(context),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    final cubit = context.watch<PaymentMethodsCubit>();
    final hasSelection = cubit.state.selectedPaymentMethod != null;

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 20.h),
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        border: Border(top: BorderSide(color: AppColors.softBorder(context))),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.06),
            blurRadius: 8.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: hasSelection
              ? () {
                  final selected = cubit.state.selectedPaymentMethod;
                  if (selected != null) {
                    Navigator.pop(context, selected);
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: AppColors.disabled(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            context.tr.paymentMethodContinue,
            style: TextStyles.textViewSemiBold14.copyWith(
              color: AppColors.onImage,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
