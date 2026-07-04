import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:trip_marche/features/nav_bar/presentation/view/main_nav_view.dart';
import '../widgets/booking_bottom_buttons.dart';
import '../widgets/coupon_field.dart';
import '../widgets/payment_details_card.dart';
import '../widgets/review_trip_card.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({required this.data, super.key});

  final BookingReviewData data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CouponCubit>(),
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
  bool _isPaying = false;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

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

  Future<void> _onPay() async {
    if (_isPaying) {
      return;
    }
    setState(() => _isPaying = true);
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) {
      return;
    }
    sl<AppNavigator>().pushAndRemoveUntil(
      screen: const MainNavView(initialIndex: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;

    return BlocListener<CouponCubit, CouponState>(
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
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ReviewFigmaTokens.screenBackground,
        ),
        child: Scaffold(
          backgroundColor: ReviewFigmaTokens.screenBackground,
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
                    style: AppTextStyles.heading3(
                      color: AppColors.tripDetailsFigmaBlack,
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
                      BlocBuilder<CouponCubit, CouponState>(
                        builder: (context, couponState) {
                          return CouponField(
                            controller: _couponController,
                            title: tr.bookingReviewCouponQuestion,
                            placeholder: tr.bookingReviewCouponPlaceholder,
                            applyLabel: tr.bookingReviewCouponApply,
                            appliedLabel: tr.bookingReviewCouponApplied,
                            successMessage: couponState.successMessage ??
                                tr.bookingReviewCouponSuccess,
                            onApply: _applyCoupon,
                            onChanged: context.read<CouponCubit>().onCodeChanged,
                            showSuccess: couponState.isApplied,
                            showError: couponState.status == CouponStatus.error &&
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
                            activitiesLabel: tr.bookingReviewPaymentActivities,
                            taxesLabel: tr.bookingReviewPaymentTaxes,
                            totalLabel: tr.bookingReviewPaymentTotal,
                            currencySuffix: widget.data.currency,
                            subtotalLabel: tr.bookingReviewPaymentSubtotal,
                            finalTotalLabel: tr.bookingReviewPaymentFinalTotal,
                            couponRowLabel: _couponRowLabel(context, couponState),
                            showCouponBreakdown: couponState.isApplied,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  top: false,
                  child: BookingBottomButtons(
                    onBack: () => Navigator.pop(context),
                    onPay: _onPay,
                    payLabel: tr.bookingPay,
                    isLoading: _isPaying,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
