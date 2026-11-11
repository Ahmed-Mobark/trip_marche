import '../../../trip_details/presentation/trip_details_ui_formatters.dart';
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
import 'package:trip_marche/features/booking/presentation/cubit/create_booking_cubit.dart';
import 'package:trip_marche/features/payment_method/presentation/view/payment_methods_screen.dart';
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
        BlocProvider<CouponCubit>(
          create: (_) => sl<CouponCubit>()..loadBookingQuote(data),
        ),
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

  BookingPriceBreakdown _breakdown(CouponState couponState) {
    if (couponState.quote != null) return couponState.quote!.breakdown;
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

  void _onContinue() {
    final couponState = context.read<CouponCubit>().state;
    if (couponState.quote == null || couponState.isLoading) return;
    final couponCode = couponState.isApplied && couponState.appliedCode != null
        ? couponState.appliedCode
        : null;

    sl<AppNavigator>().push(
      screen: BlocProvider.value(
        value: context.read<CreateBookingCubit>(),
        child: PaymentMethodsScreen(
          reviewData: widget.data.withQuote(couponState.quote!),
          notes: _notesController.text.trim(),
          couponCode: couponCode,
          createBookingCubit: context.read<CreateBookingCubit>(),
        ),
      ),
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
                    style:
                        AppTextStyles.heading3(
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
                            terms: couponState.coupon?.terms ?? const [],
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
                            previous.coupon != current.coupon ||
                            previous.quote != current.quote,
                        builder: (context, couponState) {
                          final breakdown = _breakdown(couponState);
                          if (couponState.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (couponState.quote == null) {
                            return Column(
                              children: [
                                Text(
                                  couponState.errorMessage ??
                                      tr.bookingReviewNetworkError,
                                ),
                                TextButton(
                                  onPressed: () => context
                                      .read<CouponCubit>()
                                      .loadBookingQuote(widget.data),
                                  child: Text(tr.bookingQuoteRetry),
                                ),
                              ],
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (couponState
                                  .quote!
                                  .priceSelections
                                  .isNotEmpty) ...[
                                for (final selection
                                    in couponState.quote!.priceSelections)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      '${selection.label} × ${selection.quantity} · ${TripDetailsUiFormatters.formatAmount(selection.totalPrice, currency: couponState.quote!.currency)}',
                                    ),
                                  ),
                              ],
                              PaymentDetailsCard(
                                title: tr.bookingReviewPaymentDetailTitle,
                                breakdown: breakdown,
                                travelersLabel: tr
                                    .bookingReviewPaymentTravelers(
                                      breakdown.travelersCount,
                                    ),
                                activitiesLabel:
                                    tr.bookingReviewPaymentActivities,
                                optionalExtrasLabel: tr.bookingOptionalExtras,
                                taxesLabel: tr.bookingReviewPaymentTaxes,
                                totalLabel: tr.bookingReviewPaymentTotal,
                                currencySuffix: couponState.quote!.currency,
                                subtotalLabel: tr.bookingReviewPaymentSubtotal,
                                finalTotalLabel:
                                    tr.bookingReviewPaymentFinalTotal,
                                couponRowLabel: _couponRowLabel(
                                  context,
                                  couponState,
                                ),
                                showCouponBreakdown: couponState.isApplied,
                              ),
                              const SizedBox(height: 8),
                              Text(tr.bookingFullPaymentEgp),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: ReviewFigmaTokens.sectionGap),
                      TextField(
                        controller: _notesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Notes',
                          hintText: 'Any special requests',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  top: false,
                  child: BlocBuilder<CouponCubit, CouponState>(
                    builder: (context, state) => BookingBottomButtons(
                      onBack: () => Navigator.pop(context),
                      onPay: state.quote != null && !state.isLoading
                          ? _onContinue
                          : null,
                      isLoading: state.isLoading,
                      payLabel: tr.bookingPay,
                    ),
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
