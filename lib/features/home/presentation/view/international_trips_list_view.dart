import 'dart:async';

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
import 'package:trip_marche/core/widgets/app_trip_search_text_field.dart';
import 'package:trip_marche/core/widgets/curved_gradient_sheet_layout.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_wishlist_pop_result.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';

import '../../data/models/home_section_response.dart';
import '../cubit/home_sections_cubit.dart';
import '../cubit/international_trips_items_cubit.dart';
import '../cubit/international_trips_items_state.dart';
import '../cubit/special_trips_cubit.dart';
import '../widgets/popular_trip_grid_card.dart';

/// International trips from [AppEndpoints.homeInternationalTripsItems] — opened via Home "See all".
class InternationalTripsListView extends StatelessWidget {
  const InternationalTripsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<InternationalTripsItemsCubit>()..loadInitial(),
      child: const _InternationalTripsListScaffold(),
    );
  }
}

class _InternationalTripsListScaffold extends StatefulWidget {
  const _InternationalTripsListScaffold();

  @override
  State<_InternationalTripsListScaffold> createState() =>
      _InternationalTripsListScaffoldState();
}

class _InternationalTripsListScaffoldState
    extends State<_InternationalTripsListScaffold> {
  static const Duration _searchDebounce = Duration(milliseconds: 500);

  late final TextEditingController _searchCtrl;
  late final ScrollController _scroll;
  Timer? _searchDebounceTimer;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController();
    _scroll = ScrollController()..addListener(_onScroll);
  }

  void _scheduleDebouncedSearch() {
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(_searchDebounce, _applySearchFromField);
  }

  void _applySearchFromField() {
    _searchDebounceTimer?.cancel();
    if (!mounted) {
      return;
    }
    if (_scroll.hasClients) {
      _scroll.jumpTo(0);
    }
    context.read<InternationalTripsItemsCubit>().flushSearchNow(
      _searchCtrl.text,
    );
  }

  void _onSearchFieldChanged(String _) {
    _scheduleDebouncedSearch();
  }

  void _onSearchSubmitted() {
    FocusScope.of(context).unfocus();
    _searchDebounceTimer?.cancel();
    _applySearchFromField();
  }

  void _onSearchClear() {
    _searchDebounceTimer?.cancel();
    _searchCtrl.clear();
    if (!mounted) {
      return;
    }
    if (_scroll.hasClients) {
      _scroll.jumpTo(0);
    }
    context.read<InternationalTripsItemsCubit>().flushSearchNow('');
  }

  void _onScroll() {
    if (!_scroll.hasClients) {
      return;
    }
    final pos = _scroll.position;
    if (pos.pixels >= pos.maxScrollExtent - 280) {
      context.read<InternationalTripsItemsCubit>().loadMore();
    }
  }

  String _titleFromState(InternationalTripsItemsState state) {
    final fromApi = state.meta?.sectionTitle?.trim() ?? '';
    if (fromApi.isNotEmpty) {
      return fromApi;
    }
    return context.tr.homeInternationalTripsFromEgypt;
  }

  void _syncWishlistToParentShell(
    BuildContext context,
    int tripId,
    bool isWishlisted,
  ) {
    HomeSectionsCubit? home;
    SpecialTripsCubit? special;
    try {
      home = BlocProvider.of<HomeSectionsCubit>(context, listen: false);
    } catch (_) {}
    try {
      special = BlocProvider.of<SpecialTripsCubit>(context, listen: false);
    } catch (_) {}
    home?.syncWishlistFromOtherList(tripId, isWishlisted);
    special?.syncWishlistFromOtherList(tripId, isWishlisted);
  }

  TripModel? _tripById(InternationalTripsItemsState state, int tripId) {
    for (final t in state.trips) {
      if (t.id == tripId) {
        return t;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _searchDebounceTimer?.cancel();
    _searchCtrl.dispose();
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<
          InternationalTripsItemsCubit,
          InternationalTripsItemsState
        >(
          listenWhen: (p, n) =>
              n.wishlistErrorMessage != null &&
              n.wishlistErrorMessage != p.wishlistErrorMessage,
          listener: (context, state) {
            final msg = state.wishlistErrorMessage;
            if (msg == null) {
              return;
            }
            appToast(context: context, type: ToastType.error, message: msg);
            context.read<InternationalTripsItemsCubit>().clearWishlistError();
          },
        ),
      ],
      child:
          BlocBuilder<
            InternationalTripsItemsCubit,
            InternationalTripsItemsState
          >(
            builder: (context, state) {
              final title = _titleFromState(state);
              return Scaffold(
                backgroundColor: AppColors.primary,
                body: CurvedGradientSheetLayout(
                  headerTitle: title,
                  sheetChild: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      16.w,
                      20.h,
                      16.w,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTripSearchTextField(
                          controller: _searchCtrl,
                          onChanged: _onSearchFieldChanged,
                          onSubmitted: (_) => _onSearchSubmitted(),
                          onClear: _onSearchClear,
                        ),
                        // SizedBox(height: 16.h),
                        // const CurvedSheetSortFilterRow(),
                        SizedBox(height: 14.h),
                        Expanded(
                          child: RefreshIndicator(
                            color: AppColors.primary,
                            onRefresh: () => context
                                .read<InternationalTripsItemsCubit>()
                                .refresh(),
                            child: _buildBody(context, state),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget _buildBody(BuildContext context, InternationalTripsItemsState state) {
    if (state.status == InternationalTripsItemsStatus.initial ||
        (state.status == InternationalTripsItemsStatus.loading &&
            state.trips.isEmpty)) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Center(child: CustomLoading(strokeWidth: 2.5)),
        ],
      );
    }

    if (state.status == InternationalTripsItemsStatus.failure &&
        state.trips.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        children: [
          Icon(Iconsax.warning_2, size: 40, color: AppColors.greyText(context)),
          SizedBox(height: 12.h),
          Text(
            state.errorMessage ?? context.tr.nothingFound,
            style: AppTextStyles.bodyMedium(
              color: AppColors.secondaryText(context),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          FilledButton(
            onPressed: () =>
                context.read<InternationalTripsItemsCubit>().loadInitial(),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onImage,
            ),
            child: Text(context.tr.tripDetailsTryAgain),
          ),
        ],
      );
    }

    final itemCount =
        state.trips.length +
        (state.status == InternationalTripsItemsStatus.loadingMore ? 1 : 0);

    return CustomScrollView(
      controller: _scroll,
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      slivers: [
        if (state.trips.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                context.tr.nothingFound,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.greyText(context),
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 8.h),
            sliver: SliverList.separated(
              itemCount: itemCount,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                if (index >= state.trips.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Center(
                      child: CustomLoading(size: 28, strokeWidth: 2),
                    ),
                  );
                }
                final trip = state.trips[index];
                return PopularTripGridCard(
                  trip: trip,
                  onTap: () async {
                    final result = await sl<AppNavigator>()
                        .push<TripWishlistPopResult>(
                          screen: TripDetailsView(
                            tripId: trip.id,
                            initialIsWishlisted: trip.isWishlisted,
                          ),
                        );
                    if (!context.mounted || result == null) {
                      return;
                    }
                    context
                        .read<InternationalTripsItemsCubit>()
                        .syncWishlistFromOtherList(
                          result.tripId,
                          result.isWishlisted,
                        );
                    _syncWishlistToParentShell(
                      context,
                      result.tripId,
                      result.isWishlisted,
                    );
                  },
                  onFavoriteTap: () async {
                    await context
                        .read<InternationalTripsItemsCubit>()
                        .toggleTripWishlist(trip.id);
                    if (!context.mounted) {
                      return;
                    }
                    final updated = _tripById(
                      context.read<InternationalTripsItemsCubit>().state,
                      trip.id,
                    );
                    if (updated != null) {
                      _syncWishlistToParentShell(
                        context,
                        trip.id,
                        updated.isWishlisted,
                      );
                    }
                  },
                );
              },
            ),
          ),
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
      ],
    );
  }
}
