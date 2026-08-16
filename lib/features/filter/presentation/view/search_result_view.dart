import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/app_modal_bottom_sheet.dart';
import 'package:trip_marche/core/widgets/curved_gradient_sheet_layout.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/features/filter/presentation/view/filter_view.dart';
import 'package:trip_marche/features/filter/presentation/widgets/search_result_sections.dart';
import 'package:trip_marche/features/my_trips/domain/entities/trips_catalog_filters.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_list_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_list_state.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trip_catalog_card.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

class SearchResultView extends StatefulWidget {
  const SearchResultView({required this.filters, super.key});

  final TripsCatalogFilters filters;

  @override
  State<SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  static const int _histogramBuckets = 22;

  late final MyTripsListCubit _listCubit;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _listCubit = sl<MyTripsListCubit>();
    _scrollController = ScrollController()..addListener(_onScroll);
    _listCubit.applyFilters(widget.filters);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _listCubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 220) {
      _listCubit.loadMoreFilteredTrips();
    }
  }

  /// Builds a [_histogramBuckets]-sized array of trip counts per equal price
  /// bucket so the filter chart can reflect the currently loaded results
  /// (#53). Returns an empty list when there's nothing to count.
  List<int> _buildPriceHistogram(List<WishlistTripItem> trips) {
    if (trips.isEmpty) {
      return const [];
    }
    final prices = trips
        .map((t) => (t.discountPrice ?? t.price).abs())
        .where((p) => p.isFinite && p > 0)
        .toList();
    if (prices.isEmpty) {
      return const [];
    }
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    if (maxPrice <= 0) {
      return const [];
    }
    final buckets = List<int>.filled(_histogramBuckets, 0);
    final step = maxPrice / _histogramBuckets;
    for (final p in prices) {
      var idx = (p / step).floor();
      if (idx >= _histogramBuckets) {
        idx = _histogramBuckets - 1;
      }
      if (idx < 0) {
        idx = 0;
      }
      buckets[idx]++;
    }
    return buckets;
  }

  Future<void> _openFilters() async {
    final currentFilters = _listCubit.activeFilters;
    final histogram = _buildPriceHistogram(_listCubit.state.trips);
    final result = await sl<AppNavigator>().push<TripsCatalogFilters>(
      screen: FilterView(
        returnFilters: true,
        priceHistogramHint: histogram,
      ),
    );
    if (!mounted || result == null) {
      return;
    }
    // Preserve the active search query when applying filter changes so users
    // don't lose their typed destination after tweaking filters (#52).
    await _listCubit.applyFilters(result.withSearch(currentFilters.search));
  }

  Future<void> _openSortSheet() async {
    final currentSort = _listCubit.activeFilters.sort;
    final options = [
      _SortOption(
        'price_asc',
        context.tr.searchResultSortPriceAsc,
        context.tr.searchResultSortPriceAscDesc,
        Iconsax.money,
      ),
      _SortOption(
        'price_desc',
        context.tr.searchResultSortPriceDesc,
        context.tr.searchResultSortPriceDescDesc,
        Iconsax.wallet_3,
      ),
      _SortOption(
        'rating',
        context.tr.searchResultSortRating,
        context.tr.searchResultSortRatingDesc,
        Iconsax.star1,
      ),
      _SortOption(
        'duration_asc',
        context.tr.searchResultSortDurationAsc,
        context.tr.searchResultSortDurationAscDesc,
        Iconsax.clock,
      ),
      _SortOption(
        'duration_desc',
        context.tr.searchResultSortDurationDesc,
        context.tr.searchResultSortDurationDescDesc,
        Iconsax.arrow_up_1,
      ),
      _SortOption(
        'recent',
        context.tr.searchResultSortRecent,
        context.tr.searchResultSortRecentDesc,
        Iconsax.calendar_1,
      ),
    ];
    final result = await showAppModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      applySystemBottomInset: false,
      builder: (ctx) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.border(context),
                  borderRadius: BorderRadius.circular(999.r),
                ),
              ),
              BottomSystemInsetSurface(
                color: AppColors.cardBg(context),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                ),
                additionalBottomPadding: 12.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        24.w,
                        20.h,
                        24.w,
                        16.h,
                      ),
                      child: Row(
                          children: [
                            Icon(
                              Iconsax.sort,
                              color: AppColors.primary,
                              size: 24.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr.searchResultSortBy,
                                    style: AppTextStyles.heading3(
                                      color: AppColors.darkText(context),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    context.tr.searchResultSortSubtitle,
                                    style: AppTextStyles.bodySmall(
                                      color: AppColors.secondaryText(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Iconsax.close_circle,
                                color: AppColors.greyText(context),
                                size: 24.sp,
                              ),
                              onPressed: () => Navigator.pop(ctx),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(
                                minWidth: 40.w,
                                minHeight: 40.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 0.5,
                        color: AppColors.border(context),
                        indent: 24.w,
                        endIndent: 24.w,
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            ...options.asMap().entries.map((entry) {
                              final index = entry.key;
                              final option = entry.value;
                              final isSelected = option.value == currentSort;
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: index < options.length - 1
                                      ? 16.h
                                      : 0,
                                ),
                                child: _SortOptionCard(
                                  option: option,
                                  isSelected: isSelected,
                                  onTap: () =>
                                      Navigator.pop(ctx, option.value),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        );
      },
    );
    if (!mounted || result == null) {
      return;
    }
    final newFilters = _listCubit.activeFilters.copyWith(sort: result);
    await _listCubit.applyFilters(newFilters);
  }

  @override
  Widget build(BuildContext context) {
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
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: CurvedGradientSheetLayout(
            headerTitle: context.tr.searchResultTitle,
            alignHeaderTitleStart: true,
            sheetChild: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.w, 20.h, 16.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SearchResultSearchBar(
                    initialQuery: widget.filters.search ?? '',
                    scrollController: _scrollController,
                  ),
                  SizedBox(height: 16.h),
                  SearchResultActionRow(
                    onSortTap: _openSortSheet,
                    onFilterTap: _openFilters,
                  ),
                  SizedBox(height: 14.h),
                  Expanded(child: _buildBody()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<MyTripsListCubit, MyTripsListState>(
      builder: (context, state) {
        if (state.status == MyTripsListStatus.loading && state.trips.isEmpty) {
          return Center(
            child: CustomLoading(top: 8.h, size: 34, strokeWidth: 2.5),
          );
        }
        if (state.status == MyTripsListStatus.failure && state.trips.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.warning_2,
                    size: 42.sp,
                    color: AppColors.greyText(context),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    state.errorMessage ?? context.tr.tripDetailsFailedToLoad,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.secondaryText(context),
                    ),
                  ),
                  SizedBox(height: 14.h),
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
          return Center(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
              child: Text(
                context.tr.nothingFound,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.secondaryText(context),
                ),
              ),
            ),
          );
        }

        final itemCount =
            state.trips.length +
            (state.hasMore && state.status == MyTripsListStatus.loadingMore
                ? 1
                : 0);

        return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsetsDirectional.only(
            bottom: 20.h + MediaQuery.paddingOf(context).bottom,
          ),
          itemCount: itemCount,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            if (index >= state.trips.length) {
              return Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: 12.h),
                child: CustomLoading(size: 22, strokeWidth: 2),
              );
            }
            final trip = state.trips[index];
            final location = _locationText(context, trip);
            return MyTripCatalogCard(
              trip: trip,
              locationLabel: location,
              onFavoriteTap: () =>
                  context.read<MyTripsListCubit>().toggleTripWishlist(trip.id),
              onReturnedFromTripDetails: (result) {
                if (result == null || !context.mounted) {
                  return;
                }
                context.read<MyTripsListCubit>().applyWishlistStateFromDetails(
                  result.tripId,
                  result.isWishlisted,
                );
              },
            );
          },
        );
      },
    );
  }

  String _locationText(BuildContext context, WishlistTripItem trip) {
    final raw = trip.fromLocation.trim();
    if (raw.startsWith(context.tr.myTripsFromPrefix)) {
      return raw;
    }
    return '${context.tr.myTripsFromPrefix} $raw';
  }
}

class _SortOption {
  final String value;
  final String label;
  final String description;
  final IconData icon;

  const _SortOption(this.value, this.label, this.description, this.icon);
}

class _SortOptionCard extends StatelessWidget {
  const _SortOptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _SortOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.selectedPurpleTint(context)
            : AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border(context),
          width: isSelected ? 2.w : 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.06),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : AppColors.greyText(context)
                            .withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    option.icon,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.greyText(context),
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.label,
                        style: AppTextStyles.bodyMedium(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.darkText(context),
                        ).copyWith(
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        option.description,
                        style: AppTextStyles.bodySmall(
                          color: AppColors.secondaryText(context),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: AnimatedOpacity(
                    opacity: isSelected ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Iconsax.tick_circle,
                      color: AppColors.primary,
                      size: 22.sp,
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
