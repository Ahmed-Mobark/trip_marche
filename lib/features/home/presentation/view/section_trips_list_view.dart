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
import '../cubit/section_trips_items_cubit.dart';
import '../cubit/section_trips_items_state.dart';
import '../cubit/special_trips_cubit.dart';
import '../../../../core/widgets/staggered_fade_slide.dart';
import '../widgets/popular_trip_grid_card.dart';

/// Generic "See all" view for any home section that lists trips.
///
/// Usage:
/// ```dart
/// SectionTripsListView(
///   fallbackTitle: context.tr.homePopularTrips,
///   cubitFactory: () => sl<SectionTripsItemsCubit>(instanceName: 'popular'),
/// )
/// ```
class SectionTripsListView extends StatelessWidget {
  const SectionTripsListView({
    super.key,
    required this.fallbackTitle,
    required this.cubitFactory,
  });

  final String fallbackTitle;
  final SectionTripsItemsCubit Function() cubitFactory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubitFactory()..loadInitial(),
      child: _SectionTripsListScaffold(fallbackTitle: fallbackTitle),
    );
  }
}

class _SectionTripsListScaffold extends StatefulWidget {
  const _SectionTripsListScaffold({required this.fallbackTitle});

  final String fallbackTitle;

  @override
  State<_SectionTripsListScaffold> createState() =>
      _SectionTripsListScaffoldState();
}

class _SectionTripsListScaffoldState extends State<_SectionTripsListScaffold> {
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
    if (!mounted) return;
    if (_scroll.hasClients) _scroll.jumpTo(0);
    context.read<SectionTripsItemsCubit>().flushSearchNow(_searchCtrl.text);
  }

  void _onSearchFieldChanged(String _) => _scheduleDebouncedSearch();

  void _onSearchSubmitted() {
    FocusScope.of(context).unfocus();
    _searchDebounceTimer?.cancel();
    _applySearchFromField();
  }

  void _onSearchClear() {
    _searchDebounceTimer?.cancel();
    _searchCtrl.clear();
    if (!mounted) return;
    if (_scroll.hasClients) _scroll.jumpTo(0);
    context.read<SectionTripsItemsCubit>().flushSearchNow('');
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    if (pos.pixels >= pos.maxScrollExtent - 280) {
      context.read<SectionTripsItemsCubit>().loadMore();
    }
  }

  String _titleFromState(SectionTripsItemsState state) {
    final fromApi = state.meta?.sectionTitle?.trim() ?? '';
    if (fromApi.isNotEmpty) return fromApi;
    return widget.fallbackTitle;
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

  TripModel? _tripById(SectionTripsItemsState state, int tripId) {
    for (final t in state.trips) {
      if (t.id == tripId) return t;
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
        BlocListener<SectionTripsItemsCubit, SectionTripsItemsState>(
          listenWhen: (p, n) =>
              n.wishlistErrorMessage != null &&
              n.wishlistErrorMessage != p.wishlistErrorMessage,
          listener: (context, state) {
            final msg = state.wishlistErrorMessage;
            if (msg == null) return;
            appToast(context: context, type: ToastType.error, message: msg);
            context.read<SectionTripsItemsCubit>().clearWishlistError();
          },
        ),
      ],
      child: BlocBuilder<SectionTripsItemsCubit, SectionTripsItemsState>(
        builder: (context, state) {
          final title = _titleFromState(state);
          return Scaffold(
            backgroundColor: AppColors.primary,
            body: CurvedGradientSheetLayout(
              headerTitle: title,
              alignHeaderTitleStart: true,
              sheetChild: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.w, 20.h, 16.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTripSearchTextField(
                      controller: _searchCtrl,
                      onChanged: _onSearchFieldChanged,
                      onSubmitted: (_) => _onSearchSubmitted(),
                      onClear: _onSearchClear,
                    ),
                    SizedBox(height: 14.h),
                    Expanded(child: _buildBody(context, state)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SectionTripsItemsState state) {
    if (state.status == SectionTripsItemsStatus.initial ||
        (state.status == SectionTripsItemsStatus.loading &&
            state.trips.isEmpty)) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Center(child: CustomLoading(strokeWidth: 2.5)),
        ],
      );
    }

    if (state.status == SectionTripsItemsStatus.failure &&
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
                context.read<SectionTripsItemsCubit>().loadInitial(),
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
        (state.status == SectionTripsItemsStatus.loadingMore ? 1 : 0);

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
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8.h),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 0.55,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index >= state.trips.length) {
                  return Center(child: CustomLoading(size: 28, strokeWidth: 2));
                }
                final trip = state.trips[index];
                return StaggeredFadeSlide(
                  index: index,
                  child: PopularTripGridCard(
                    trip: trip,
                    onTap: () async {
                      final result = await sl<AppNavigator>()
                          .push<TripWishlistPopResult>(
                            screen: TripDetailsView(
                              tripId: trip.id,
                              initialIsWishlisted: trip.isWishlisted,
                            ),
                          );
                      if (!context.mounted || result == null) return;
                      context
                          .read<SectionTripsItemsCubit>()
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
                          .read<SectionTripsItemsCubit>()
                          .toggleTripWishlist(trip.id);
                      if (!context.mounted) return;
                      final updated = _tripById(
                        context.read<SectionTripsItemsCubit>().state,
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
                  ),
                );
              }, childCount: itemCount),
            ),
          ),
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
      ],
    );
  }
}
