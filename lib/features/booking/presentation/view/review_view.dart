import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/review_figma_tokens.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'package:trip_marche/features/booking/presentation/cubit/coupon_cubit.dart';
import 'package:trip_marche/features/booking/presentation/cubit/coupon_state.dart';
import 'package:trip_marche/features/booking/presentation/cubit/create_booking_cubit.dart';
import 'package:trip_marche/features/booking/presentation/cubit/create_booking_state.dart';
import 'package:trip_marche/features/nav_bar/presentation/view/main_nav_view.dart';
import 'package:trip_marche/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:trip_marche/features/payment_method/presentation/view/payment_methods_screen.dart';
import 'package:trip_marche/features/booking/presentation/view/payment_webview_screen.dart';
import '../widgets/booking_bottom_buttons.dart';
import '../widgets/coupon_field.dart';
import '../widgets/payment_details_card.dart';
import '../widgets/review_trip_card.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({required this.data, super.key});

  final BookingReviewData data;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CouponCubit>(create: (_) => sl<CouponCubit>()),
        BlocProvider<CreateBookingCubit>(
          create: (_) => sl<CreateBookingCubit>(),
        ),
      ],
      child: _ReviewBody(data: data),
    );
  }
}

class _ReviewBody extends StatefulWidget {
  const _ReviewBody({required this.data});

  final BookingReviewData data;

  @override
  State<_ReviewBody> createState() => _ReviewBodyState();
}

class _ReviewBodyState extends State<_ReviewBody> {
  final _couponController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool get _isPaying => context.watch<CreateBookingCubit>().state.isLoading;

  BookingPriceBreakdown _breakdown(CouponState couponState) {
    final discount = couponState.isApplied
        ? couponState.coupon!.discountAmount
        : 0.0;
    return widget.data.priceBreakdown.copyWith(couponDiscount: discount);
  }

  String? _couponRowLabel(BuildContext context, CouponState couponState) {
    final coupon = couponState.coupon;
    if (coupon == null) {
      return null;
    }
    final tr = context.tr;
    if (coupon.isPercent) {
      return tr.bookingReviewCouponPercentLabel(
        coupon.code,
        coupon.value.toStringAsFixed(0),
      );
    }
    return tr.bookingReviewCouponFixedLabel(coupon.code);
  }

  void _applyCoupon() {
    final code = _couponController.text.trim();
    if (code.isEmpty) {
      return;
    }
    context.read<CouponCubit>().applyCoupon(
      code: code,
      tripId: widget.data.tripId,
      amount: widget.data.priceBreakdown.subtotal,
    );
  }

  void _onPay() {
    final couponState = context.read<CouponCubit>().state;
    final couponCode = couponState.isApplied && couponState.appliedCode != null
        ? couponState.appliedCode
        : null;

    context.read<CreateBookingCubit>().createBooking(
      data: widget.data,
      notes: _notesController.text.trim(),
      couponCode: couponCode,
    );
  }

