import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/domain/usecases/get_trip_details_usecase.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';
import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';
import '../cubit/trip_details_cubit.dart';
import '../cubit/trip_details_state.dart';
import '../trip_wishlist_pop_result.dart';
import '../widgets/trip_details_booking_bar.dart';
import '../widgets/trip_details_hero_header.dart';
import '../widgets/trip_details_stat_grid.dart';
import '../widgets/trip_details_post_stats_sections.dart';
import '../widgets/trip_details_program_section.dart';
import '../widgets/trip_details_travel_sections.dart';

class TripDetailsView extends StatelessWidget {
  const TripDetailsView({
    super.key,
    required this.tripId,
    this.initialIsWishlisted = false,
  });

  final int tripId;
  final bool initialIsWishlisted;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TripDetailsCubit(
        sl<TripWishlistRepository>(),
        sl<GetTripDetailsUseCase>(),
        tripId: tripId,
        initialIsWishlisted: initialIsWishlisted,
      )..loadTrip(),
      child: ValueListenableBuilder<AdaptiveThemeMode>(
        valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
        builder: (context, _, __) => const _TripDetailsBody(),
      ),
    );
  }
}

class _TripDetailsBody extends StatelessWidget {
  const _TripDetailsBody();

  Widget _buildStatGrid(BuildContext context, TripDetails trip) {
    final typeValue = trip.flags.international
        ? context.tr.tripDetailsTypeValue
        : context.tr.tripDetailsTypeDomestic;

    return TripDetailsStatGrid(
      cells: [
        TripDetailsStatCellData(
          icon: Icons.calendar_today_outlined,
          label: context.tr.tripDetailsDurationLabel,
          value: '${trip.durationDays} ${context.tr.tripDetailsDurationUnit}',
        ),
        TripDetailsStatCellData(
          icon: Icons.groups_outlined,
          label: context.tr.tripDetailsGroupSizeLabel,
          value: '${trip.groupSize.min}-${trip.groupSize.max}',
        ),
        TripDetailsStatCellData(
          icon: Icons.location_city_outlined,
          label: context.tr.tripDetailsStatCitiesLabel,
          value: context.tr.tripDetailsStatCitiesCount(trip.citiesCount),
        ),
        TripDetailsStatCellData(
          icon: Icons.airplanemode_active_outlined,
          label: context.tr.tripDetailsTypeLabel,
          value: typeValue,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 16.w;

    final sheetOverlap = 5.h;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        if (!context.mounted) {
          return;
        }
        final cubit = context.read<TripDetailsCubit>();
        Navigator.of(context).pop(
          TripWishlistPopResult(
            tripId: cubit.tripId,
            isWishlisted: cubit.state.isFavorite,
          ),
        );
      },
      child: BlocListener<TripDetailsCubit, TripDetailsState>(
        listenWhen: (previous, current) =>
            current.wishlistFeedback != null &&
            current.wishlistFeedback != previous.wishlistFeedback,
        listener: (context, state) {
          final feedback = state.wishlistFeedback;
          if (feedback == null || !feedback.isError) {
            return;
          }
          appToast(
            context: context,
            type: ToastType.error,
            message: feedback.message,
          );
          context.read<TripDetailsCubit>().clearWishlistFeedback();
        },
        child: Scaffold(
          backgroundColor: AppColors.tripDetailsScreenBg(context),
          body: BlocBuilder<TripDetailsCubit, TripDetailsState>(
            buildWhen: (p, n) =>
                p.loadStatus != n.loadStatus ||
                p.loadError != n.loadError ||
                p.trip != n.trip,
            builder: (context, state) {
              if (state.loadStatus == TripDetailsLoadStatus.loading ||
                  state.loadStatus == TripDetailsLoadStatus.initial) {
                return const Center(child: CustomLoading(top: 40, bottom: 40));
              }
              if (state.loadStatus == TripDetailsLoadStatus.failure) {
                return Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.loadError ?? context.tr.tripDetailsFailedToLoad,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 16.h),
                        FilledButton(
                          onPressed: () =>
                              context.read<TripDetailsCubit>().loadTrip(),
                          child: Text(context.tr.tripDetailsTryAgain),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final trip = state.trip;
              if (trip == null) {
                return Center(child: Text(context.tr.tripDetailsFailedToLoad));
              }

              final displayPrice = TripDetailsUiFormatters.formatAmount(
                trip.discountPrice ?? trip.price,
                currency: trip.currency,
              );
              final payExtra =
                  trip.payOnArrivalAmount != null &&
                      trip.payOnArrivalAmount! > 0
                  ? TripDetailsUiFormatters.formatAmount(
                      trip.payOnArrivalAmount!,
                      currency: trip.currency,
                    )
                  : null;

              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: TripDetailsHeroHeader(trip: trip),
                      ),
                      SliverToBoxAdapter(
                        child: Transform.translate(
                          offset: Offset(0, -sheetOverlap),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.cardBg(context),
                            ),
                            child: MediaQuery(
                              data: MediaQuery.of(
                                context,
                              ).copyWith(textScaler: TextScaler.noScaling),
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: horizontalPadding,
                                  end: horizontalPadding,
                                  top: 16.h,
                                  bottom: 140.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildStatGrid(context, trip),
                                    TripDetailsPostStatsSections(trip: trip),
                                    TripDetailsProgramSection(trip: trip),
                                    TripDetailsTravelSections(trip: trip),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  PositionedDirectional(
                    bottom: -15,
                    start: 0,
                    end: 0,
                    child: TripDetailsBookingBar(
                      priceLabel: context.tr.tripDetailsStartingFrom,
                      priceText: displayPrice,
                      secondaryLabel: payExtra != null
                          ? context.tr.tripDetailsPayOnArrival
                          : null,
                      secondaryBadgeText: payExtra,
                      bookNowText: context.tr.tripDetailsBookNow,
                      onBookNow: () {},
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
