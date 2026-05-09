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
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/features/my_trips/presentation/view/trending_destenation_view.dart';

import '../cubit/trending_destinations_items_cubit.dart';
import '../cubit/trending_destinations_items_state.dart';
import '../widgets/trending_destination_card.dart';

/// Full list of trending destinations — opens with a fresh API load via [TrendingDestinationsItemsCubit.loadInitial].
class TrendingDestinationsListView extends StatelessWidget {
  const TrendingDestinationsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TrendingDestinationsItemsCubit>()..loadInitial(),
      child: const _TrendingDestinationsListScaffold(),
    );
  }
}

class _TrendingDestinationsListScaffold extends StatefulWidget {
  const _TrendingDestinationsListScaffold();

  @override
  State<_TrendingDestinationsListScaffold> createState() =>
      _TrendingDestinationsListScaffoldState();
}

class _TrendingDestinationsListScaffoldState
    extends State<_TrendingDestinationsListScaffold> {
  static const Duration _searchDebounce = Duration(milliseconds: 500);

  late final TextEditingController _searchCtrl;
  late final ScrollController _scroll;
  Timer? _searchDebounceTimer;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController()..addListener(_onSearchTextChanged);
    _scroll = ScrollController()..addListener(_onScroll);
  }

  void _onSearchTextChanged() {
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
    context.read<TrendingDestinationsItemsCubit>().flushSearchNow(
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
    context.read<TrendingDestinationsItemsCubit>().flushSearchNow('');
  }

  void _onScroll() {
    if (!_scroll.hasClients) {
      return;
    }
    final pos = _scroll.position;
    if (pos.pixels >= pos.maxScrollExtent - 280) {
      context.read<TrendingDestinationsItemsCubit>().loadMore();
    }
  }

  String _titleFromState(TrendingDestinationsItemsState state) {
    final fromApi = state.meta?.sectionTitle?.trim() ?? '';
    if (fromApi.isNotEmpty) {
      return fromApi;
    }
    return context.tr.homeTrendingDestinations;
  }

  (double cellWidth, double cellHeight) _gridCellSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossSpacing = 12.w;
    final horizontalPad = 16.w * 2;
    final cellW = (width - horizontalPad - crossSpacing) / 2;
    final cellH = cellW * 128 / 108;
    return (cellW, cellH);
  }

  @override
  void dispose() {
    _searchDebounceTimer?.cancel();
    _searchCtrl
      ..removeListener(_onSearchTextChanged)
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
    return BlocBuilder<TrendingDestinationsItemsCubit,
        TrendingDestinationsItemsState>(
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
              style: AppTextStyles.subtitle(color: AppColors.darkText(context)),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () =>
                context.read<TrendingDestinationsItemsCubit>().refresh(),
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    TrendingDestinationsItemsState state,
  ) {
    if (state.status == TrendingDestinationsItemsStatus.initial ||
        (state.status == TrendingDestinationsItemsStatus.loading &&
            state.destinations.isEmpty)) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Center(child: CustomLoading(strokeWidth: 2.5)),
        ],
      );
    }

    if (state.status == TrendingDestinationsItemsStatus.failure &&
        state.destinations.isEmpty) {
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
                context.read<TrendingDestinationsItemsCubit>().loadInitial(),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onImage,
            ),
            child: Text(context.tr.tripDetailsTryAgain),
          ),
        ],
      );
    }

    final (cellW, cellH) = _gridCellSize(context);

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
        if (state.destinations.isEmpty)
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
        else ...[
          SliverPadding(
            padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 8.h),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 108 / 128,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: state.destinations.length,
                (context, index) {
                  final dest = state.destinations[index];
                  return TrendingDestinationCard(
                    width: cellW,
                    height: cellH,
                    name: dest.name,
                    imageUrl: dest.image,
                    rank: dest.trendingRank,
                    onTap: dest.id <= 0
                        ? null
                        : () {
                            sl<AppNavigator>().push(
                              screen: TrendingDestinationView(
                                catalogDestinationId: dest.id,
                                destinationBrowseTitle: dest.name,
                                catalogDestinationImageUrl: dest.image,
                                catalogDestinationCountry: dest.country,
                              ),
                            );
                          },
                  );
                },
              ),
            ),
          ),
          if (state.status == TrendingDestinationsItemsStatus.loadingMore)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: CustomLoading(size: 28, strokeWidth: 2),
                ),
              ),
            ),
        ],
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
      ],
    );
  }
}
