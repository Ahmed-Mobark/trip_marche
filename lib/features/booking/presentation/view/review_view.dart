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
import 'package:trip_marche/features/booking/presentation/cubit/create_booking_state.dart';
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

  bool get _isPaying =>
      context.watch<CreateBookingCubit>().state.isLoading;

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
    appToast(
      context: context,
      type: ToastType.error,
      message: messages.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;

    return BlocListener<CreateBookingCubit, CreateBookingState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          (current.isValidationFailure || current.isFailure || current.isSuccess),
      listener: (context, state) {
        if (state.isValidationFailure && state.validationErrors != null) {
          _showCreateBookingErrors(state.validationErrors!);
        } else if (state.isSuccess) {
          final apiMessage = state.bookingResponse?.message;
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
                      style: AppTextStyles.heading3(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: AppColors.softBorder(context),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: AppColors.softBorder(context),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                              ),
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
