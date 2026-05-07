import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:trip_marche/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:trip_marche/features/wishlist/presentation/view/wishlist_filter_view.dart';
import '../widgets/wishlist_trip_card.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  late final WishlistCubit _cubit;
  late final ScrollController _scroll;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _cubit = sl<WishlistCubit>()..loadInitial();
    _scroll = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scroll.hasClients) {
      return;
    }
    final pos = _scroll.position;
    if (pos.pixels >= pos.maxScrollExtent - 280) {
      _cubit.loadMore();
    }
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sheetRadius = 20.r;

    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<WishlistCubit, WishlistState>(
        listenWhen: (p, n) =>
            n.wishlistErrorMessage != null &&
            n.wishlistErrorMessage != p.wishlistErrorMessage,
        listener: (context, state) {
          final msg = state.wishlistErrorMessage;
          if (msg == null) {
            return;
          }
          appToast(context: context, type: ToastType.error, message: msg);
          context.read<WishlistCubit>().clearWishlistError();
        },
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: Stack(
            fit: StackFit.expand,
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(gradient: AppColors.primaryGradient),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 16.w,
                        end: 16.w,
                        top: 6.h,
                        bottom: 20.h,
                      ),
                      child: Text(
                        context.tr.wishlistTitle,
                        style: AppTextStyles.heading2(
                          color: AppColors.onImage,
                        ).copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(sheetRadius),
                        ),
                      ),
                      child: BlocBuilder<WishlistCubit, WishlistState>(
                        builder: (context, state) {
                          if (state.status == WishlistPageStatus.loading &&
                              state.trips.isEmpty) {
                            return SizedBox(
                              height: 280.h,
                              child: CustomLoading(
                                top: 48.h,
                                size: 36,
                                strokeWidth: 2.5,
                              ),
                            );
                          }

                          if (state.status == WishlistPageStatus.failure &&
                              state.trips.isEmpty) {
                            return _ErrorBody(
                              message: state.errorMessage ?? 'Unknown error',
                              onRetry: () =>
                                  context.read<WishlistCubit>().loadInitial(),
                            );
                          }

                          if (state.trips.isEmpty) {
                            return Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 16.w,
                                end: 16.w,
                                top: 16.h,
                                bottom: 16.h,
                              ),
                              child: _buildEmptyState(context),
                            );
                          }

                          return RefreshIndicator(
                            color: AppColors.primary,
                            onRefresh: () => context.read<WishlistCubit>().refresh(),
                            child: CustomScrollView(
                              controller: _scroll,
                              physics: const AlwaysScrollableScrollPhysics(
                                parent: ClampingScrollPhysics(),
                              ),
                              slivers: [
                                SliverPadding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 16.w,
                                    end: 16.w,
                                    top: 16.h,
                                  ),
                                  sliver: SliverToBoxAdapter(
                                    child: Column(
                                      children: [
                                        TextField(
                                          onChanged: (value) => setState(
                                            () => _searchQuery = value.trim(),
                                          ),
                                          decoration: InputDecoration(
                                            hintText: context.tr.wishlistSearchHint,
                                            prefixIcon: Icon(
                                              Iconsax.search_normal_1,
                                              size: 20.sp,
                                              color: AppColors.greyText,
                                            ),
                                            filled: true,
                                            fillColor: AppColors.background,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                999.r,
                                              ),
                                              borderSide: BorderSide(
                                                color: AppColors.border,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                999.r,
                                              ),
                                              borderSide: BorderSide(
                                                color: AppColors.border,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                999.r,
                                              ),
                                              borderSide: BorderSide(
                                                color: AppColors.border,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _TopActionPill(
                                                icon: Iconsax.arrow_down_1,
                                                text: context.tr.wishlistSortBy,
                                                onTap: () {},
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: _TopActionPill(
                                                icon: Iconsax.filter,
                                                text: context.tr.wishlistFilters,
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (_) =>
                                                          const WishlistFilterView(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12.h),
                                      ],
                                    ),
                                  ),
                                ),
                                SliverPadding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 16.w,
                                    end: 16.w,
                                  ),
                                  sliver: SliverList.separated(
                                    itemCount:
                                        state.trips
                                            .where(
                                              (t) =>
                                                  _searchQuery.isEmpty ||
                                                  t.title.toLowerCase().contains(
                                                    _searchQuery.toLowerCase(),
                                                  ),
                                            )
                                            .length +
                                        (state.hasMore &&
                                                state.status ==
                                                    WishlistPageStatus.loadingMore
                                            ? 1
                                            : 0),
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 14.h),
                                    itemBuilder: (context, index) {
                                      final filteredTrips = state.trips
                                          .where(
                                            (t) =>
                                                _searchQuery.isEmpty ||
                                                t.title.toLowerCase().contains(
                                                  _searchQuery.toLowerCase(),
                                                ),
                                          )
                                          .toList();
                                      if (index >= filteredTrips.length) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 16.h,
                                          ),
                                          child: CustomLoading(
                                            size: 24,
                                            strokeWidth: 2,
                                          ),
                                        );
                                      }
                                      final trip = filteredTrips[index];
                                      return WishlistTripCard(
                                        trip: trip,
                                        onFavoriteTap: () => context
                                            .read<WishlistCubit>()
                                            .toggleTripWishlist(trip.id),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
            child: Icon(Iconsax.heart, size: 36, color: AppColors.greyText),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.wishlistEmptyTitle,
            style: AppTextStyles.heading3(color: AppColors.secondaryText),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.wishlistEmptyDescription,
            style: AppTextStyles.bodyMedium(color: AppColors.greyText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.warning_2, size: 48, color: AppColors.greyText),
            SizedBox(height: 16.h),
            Text(
              message,
              style: AppTextStyles.bodyMedium(color: AppColors.secondaryText),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            FilledButton(
              onPressed: onRetry,
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
}

class _TopActionPill extends StatelessWidget {
  const _TopActionPill({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999.r),
        child: Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(999.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16.sp, color: AppColors.bodyText),
              SizedBox(width: 8.w),
              Text(
                text,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.bodyText,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
