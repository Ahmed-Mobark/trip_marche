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
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_wishlist_pop_result.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';

import '../../data/models/home_section_response.dart';
import '../cubit/home_sections_cubit.dart';
import '../cubit/recommended_for_you_items_cubit.dart';
import '../cubit/recommended_for_you_items_state.dart';
import '../cubit/special_trips_cubit.dart';
import '../widgets/popular_trip_grid_card.dart';

/// Recommended trips from [AppEndpoints.homeRecommendedForYouItems] — opened via Home "See all".
class RecommendedForYouListView extends StatelessWidget {
  const RecommendedForYouListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecommendedForYouItemsCubit>()..loadInitial(),
      child: const _RecommendedForYouListScaffold(),
    );
  }
}

class _RecommendedForYouListScaffold extends StatefulWidget {
  const _RecommendedForYouListScaffold();

  @override
  State<_RecommendedForYouListScaffold> createState() =>
      _RecommendedForYouListScaffoldState();
}

class _RecommendedForYouListScaffoldState
    extends State<_RecommendedForYouListScaffold> {
  static const Duration _searchDebounce = Duration(milliseconds: 500);

  late final TextEditingController _searchCtrl;
  late final ScrollController _scroll;
  Timer? _searchDebounceTimer;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController()..addListener(_onSearchCtrlUpdate);
    _scroll = ScrollController()..addListener(_onScroll);
  }

  void _onSearchCtrlUpdate() {
    if (mounted) {
      setState(() {});
    }
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
    context.read<RecommendedForYouItemsCubit>().flushSearchNow(
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
    context.read<RecommendedForYouItemsCubit>().flushSearchNow('');
  }

  void _onScroll() {
    if (!_scroll.hasClients) {
      return;
    }
    final pos = _scroll.position;
    if (pos.pixels >= pos.maxScrollExtent - 280) {
      context.read<RecommendedForYouItemsCubit>().loadMore();
    }
  }

  String _titleFromState(RecommendedForYouItemsState state) {
    final fromApi = state.meta?.sectionTitle?.trim() ?? '';
    if (fromApi.isNotEmpty) {
      return fromApi;
    }
    return context.tr.homeRecommendedForYou;
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

  TripModel? _tripById(RecommendedForYouItemsState state, int tripId) {
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
    _searchCtrl
      ..removeListener(_onSearchCtrlUpdate)
      ..dispose();
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  Widget _buildWishlistStyleSearch(BuildContext context) {
    final showClear = _searchCtrl.text.isNotEmpty;
    return TextField(
      controller: _searchCtrl,
      onChanged: _onSearchFieldChanged,
      onSubmitted: (_) => _onSearchSubmitted(),
      textInputAction: TextInputAction.search,
      style: AppTextStyles.bodyMedium(color: AppColors.darkText(context)),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: context.tr.wishlistSearchHint,
        hintStyle: AppTextStyles.bodyMedium(color: AppColors.greyText(context)),
        prefixIcon: Icon(
          Iconsax.search_normal_1,
          size: 20.sp,
          color: AppColors.greyText(context),
        ),
        suffixIcon: showClear
            ? IconButton(
                onPressed: _onSearchClear,
                icon: Icon(
                  Iconsax.close_circle,
                  size: 20.sp,
                  color: AppColors.greyText(context),
                ),
                tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
              )
            : null,
        filled: true,
        fillColor: AppColors.background(context),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColors.border(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColors.border(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RecommendedForYouItemsCubit, RecommendedForYouItemsState>(
          listenWhen: (p, n) =>
              n.wishlistErrorMessage != null &&
              n.wishlistErrorMessage != p.wishlistErrorMessage,
          listener: (context, state) {
            final msg = state.wishlistErrorMessage;
            if (msg == null) {
              return;
            }
            appToast(context: context, type: ToastType.error, message: msg);
            context.read<RecommendedForYouItemsCubit>().clearWishlistError();
          },
        ),
      ],
      child:
          BlocBuilder<RecommendedForYouItemsCubit, RecommendedForYouItemsState>(
            builder: (context, state) {
              final title = _titleFromState(state);
              return Scaffold(
                backgroundColor: AppColors.scaffoldBg(context),
                appBar: AppBar(
                  backgroundColor: AppColors.scaffoldBg(context),
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.darkText(context),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    title,
                    style: AppTextStyles.subtitle(
                      color: AppColors.darkText(context),
                    ),
                  ),
                  centerTitle: true,
                ),
                body: RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () =>
                      context.read<RecommendedForYouItemsCubit>().refresh(),
                  child: _buildBody(context, state),
                ),
              );
            },
          ),
    );
  }

  Widget _buildBody(BuildContext context, RecommendedForYouItemsState state) {
    if (state.status == RecommendedForYouItemsStatus.initial ||
        (state.status == RecommendedForYouItemsStatus.loading &&
            state.trips.isEmpty)) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Center(child: CustomLoading(strokeWidth: 2.5)),
        ],
      );
    }

    if (state.status == RecommendedForYouItemsStatus.failure &&
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
                context.read<RecommendedForYouItemsCubit>().loadInitial(),
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
        (state.status == RecommendedForYouItemsStatus.loadingMore ? 1 : 0);

    return CustomScrollView(
      controller: _scroll,
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      slivers: [
        SliverPadding(
          padding: EdgeInsetsDirectional.fromSTEB(16.w, 8.h, 16.w, 12.h),
          sliver: SliverToBoxAdapter(child: _buildWishlistStyleSearch(context)),
        ),
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
                        .read<RecommendedForYouItemsCubit>()
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
                        .read<RecommendedForYouItemsCubit>()
                        .toggleTripWishlist(trip.id);
                    if (!context.mounted) {
                      return;
                    }
                    final updated = _tripById(
                      context.read<RecommendedForYouItemsCubit>().state,
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
