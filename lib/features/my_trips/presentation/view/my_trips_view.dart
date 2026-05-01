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
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import '../cubit/my_trips_list_cubit.dart';
import '../cubit/my_trips_list_state.dart';
import '../widgets/my_trip_booking_card.dart';

class MyTripsView extends StatefulWidget {
  const MyTripsView({super.key});

  @override
  State<MyTripsView> createState() => _MyTripsViewState();
}

class _MyTripsViewState extends State<MyTripsView> {
  static const Duration _searchDebounce = Duration(milliseconds: 500);

  late final MyTripsListCubit _listCubit;
  late final ScrollController _scroll;
  late final TextEditingController _searchCtrl;
  Timer? _searchDebounceTimer;

  /// Normalized key for the last catalog request (`''` = no `search` param).
  String _lastAppliedSearchKey = '';

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController();
    _listCubit = sl<MyTripsListCubit>();
    _listCubit.setFilters(
      destinationId: AppConstants.myTripsCatalogSendDestinationId
          ? AppConstants.myTripsCatalogDestinationId
          : null,
    );
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

  /// Applies the current field text to GET `/trips` when on **Active** only.
  void _applyCatalogQueryFromField({bool force = false}) {
    _searchDebounceTimer?.cancel();
    if (!mounted || _selectedTab != 0) {
      return;
    }
    final key = _normalizedSearchKey(_searchCtrl.text);
    if (!force && key == _lastAppliedSearchKey) {
      return;
    }
    _lastAppliedSearchKey = key;
    _listCubit.setFilters(
      search: _searchCtrl.text,
      destinationId: AppConstants.myTripsCatalogSendDestinationId
          ? AppConstants.myTripsCatalogDestinationId
          : null,
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
    if (!_scroll.hasClients || _selectedTab != 0) {
      return;
    }
    final pos = _scroll.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      _listCubit.loadMore();
    }
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

  @override
  Widget build(BuildContext context) {
    final headerHeight = 120.h;
    final sheetRadius = 32.r;

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
        child: Scaffold(
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
                      start: 16.w,
                      end: 16.w,
                      top: 12.h,
                    ),
                    child: Text(
                      context.tr.myTripsTitle,
                      style: AppTextStyles.heading3(color: AppColors.onImage),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: headerHeight,
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                    start: 16.w,
                    end: 16.w,
                    top: 22.h,
                    bottom: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(sheetRadius),
                    ),
                  ),
                  child: Column(
                    children: [
                      _MyTripsSearchField(
                        controller: _searchCtrl,
                        hint: context.tr.myTripsSearchHint,
                        onChanged: _onSearchTextChanged,
                        onSubmitted: _flushSearchImmediate,
                        onClear: _clearSearchField,
                      ),
                      SizedBox(height: 14.h),
                      _TripsTabs(
                        selectedIndex: _selectedTab,
                        onChanged: _onTripTabChanged,
                        activeText: context.tr.myTripsTabActive,
                        pastText: context.tr.myTripsTabPastNew,
                        canceledText: context.tr.myTripsTabCanceled,
                      ),
                      SizedBox(height: 14.h),
                      Expanded(
                        child: _selectedTab == 0
                            ? _buildActiveTabBody(context, status)
                            : _buildLegacyTabBody(context, legacyTrips, status),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTabBody(
    BuildContext context,
    (String, Color, String, String) status,
  ) {
    return BlocBuilder<MyTripsListCubit, MyTripsListState>(
      builder: (context, state) {
        if (state.status == MyTripsListStatus.loading &&
            state.trips.isEmpty) {
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
                    onPressed: () => context.read<MyTripsListCubit>().loadInitial(),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onImage,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.trips.isEmpty) {
          return _buildEmptyState(context);
        }

        final itemCount = state.trips.length +
            (state.hasMore && state.status == MyTripsListStatus.loadingMore
                ? 1
                : 0);

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<MyTripsListCubit>().refresh(),
          child: ListView.separated(
            controller: _scroll,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: itemCount,
            separatorBuilder: (_, __) => SizedBox(height: 14.h),
            itemBuilder: (context, index) {
              if (index >= state.trips.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: CustomLoading(size: 24, strokeWidth: 2),
                );
              }
              final trip = state.trips[index];
              final rawLocation = trip.fromLocation.trim();
              final locationText = rawLocation.startsWith(
                    context.tr.myTripsFromPrefix,
                  )
                  ? rawLocation
                  : '${context.tr.myTripsFromPrefix} $rawLocation';
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
                  context.read<MyTripsListCubit>().applyWishlistStateFromDetails(
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
      separatorBuilder: (_, __) => SizedBox(height: 14.h),
      itemBuilder: (context, index) {
        final trip = trips[index];
        final rawLocation = trip.location.trim();
        final locationText = rawLocation.startsWith(
              context.tr.myTripsFromPrefix,
            )
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
            onPressed: () {},
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

class _MyTripsSearchField extends StatefulWidget {
  const _MyTripsSearchField({
    required this.controller,
    required this.hint,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;
  final VoidCallback onClear;

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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOutCubic,
      height: 46.h,
      padding: EdgeInsetsDirectional.only(
        start: 14.w,
        end: showClear ? 6.w : 14.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: focused ? AppColors.primary : AppColors.border,
          width: focused ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(Iconsax.search_normal, size: 20.sp, color: AppColors.greyText),
          SizedBox(width: 10.w),
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
                hintStyle: AppTextStyles.bodyMedium(color: AppColors.greyText),
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTextStyles.bodyMedium(color: AppColors.darkText),
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
        SizedBox(width: 12.w),
        Expanded(
          child: _TabPill(
            text: pastText,
            isSelected: selectedIndex == 1,
            onTap: () => onChanged(1),
          ),
        ),
        SizedBox(width: 12.w),
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
        height: 35.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardBg,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected ? null : Border.all(color: AppColors.border),
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