  void _showCreateBookingErrors(Map<String, String> errors) {
    final messages = errors.values.toSet().toList();
    if (messages.isEmpty) {
      return;
    }
    appToast(context: context, type: ToastType.error, message: messages.first);
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;
    final selectedMethod = context
        .watch<CreateBookingCubit>()
        .state
        .selectedPaymentMethod;

    return BlocListener<CreateBookingCubit, CreateBookingState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          (current.isValidationFailure ||
              current.isFailure ||
              current.isSuccess),
      listener: (context, state) {
        if (state.isValidationFailure && state.validationErrors != null) {
          _showCreateBookingErrors(state.validationErrors!);
        } else if (state.isSuccess) {
          final apiMessage = state.bookingResponse?.message;
          final requiresPayment =
              state.bookingResponse?.data?.requiresPayment == true;
          final checkoutUrl = state.bookingResponse?.data?.payment?.checkoutUrl;

          if (requiresPayment && checkoutUrl != null) {
            if (!mounted) return;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PaymentWebViewScreen(
                  url: checkoutUrl,
                  onPaymentComplete: () {
                    if (!mounted) return;
                    appToast(
                      context: context,
                      type: ToastType.success,
                      message:
                          apiMessage != null && apiMessage.trim().isNotEmpty
                          ? apiMessage
                          : tr.bookingCreatedSuccess,
                    );
                    sl<AppNavigator>().pushAndRemoveUntil(
                      screen: const MainNavView(initialIndex: 1),
                    );
                  },
                ),
              ),
            );
            return;
          }

          appToast(
            context: context,
            type: ToastType.success,
            message: apiMessage != null && apiMessage.trim().isNotEmpty
                ? apiMessage
                : tr.bookingCreatedSuccess,
          );
          sl<AppNavigator>().pushAndRemoveUntil(
            screen: const MainNavView(initialIndex: 1),
          );
        } else if (state.isFailure && state.errorMessage != null) {
          appToast(
            context: context,
            type: ToastType.error,
            message: state.errorMessage!,
          );
        }
      },
      child: BlocListener<CouponCubit, CouponState>(
        listenWhen: (previous, current) =>
            current.showNetworkError && !previous.showNetworkError,
        listener: (context, state) {
          appToast(
            context: context,
            type: ToastType.error,
            message: tr.bookingReviewNetworkError,
          );
          context.read<CouponCubit>().clearNetworkErrorFlag();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
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
                      top: ReviewFigmaTokens.titleTop,
                      bottom: ReviewFigmaTokens.titleBottom,
                    ),
                    child: Text(
                      tr.bookingReviewTitle,
                      textAlign: TextAlign.center,
                      style:
                          AppTextStyles.heading3(
                            color: AppColors.ink(context),
                          ).copyWith(
                            fontSize: ReviewFigmaTokens.titleFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        ReviewFigmaTokens.screenPadding,
                        0,
                        ReviewFigmaTokens.screenPadding,
                        ReviewFigmaTokens.listBottom,
                      ),
                      children: [
                        ReviewTripCard(
                          trip: widget.data.trip,
                          includedTitle: tr.tripDetailsWhatsIncludedTitle,
                        ),
                        SizedBox(height: ReviewFigmaTokens.sectionGap),
                        GestureDetector(
                          onTap: () async {
                            final result =
                                await Navigator.push<PaymentMethodEntity>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const PaymentMethodsScreen(),
                                  ),
                                );
                            if (result != null) {
                              context
                                  .read<CreateBookingCubit>()
                                  .selectPaymentMethod(result);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.cardBg(context),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: AppColors.softBorder(context),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  tr.bookingPaymentMethodTitle,
                                  style:
                                      AppTextStyles.bodySmall(
                                        color: AppColors.greyText(context),
                                      ).copyWith(
                                        fontSize: ReviewFigmaTokens.smallSize,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                SizedBox(height: 8.h),
                                if (selectedMethod != null) ...[
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.card,
                                        size: 20.w,
                                        color: AppColors.primary,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          selectedMethod.name,
                                          style:
                                              AppTextStyles.bodyMedium(
                                                color: AppColors.darkText(
                                                  context,
                                                ),
                                              ).copyWith(
                                                fontSize:
                                                    ReviewFigmaTokens.bodySize,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    selectedMethod.description,
                                    style:
                                        AppTextStyles.bodySmall(
                                          color: AppColors.greyText(context),
                                        ).copyWith(
                                          fontSize: ReviewFigmaTokens.smallSize,
                                        ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    tr.bookingPaymentMethodChange,
                                    style:
                                        AppTextStyles.bodyMedium(
                                          color: AppColors.primary,
                                        ).copyWith(
                                          fontSize: ReviewFigmaTokens.bodySize,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ] else ...[
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.card,
                                        size: 20.w,
                                        color: AppColors.greyText(context),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          tr.bookingPaymentMethodSelect,
                                          style:
                                              AppTextStyles.bodyMedium(
                                                color: AppColors.greyText(
                                                  context,
                                                ),
                                              ).copyWith(
                                                fontSize:
                                                    ReviewFigmaTokens.bodySize,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    tr.bookingPaymentMethodChoose,
                                    style:
                                        AppTextStyles.bodySmall(
                                          color: AppColors.greyText(context),
                                        ).copyWith(
                                          fontSize: ReviewFigmaTokens.smallSize,
                                        ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '>',
                                    style:
                                        AppTextStyles.bodyMedium(
                                          color: AppColors.primary,
                                        ).copyWith(
                                          fontSize: ReviewFigmaTokens.bodySize,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: ReviewFigmaTokens.sectionGap),
                        BlocBuilder<CouponCubit, CouponState>(
                          builder: (context, couponState) {
                            return CouponField(
                              controller: _couponController,
                              title: tr.bookingReviewCouponQuestion,
                              placeholder: tr.bookingReviewCouponPlaceholder,
                              applyLabel: tr.bookingReviewCouponApply,
                              appliedLabel: tr.bookingReviewCouponApplied,
                              successMessage:
                                  couponState.successMessage ??
                                  tr.bookingReviewCouponSuccess,
                              onApply: _applyCoupon,
                              onChanged: context
                                  .read<CouponCubit>()
                                  .onCodeChanged,
                              showSuccess: couponState.isApplied,
                              showError:
                                  couponState.status == CouponStatus.error &&
                                  couponState.errorMessage != null,
                              errorMessage: couponState.errorMessage,
                              isLoading: couponState.isLoading,
                              isApplied: couponState.isApplied,
                            );
                          },
                        ),
                        SizedBox(height: ReviewFigmaTokens.sectionGap),
                        BlocBuilder<CouponCubit, CouponState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status ||
                              previous.coupon != current.coupon,
                          builder: (context, couponState) {
                            final breakdown = _breakdown(couponState);
                            return PaymentDetailsCard(
                              title: tr.bookingReviewPaymentDetailTitle,
                              breakdown: breakdown,
                              travelersLabel: tr.bookingReviewPaymentTravelers(
                                breakdown.travelersCount,
                              ),
                              activitiesLabel:
                                  tr.bookingReviewPaymentActivities,
                              taxesLabel: tr.bookingReviewPaymentTaxes,
                              totalLabel: tr.bookingReviewPaymentTotal,
                              currencySuffix: widget.data.currency,
                              subtotalLabel: tr.bookingReviewPaymentSubtotal,
                              finalTotalLabel:
                                  tr.bookingReviewPaymentFinalTotal,
                              couponRowLabel: _couponRowLabel(
                                context,
                                couponState,
                              ),
                              showCouponBreakdown: couponState.isApplied,
                            );
                          },
                        ),
                        SizedBox(height: ReviewFigmaTokens.sectionGap),
                        TextField(
                          controller: _notesController,
                          maxLines: 3,
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.ink(context),
                          ).copyWith(fontSize: ReviewFigmaTokens.bodySize),
                          decoration: InputDecoration(
                            labelText: 'Notes',
                            hintText: 'Any special requests',
                            labelStyle: AppTextStyles.bodySmall(
                              color: AppColors.captionText(context),
                            ).copyWith(fontSize: ReviewFigmaTokens.smallSize),
                            hintStyle: AppTextStyles.body(
                              color: AppColors.captionText(context),
                            ).copyWith(fontSize: ReviewFigmaTokens.bodySize),
                            filled: true,
                            fillColor: AppColors.cardBg(context),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.softBorder(context),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.softBorder(context),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: BlocBuilder<CreateBookingCubit, CreateBookingState>(
                      builder: (context, state) {
                        return BookingBottomButtons(
                          onBack: () => Navigator.pop(context),
                          onPay: _onPay,
                          payLabel: tr.bookingPay,
                          isLoading: _isPaying,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
