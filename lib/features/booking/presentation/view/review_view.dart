import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/review_figma_tokens.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'package:trip_marche/features/nav_bar/presentation/view/main_nav_view.dart';
import '../widgets/booking_bottom_buttons.dart';
import '../widgets/coupon_field.dart';
import '../widgets/payment_details_card.dart';
import '../widgets/review_trip_card.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({required this.data, super.key});

  final BookingReviewData data;

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  static const double _couponDiscount = 100;

  final _couponController = TextEditingController();
  bool _couponApplied = false;
  bool _isPaying = false;

  BookingPriceBreakdown get _breakdown {
    return widget.data.priceBreakdown.copyWith(
      couponDiscount: _couponApplied ? _couponDiscount : 0,
    );
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _applyCoupon() {
    if (_couponController.text.trim().isEmpty) {
      return;
    }
    setState(() => _couponApplied = true);
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
    final breakdown = _breakdown;

    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                    CouponField(
                      controller: _couponController,
                      title: tr.bookingReviewCouponQuestion,
                      placeholder: tr.bookingReviewCouponPlaceholder,
                      applyLabel: tr.bookingReviewCouponApply,
                      successMessage: tr.bookingReviewCouponSuccess,
                      onApply: _applyCoupon,
                      showSuccess: _couponApplied,
                    ),
                    SizedBox(height: ReviewFigmaTokens.sectionGap),
                    PaymentDetailsCard(
                      title: tr.bookingReviewPaymentDetailTitle,
                      breakdown: breakdown,
                      travelersLabel: tr.bookingReviewPaymentTravelers(
                        breakdown.travelersCount,
                      ),
                      activitiesLabel: tr.bookingReviewPaymentActivities,
                      taxesLabel: tr.bookingReviewPaymentTaxes,
                      couponLabel: tr.bookingReviewPaymentCouponCode,
                      totalLabel: tr.bookingReviewPaymentTotal,
                      currencySuffix: tr.bookingReviewCurrency,
                      showCoupon: _couponApplied,
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
    );
  }
}
