import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_images.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';
import 'package:trip_marche/features/my_trips/presentation/my_trips_figma_tokens.dart';

/// Figma trip card: [Stack] + full-height start image strip; safe inside [SliverList].
class MyTripsScreenTripCard extends StatelessWidget {
  const MyTripsScreenTripCard({
    super.key,
    required this.trip,
    required this.tab,
    this.onPrimaryTap,
    this.onSecondaryTap,
    this.onBottomTap,
  });

  final MyTripRowUiModel trip;
  final MyTripsShellTab tab;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;
  final VoidCallback? onBottomTap;

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;

    final (Color badgeColor, String badgeLabel) = switch (tab) {
      MyTripsShellTab.active => (
        AppColors.myTripsTripCardBadgeGreen,
        tr.myTripsStatusActive,
      ),
      MyTripsShellTab.past => (
        AppColors.myTripsBadgePast,
        tr.myTripsStatusPast,
      ),
      MyTripsShellTab.canceled => (
        AppColors.myTripsBadgeCanceled,
        tr.myTripsStatusCanceled,
      ),
    };

    final primaryLabel = tab == MyTripsShellTab.past
        ? tr.myTripsBookAgain
        : tr.myTripsViewDetails;

    final bottomLabel = switch (tab) {
      MyTripsShellTab.canceled => tr.myTripsDownloadPdf,
      MyTripsShellTab.past => tr.myTripsBookingDetails,
      MyTripsShellTab.active =>
        trip.useDownloadPdfWhenActive
            ? tr.myTripsDownloadPdf
            : tr.myTripsBookingDetails,
    };

