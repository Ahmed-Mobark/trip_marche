import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_constants.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import '../cubit/my_trips_list_cubit.dart';
import '../cubit/my_trips_list_state.dart';
import '../widgets/my_trip_booking_card.dart';
import '../widgets/my_trip_catalog_card.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

class TrendingDestinationView extends StatefulWidget {
  const TrendingDestinationView({
    super.key,
    this.catalogDestinationId,
    this.destinationBrowseTitle,
    this.catalogDestinationImageUrl,
    this.catalogDestinationCountry,
  });

  final int? catalogDestinationId;

  final String? destinationBrowseTitle;

  final String? catalogDestinationImageUrl;

  final String? catalogDestinationCountry;

  @override
  State<TrendingDestinationView> createState() =>
      _TrendingDestinationViewState();
}

class _TrendingDestinationViewState extends State<TrendingDestinationView> {
  static const Duration _searchDebounce = Duration(milliseconds: 500);

  late final MyTripsListCubit _listCubit;
  late final ScrollController _scroll;
  late final TextEditingController _searchCtrl;
  Timer? _searchDebounceTimer;

  String _lastAppliedSearchKey = '';

  int _selectedTab = 0;

  bool get _isDestinationBrowse => widget.catalogDestinationId != null;

  int? _effectiveDestinationIdForCatalog() {
    if (widget.catalogDestinationId != null) {
      return widget.catalogDestinationId;
    }
    if (AppConstants.myTripsCatalogSendDestinationId) {
      return AppConstants.myTripsCatalogDestinationId;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController();
    _listCubit = sl<MyTripsListCubit>();
    _listCubit.setFilters(destinationId: _effectiveDestinationIdForCatalog());
    _lastAppliedSearchKey = _normalizedSearchKey(_searchCtrl.text);
    _listCubit.loadInitial();
    _scroll = ScrollController()..addListener(_onScroll);
  }

  String _normalizedSearchKey(String raw) {
    final t = raw.trim();
    return t.isEmpty ? '' : t;
  }

  void _scheduleDebouncedSearch() {
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(_searchDebounce, _applyCatalogQueryFromField);
  }

  void _applyCatalogQueryFromField({bool force = false}) {
    _searchDebounceTimer?.cancel();
    if (!mounted) {
      return;
    }
    if (!_isDestinationBrowse && _selectedTab != 0) {
      return;
    }
    final key = _normalizedSearchKey(_searchCtrl.text);
    if (!force && key == _lastAppliedSearchKey) {
      return;
    }
    _lastAppliedSearchKey = key;
    _listCubit.setFilters(
      search: _searchCtrl.text,
      destinationId: _effectiveDestinationIdForCatalog(),
    );
    if (_scroll.hasClients) {
      _scroll.jumpTo(0);
    }
    _listCubit.loadInitial();
  }

  void _onSearchTextChanged(String _) {
    _scheduleDebouncedSearch();
  }

  void _flushSearchImmediate() {
    FocusScope.of(context).unfocus();
    _searchDebounceTimer?.cancel();
    _applyCatalogQueryFromField();
  }

  void _clearSearchField() {
    if (_searchCtrl.text.isEmpty) {
      return;
    }
    _searchCtrl.clear();
    _searchDebounceTimer?.cancel();
    _applyCatalogQueryFromField(force: true);
  }

  void _onTripTabChanged(int index) {
    if (_selectedTab == index) {
      return;
    }
    final leavingActive = _selectedTab == 0 && index != 0;
    setState(() => _selectedTab = index);
    if (leavingActive) {
      _searchDebounceTimer?.cancel();
    }
    if (index == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _applyCatalogQueryFromField();
      });
    }
  }

  void _onScroll() {
    if (!_scroll.hasClients) {
      return;
    }
    if (!_isDestinationBrowse && _selectedTab != 0) {
      return;
    }
    final pos = _scroll.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      _listCubit.loadMore();
    }
  }

  double _heroRatingFromTrips(List<WishlistTripItem> trips) {
    if (trips.isEmpty) {
      return 4.9;
    }
    var sum = 0.0;
    for (final t in trips) {
      sum += t.rating;
    }
    return (sum / trips.length).clamp(0.0, 5.0);
  }

  @override
  void dispose() {
    _searchDebounceTimer?.cancel();
    _searchCtrl.dispose();
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    _listCubit.close();
    super.dispose();
  }

  static const double _kSheetOverlapDesignPx = 18;
  static const double _kSheetTopRadiusDesignPx = 24;

  double _headerReserveBelowSafeArea() {
    return 10.h + 26.h + 18.h;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final topInset = media.padding.top;
    final bottomInset = media.padding.bottom;
    final sheetOverlap = _kSheetOverlapDesignPx.h;
    final sheetRadius = _kSheetTopRadiusDesignPx.r;
    final headerReserve = topInset + _headerReserveBelowSafeArea();
    final sheetTop = headerReserve - sheetOverlap;

    final legacyTrips = switch (_selectedTab) {
      0 => <TripItem>[],
      1 => DummyData.pastTrips,
      _ => DummyData.upcomingTrips,
    };

    final status = switch (_selectedTab) {
      0 => (
        context.tr.myTripsStatusActive,
        AppColors.success,
        context.tr.myTripsViewDetails,
        context.tr.myTripsBookingDetails,
      ),
      1 => (
        context.tr.myTripsStatusPast,
        AppColors.error,
        context.tr.myTripsBookAgain,
        context.tr.myTripsBookingDetails,
      ),
      _ => (
        context.tr.myTripsStatusCanceled,
        AppColors.greyText,
        context.tr.myTripsViewDetails,
        context.tr.myTripsDownloadPdf,
      ),
    };

    return BlocProvider.value(
      value: _listCubit,
      child: BlocListener<MyTripsListCubit, MyTripsListState>(
        listenWhen: (p, n) =>
            n.wishlistErrorMessage != null &&
            n.wishlistErrorMessage != p.wishlistErrorMessage,
        listener: (context, state) {
          final msg = state.wishlistErrorMessage;
          if (msg == null) {
            return;
          }
          appToast(context: context, type: ToastType.error, message: msg);
          context.read<MyTripsListCubit>().clearWishlistError();
        },
        child: _isDestinationBrowse
            ? _buildDestinationBrowseScaffold(context)
            : _buildMainTripsScaffold(
                context,
                bottomInset: bottomInset,
                sheetTop: sheetTop,
                sheetOverlap: sheetOverlap,
                sheetRadius: sheetRadius,
                legacyTrips: legacyTrips,
                status: status,
              ),
      ),
    );
  }

  Widget _buildDestinationBrowseScaffold(BuildContext context) {
    final browseStatus = (
      context.tr.myTripsStatusActive,
      AppColors.success,
      context.tr.myTripsViewDetails,
      context.tr.myTripsBookingDetails,
    );
    final padH = 20.w;
    final overlap = 28.h;
    final sheetRadius = 32.r;
    final sheetTopOnly = BorderRadius.vertical(
      top: Radius.circular(sheetRadius),
    );

    return Scaffold(
      backgroundColor: AppColors.cardBg,
      body: BlocBuilder<MyTripsListCubit, MyTripsListState>(
        builder: (context, listState) {
          final media = MediaQuery.of(context);
          final heroH = (media.size.height * 0.56).clamp(200.0, 360.0);
          final rating = _heroRatingFromTrips(listState.trips);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: heroH,
                child: _BrowseCatalogHero(
                  imageUrl: widget.catalogDestinationImageUrl,
                  country: widget.catalogDestinationCountry ?? '',
                  destinationName: widget.destinationBrowseTitle?.trim() ?? '',
                  rating: rating,
                  onBack: () => sl<AppNavigator>().pop(),
                  tripsOfLabel: context.tr.myTripsCatalogTripsOf,
                ),
              ),
              Expanded(
                child: Transform.translate(
                  offset: Offset(0, -overlap),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: sheetTopOnly,
                      border: Border.all(
                        color: AppColors.onImage.withValues(alpha: 0.42),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: sheetTopOnly,
                      child: ColoredBox(
                        color: AppColors.cardBg,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                padH,
                                24.h,
                                padH,
                                0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _MyTripsSearchField(
                                    controller: _searchCtrl,
                                    hint: context.tr.myTripsSearchHint,
                                    onChanged: _onSearchTextChanged,
                                    onSubmitted: _flushSearchImmediate,
                                    onClear: _clearSearchField,
                                    catalogBrowseStyle: true,
                                  ),
                                  SizedBox(height: 16.h),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: const _CatalogSortChip(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Expanded(
                              child: _buildActiveTabBody(
                                context,
                                browseStatus,
                                catalogListLayout: true,
                                catalogViewportBottomCompensation: overlap,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMainTripsScaffold(
    BuildContext context, {
    required double bottomInset,
    required double sheetTop,
    required double sheetOverlap,
    required double sheetRadius,
    required List<TripItem> legacyTrips,
    required (String, Color, String, String) status,
  }) {
    final horizontalPadding = 16.w;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
            ),
          ),
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: horizontalPadding,
                  end: horizontalPadding,
                  top: 10.h,
                ),
                child: Text(
                  context.tr.myTripsTitle,
                  style: AppTextStyles.heading3(color: AppColors.onImage),
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: sheetTop,
            child: Container(
              padding: EdgeInsetsDirectional.only(
                start: horizontalPadding,
                end: horizontalPadding,
                top: 18.h + sheetOverlap,
                bottom: 24.h + bottomInset,
              ),
              decoration: BoxDecoration(
                color: AppColors.scaffoldBg,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(sheetRadius),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withValues(alpha: 0.04),
                    blurRadius: 18.r,
                    offset: Offset(0, 10.h),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _MyTripsSearchField(
                    controller: _searchCtrl,
                    hint: context.tr.myTripsSearchHint,
                    onChanged: _onSearchTextChanged,
                    onSubmitted: _flushSearchImmediate,
                    onClear: _clearSearchField,
                    catalogBrowseStyle: false,
                  ),
                  SizedBox(height: 12.h),
                  _TripsTabs(
                    selectedIndex: _selectedTab,
                    onChanged: _onTripTabChanged,
                    activeText: context.tr.myTripsTabActive,
                    pastText: context.tr.myTripsTabPastNew,
                    canceledText: context.tr.myTripsTabCanceled,
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: _selectedTab == 0
                        ? _buildActiveTabBody(
                            context,
                            status,
                            catalogListLayout: false,
                          )
                        : _buildLegacyTabBody(context, legacyTrips, status),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTabBody(
    BuildContext context,
    (String, Color, String, String) status, {
    bool catalogListLayout = false,

    double catalogViewportBottomCompensation = 0,
  }) {
    return BlocBuilder<MyTripsListCubit, MyTripsListState>(
      builder: (context, state) {
        if (state.status == MyTripsListStatus.loading && state.trips.isEmpty) {
          return Center(
            child: CustomLoading(top: 24.h, size: 36, strokeWidth: 2.5),
          );
        }

        if (state.status == MyTripsListStatus.failure && state.trips.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.warning_2, size: 40, color: AppColors.greyText),
                  SizedBox(height: 12.h),
                  Text(
                    state.errorMessage ?? 'Unknown error',
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.secondaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  FilledButton(
                    onPressed: () =>
                        context.read<MyTripsListCubit>().loadInitial(),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onImage,
                    ),
                    child: Text(context.tr.tripDetailsTryAgain),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.trips.isEmpty) {
          return _buildEmptyState(context);
        }

        final itemCount =
            state.trips.length +
            (state.hasMore && state.status == MyTripsListStatus.loadingMore
                ? 1
                : 0);

        final gap = catalogListLayout ? 18.h : 12.h;
        final listBottomPad =
            catalogListLayout && catalogViewportBottomCompensation > 0
            ? catalogViewportBottomCompensation
            : 0.0;

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<MyTripsListCubit>().refresh(),
          child: ListView.separated(
            controller: _scroll,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: listBottomPad > 0
                ? EdgeInsets.only(bottom: listBottomPad)
                : EdgeInsets.zero,
            itemCount: itemCount,
            separatorBuilder: (_, __) => SizedBox(height: gap),
            itemBuilder: (context, index) {
              if (index >= state.trips.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: CustomLoading(size: 24, strokeWidth: 2),
                );
              }
              final trip = state.trips[index];
              final rawLocation = trip.fromLocation.trim();
              final locationText =
                  rawLocation.startsWith(context.tr.myTripsFromPrefix)
                  ? rawLocation
                  : '${context.tr.myTripsFromPrefix} $rawLocation';
              if (catalogListLayout) {
                return MyTripCatalogCard(
                  trip: trip,
                  locationLabel: locationText,
                  onFavoriteTap: () => context
                      .read<MyTripsListCubit>()
                      .toggleTripWishlist(trip.id),
                  onReturnedFromTripDetails: (result) {
                    if (result == null || !context.mounted) {
                      return;
                    }
                    context
                        .read<MyTripsListCubit>()
                        .applyWishlistStateFromDetails(
                          result.tripId,
                          result.isWishlisted,
                        );
                  },
                );
              }
              return MyTripBookingCard.api(
                trip: trip,
                statusText: status.$1,
                statusColor: status.$2,
                locationText: locationText,
                primaryActionText: status.$3,
                secondaryActionText: context.tr.myTripsViewReceipt,
                bottomActionText: status.$4,
                onFavoriteTap: () => context
                    .read<MyTripsListCubit>()
                    .toggleTripWishlist(trip.id),
                onReturnedFromTripDetails: (result) {
                  if (result == null || !context.mounted) {
                    return;
                  }
                  context
                      .read<MyTripsListCubit>()
                      .applyWishlistStateFromDetails(
                        result.tripId,
                        result.isWishlisted,
                      );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLegacyTabBody(
    BuildContext context,
    List<TripItem> trips,
    (String, Color, String, String) status,
  ) {
    if (trips.isEmpty) {
      return _buildEmptyState(context);
    }
    return ListView.separated(
      itemCount: trips.length.clamp(0, 50),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final trip = trips[index];
        final rawLocation = trip.location.trim();
        final locationText =
            rawLocation.startsWith(context.tr.myTripsFromPrefix)
            ? rawLocation
            : '${context.tr.myTripsFromPrefix} $rawLocation';
        return MyTripBookingCard.legacy(
          trip: trip,
          statusText: status.$1,
          statusColor: status.$2,
          locationText: locationText,
          primaryActionText: status.$3,
          secondaryActionText: context.tr.myTripsViewReceipt,
          bottomActionText: status.$4,
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.map, size: 36, color: AppColors.greyText),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.myTripsEmptyTitle,
            style: AppTextStyles.heading3(color: AppColors.secondaryText),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.myTripsEmptyDescription,
            style: AppTextStyles.bodyMedium(color: AppColors.greyText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              sl<AppNavigator>().pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 32.w,
                vertical: 14.h,
              ),
            ),
            child: Text(
              context.tr.myTripsExploreTrips,
              style: AppTextStyles.button(color: AppColors.onImage),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrowseCatalogHero extends StatelessWidget {
  const _BrowseCatalogHero({
    required this.imageUrl,
    required this.country,
    required this.destinationName,
    required this.rating,
    required this.onBack,
    required this.tripsOfLabel,
  });

  final String? imageUrl;
  final String country;
  final String destinationName;
  final double rating;
  final VoidCallback onBack;
  final String tripsOfLabel;

  @override
  Widget build(BuildContext context) {
    final nameBig = destinationName.isEmpty
        ? '—'
        : destinationName.toUpperCase();

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: AppCachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.shadow.withValues(alpha: 0.1),
                  AppColors.shadow.withValues(alpha: 0.48),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 20.w, top: 8.h),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Material(
                color: AppColors.transparent,
                child: InkWell(
                  onTap: onBack,
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: AppColors.onImage.withValues(alpha: 0.32),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.onImage.withValues(alpha: 0.55),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.onImage,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tripsOfLabel,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium(color: AppColors.onImage)
                      .copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        shadows: [
                          Shadow(
                            color: AppColors.shadow.withValues(alpha: 0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                ),
                SizedBox(height: 6.h),
                Text(
                  nameBig,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading1(color: AppColors.onImage)
                      .copyWith(
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                        height: 1.05,
                        shadows: [
                          Shadow(
                            color: AppColors.shadow.withValues(alpha: 0.55),
                            blurRadius: 14,
                          ),
                        ],
                      ),
                ),
                SizedBox(height: 14.h),
                if (country.trim().isNotEmpty)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.onImage,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 8.h,
                      ),
                      child: Text(
                        country.trim(),
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.darkText,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                if (country.trim().isNotEmpty) SizedBox(height: 12.h),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.shadow.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          rating.toStringAsFixed(1),
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.onImage,
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Iconsax.star1,
                          size: 16.sp,
                          color: AppColors.starYellow,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CatalogSortChip extends StatelessWidget {
  const _CatalogSortChip();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(Iconsax.arrow_down_1, size: 16.sp, color: AppColors.darkText),
      label: Text(
        context.tr.wishlistSortBy,
        style: AppTextStyles.bodyMedium(
          color: AppColors.darkText,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkText,
        backgroundColor: AppColors.cardBg,
        side: BorderSide(color: AppColors.catalogSheetBorder, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 14.w,
          vertical: 8.h,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

class _MyTripsSearchField extends StatefulWidget {
  const _MyTripsSearchField({
    required this.controller,
    required this.hint,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
    this.catalogBrowseStyle = false,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;
  final VoidCallback onClear;
  final bool catalogBrowseStyle;

  @override
  State<_MyTripsSearchField> createState() => _MyTripsSearchFieldState();
}

class _MyTripsSearchFieldState extends State<_MyTripsSearchField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(_onFocusOrTextChanged);
    widget.controller.addListener(_onFocusOrTextChanged);
  }

  void _onFocusOrTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onFocusOrTextChanged);
    _focusNode
      ..removeListener(_onFocusOrTextChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focused = _focusNode.hasFocus;
    final showClear = widget.controller.text.isNotEmpty;
    final browse = widget.catalogBrowseStyle;
    final fieldHeight = browse ? 52.h : 44.h;
    final radius = browse ? 999.r : 14.r;
    final startPad = browse ? 20.w : 16.w;
    final endPad = browse ? (showClear ? 8.w : 20.w) : (showClear ? 6.w : 16.w);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOutCubic,
      height: fieldHeight,
      padding: EdgeInsetsDirectional.only(start: startPad, end: endPad),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: focused
              ? AppColors.primary
              : (browse
                    ? AppColors.catalogSheetBorder
                    : AppColors.border.withValues(alpha: 0.65)),
          width: focused ? 1.5 : 1,
        ),
        boxShadow: browse
            ? const <BoxShadow>[]
            : [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.04),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.search_normal,
            size: browse ? 19.sp : 20.sp,
            color: browse ? AppColors.catalogMetaMuted : AppColors.greyText,
          ),
          SizedBox(width: browse ? 12.w : 10.w),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              onChanged: widget.onChanged,
              onSubmitted: (_) => widget.onSubmitted(),
              textInputAction: TextInputAction.search,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: widget.hint,
                hintStyle: browse
                    ? AppTextStyles.body(
                        color: AppColors.catalogMetaMuted,
                      ).copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      )
                    : AppTextStyles.bodyMedium(color: AppColors.greyText),
                contentPadding: EdgeInsets.zero,
              ),
              style: browse
                  ? AppTextStyles.bodyMedium(
                      color: AppColors.darkText,
                    ).copyWith(fontSize: 15.sp, height: 1.2)
                  : AppTextStyles.bodyMedium(color: AppColors.darkText),
            ),
          ),
          if (showClear)
            IconButton(
              onPressed: widget.onClear,
              icon: Icon(
                Iconsax.close_circle,
                size: 20.sp,
                color: AppColors.greyText,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.w),
              tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
            ),
        ],
      ),
    );
  }
}

class _TripsTabs extends StatelessWidget {
  const _TripsTabs({
    required this.selectedIndex,
    required this.onChanged,
    required this.activeText,
    required this.pastText,
    required this.canceledText,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final String activeText;
  final String pastText;
  final String canceledText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TabPill(
            text: activeText,
            isSelected: selectedIndex == 0,
            onTap: () => onChanged(0),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _TabPill(
            text: pastText,
            isSelected: selectedIndex == 1,
            onTap: () => onChanged(1),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _TabPill(
            text: canceledText,
            isSelected: selectedIndex == 2,
            onTap: () => onChanged(2),
          ),
        ),
      ],
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        height: 38.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardBg,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected
              ? null
              : Border.all(color: AppColors.border.withValues(alpha: 0.75)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.bodyMedium(
            color: isSelected ? AppColors.onImage : AppColors.greyText,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
