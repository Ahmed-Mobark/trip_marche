import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/curved_gradient_sheet_layout.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
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
                  const SearchResultActionRow(),
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