    final secondaryLabel = tr.myTripsViewReceipt;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth + 150.w;
        final imageW = (maxW * MyTripsTripCardTokens.imageStripWidthFactor)
            .clamp(
              MyTripsTripCardTokens.imageStripMinW,
              MyTripsTripCardTokens.imageStripMaxW,
            );
        return Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg(context),
            borderRadius: BorderRadius.circular(
              MyTripsTripCardTokens.cardRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(
                  alpha: MyTripsTripCardTokens.shadowAlpha,
                ),
                blurRadius: MyTripsTripCardTokens.shadowBlur,
                offset: Offset(0, MyTripsTripCardTokens.shadowY),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              PositionedDirectional(
                start: 0,
                top: 6.h,
                bottom: 6.h,
                width: imageW,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    MyTripsTripCardTokens.cardRadius,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _TripThumb(imageUrl: trip.imageUrl),
                      PositionedDirectional(
                        top: MyTripsTripCardTokens.badgeInset,
                        start: MyTripsTripCardTokens.badgeInset,
                        child: Container(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: MyTripsTripCardTokens.badgePadH,
                            vertical: MyTripsTripCardTokens.badgePadV,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(
                              MyTripsFigmaTokens.searchRadiusPill,
                            ),
                          ),
                          child: Text(
                            badgeLabel,
                            style: MyTripsFigmaTokens.text(
                              fontSize: MyTripsTripCardTokens.badgeFont,
                              fontWeight: FontWeight.w500,
                              height: MyTripsTripCardTokens.lh(11, 13),
                              letterSpacing: 0,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: imageW + MyTripsTripCardTokens.contentPad,
                  top: MyTripsTripCardTokens.contentPad,
                  end: MyTripsTripCardTokens.contentPad,
                  bottom: MyTripsTripCardTokens.contentPad,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            trip.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: MyTripsFigmaTokens.text(
                              fontSize: MyTripsTripCardTokens.titleFont,
                              fontWeight: FontWeight.w700,
                              height: MyTripsTripCardTokens.lh(18, 21),
                              letterSpacing: 0,
                              color: AppColors.myTripsTripCardInk(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: MyTripsTripCardTokens.favoriteStartPad,
                          ),
                          child: Material(
                            color: AppColors.transparent,
                            child: InkWell(
                              onTap: () => context
                                  .read<MyTripsShellCubit>()
                                  .toggleWishlist(trip.id),
                              customBorder: const CircleBorder(),
                              child: Container(
                                width: MyTripsTripCardTokens.favoriteSize,
                                height: MyTripsTripCardTokens.favoriteSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.greyTextColorDarkOpacity50,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  trip.isWishlisted
                                      ? Iconsax.heart5
                                      : Iconsax.heart,
                                  size: MyTripsTripCardTokens.favoriteIcon,
                                  color: AppColors.myTripsTripCardRed,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MyTripsTripCardTokens.rowTight),
                    Row(
                      children: [
                        Icon(
                          Iconsax.star1,
                          size: MyTripsTripCardTokens.starSize,
                          color: AppColors.myTripsTripCardStar,
                        ),
                        SizedBox(width: MyTripsTripCardTokens.starToText),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: trip.rating.toStringAsFixed(1),
                                style: MyTripsFigmaTokens.text(
                                  fontSize: MyTripsTripCardTokens.metaFont,
                                  fontWeight: FontWeight.w700,
                                  height: MyTripsTripCardTokens.lh(14, 18),
                                  letterSpacing: 0,
                                  color: AppColors.myTripsTripCardInk(context),
                                ),
                              ),
                              TextSpan(
                                text: '(${trip.reviewCount})',
                                style: MyTripsFigmaTokens.text(
                                  fontSize: MyTripsTripCardTokens.metaFont,
                                  fontWeight: FontWeight.w400,
                                  height: MyTripsTripCardTokens.lh(14, 18),
                                  letterSpacing: 0,
                                  color: AppColors.myTripsTripCardMuted(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MyTripsTripCardTokens.rowTight),
                    _MetaRow(icon: Iconsax.location, text: trip.locationLabel),
                    SizedBox(height: MyTripsTripCardTokens.rowTight),
                    _MetaRow(icon: Iconsax.calendar_1, text: trip.dateRange),
                    SizedBox(height: MyTripsTripCardTokens.beforeActions),
                    Row(
                      children: [
                        Expanded(
                          child: _FilledCta(
                            label: primaryLabel,
                            onTap: onPrimaryTap,
                          ),
                        ),
                        SizedBox(width: MyTripsTripCardTokens.twinGap),
                        Expanded(
                          child: _OutlineCta(
                            label: secondaryLabel,
                            onTap: onSecondaryTap,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MyTripsTripCardTokens.belowTwinRow),
                    _FooterCta(label: bottomLabel, onTap: onBottomTap),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TripThumb extends StatelessWidget {
  const _TripThumb({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final u = imageUrl;
    if (u == null || u.startsWith('assets/')) {
      return Image.asset(
        u ?? AppImages.tripPlaceholder,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    }
    return AppCachedNetworkImage(imageUrl: u, fit: BoxFit.cover);
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: MyTripsTripCardTokens.metaIcon,
          color: AppColors.myTripsTripCardMuted(context),
        ),
        SizedBox(width: MyTripsTripCardTokens.metaIconGap),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: MyTripsFigmaTokens.text(
              fontSize: MyTripsTripCardTokens.metaFont,
              fontWeight: FontWeight.w400,
              height: MyTripsTripCardTokens.lh(14, 18),
              letterSpacing: 0,
              color: AppColors.myTripsTripCardMuted(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _FilledCta extends StatelessWidget {
  const _FilledCta({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(MyTripsTripCardTokens.twinRadius),
        child: Container(
          height: MyTripsTripCardTokens.twinH,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: MyTripsTripCardTokens.twinPadH,
          ),
          decoration: BoxDecoration(
            color: AppColors.myTripsTripCardPurple,
            borderRadius: BorderRadius.circular(
              MyTripsTripCardTokens.twinRadius,
            ),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: MyTripsFigmaTokens.text(
              fontSize: MyTripsTripCardTokens.twinFont,
              fontWeight: FontWeight.w400,
              height: MyTripsTripCardTokens.lh(14, 18),
              letterSpacing: 0,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineCta extends StatelessWidget {
  const _OutlineCta({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(MyTripsTripCardTokens.twinRadius),
        child: Container(
          height: MyTripsTripCardTokens.twinH,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: MyTripsTripCardTokens.twinPadH,
          ),
          decoration: BoxDecoration(
            color: AppColors.cardBg(context),
            borderRadius: BorderRadius.circular(
              MyTripsTripCardTokens.twinRadius,
            ),
            border: Border.all(
              color: AppColors.myTripsTripCardBorder(context),
              width: 1.w,
            ),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: MyTripsFigmaTokens.text(
              fontSize: MyTripsTripCardTokens.twinFont,
              fontWeight: FontWeight.w600,
              height: MyTripsTripCardTokens.lh(14, 18),
              letterSpacing: 0,
              color: AppColors.myTripsTripCardInk(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterCta extends StatelessWidget {
  const _FooterCta({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(MyTripsTripCardTokens.footerRadius),
        child: Container(
          height: MyTripsTripCardTokens.footerH,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.cardBg(context),
            borderRadius: BorderRadius.circular(
              MyTripsTripCardTokens.footerRadius,
            ),
            border: Border.all(
              color: AppColors.myTripsTripCardBorder(context),
              width: 1.w,
            ),
          ),
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: MyTripsTripCardTokens.footerPadH,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.picture_as_pdf_rounded,
                size: MyTripsTripCardTokens.pdfSize,
                color: AppColors.myTripsTripCardRed,
              ),
              SizedBox(width: MyTripsTripCardTokens.pdfGap),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: MyTripsFigmaTokens.text(
                    fontSize: MyTripsTripCardTokens.footerFont,
                    fontWeight: FontWeight.w600,
                    height: MyTripsTripCardTokens.lh(14, 18),
                    letterSpacing: 0,
                    color: AppColors.myTripsTripCardInk(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
