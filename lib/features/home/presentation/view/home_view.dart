import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/services/location_service.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';

import '../../../trip_details/presentation/trip_wishlist_pop_result.dart';
import '../../../trip_details/presentation/view/trip_details_view.dart';
import '../../data/models/home_banner_model.dart';
import '../../data/models/home_section_response.dart';
import '../cubit/home_banners_cubit.dart';
import '../cubit/home_banners_state.dart';
import '../cubit/home_categories_cubit.dart';
import '../cubit/home_categories_state.dart';
import '../cubit/home_sections_cubit.dart';
import '../cubit/home_sections_state.dart';
import '../cubit/special_trips_cubit.dart';
import '../cubit/special_trips_state.dart';
import '../cubit/trending_destinations_items_cubit.dart';
import '../cubit/section_trips_items_cubit.dart';
import '../../domain/repositories/home_repository.dart';
import '../../../wishlist/domain/repositories/trip_wishlist_repository.dart';
import 'section_trips_list_view.dart';
import '../widgets/category_chip.dart';
import '../widgets/home_header.dart';
import '../widgets/home_trending_destinations_section.dart';
import '../widgets/popular_trip_grid_card.dart';
import '../widgets/promo_banner_item.dart';
import '../widgets/special_trip_wide_card.dart';
import '../../../../core/widgets/staggered_fade_slide.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  BuildContext? _refreshContext;
  String _locationText = '';

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    final locService = sl<LocationService>();
    await locService.fetchCurrentLocation();
    if (mounted && locService.currentLocation.isNotEmpty) {
      setState(() => _locationText = locService.currentLocation);
    }
  }

  Future<void> refreshFromNavBarTap() async {
    final ctx = _refreshContext;
    if (ctx == null) {
      return;
    }
    await _refreshHome(ctx);
  }

  Future<void> _onPopularTripHeartTap(
    BuildContext context,
    TripModel trip,
  ) async {
    final sectionsCubit = context.read<HomeSectionsCubit>();
    final specialCubit = context.read<SpecialTripsCubit>();
    await sectionsCubit.toggleTripWishlist(trip.id);
    TripModel? updated;
    for (final s in sectionsCubit.state.sections) {
      for (final t in s.trips) {
        if (t.id == trip.id) {
          updated = t;
          break;
        }
      }
      if (updated != null) {
        break;
      }
    }
    if (updated != null) {
      specialCubit.syncWishlistFromOtherList(trip.id, updated.isWishlisted);
    }
  }

  Future<void> _refreshHome(BuildContext context) async {
    final sections = context.read<HomeSectionsCubit>();
    final banners = context.read<HomeBannersCubit>();
    final categories = context.read<HomeCategoriesCubit>();
    final trendingDestinations = context.read<TrendingDestinationsItemsCubit>();
    final special = context.read<SpecialTripsCubit>();

    await Future.wait([
      sections.refreshSections(),
      banners.refreshBanners(),
      categories.refreshCategories(),
      trendingDestinations.refresh(),
    ]);

    final categoryId = categories.state.selectedId;
    if (categoryId != null) {
      await special.loadTrips(categoryId);
    }
  }

  void _openSpecialTripsSeeAll(
    BuildContext context, {
    required int categoryId,
  }) {
    final homeRepo = sl<HomeRepository>();
    final wishlistRepo = sl<TripWishlistRepository>();

    sl<AppNavigator>().push(
      screen: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<HomeSectionsCubit>()),
          BlocProvider.value(value: context.read<SpecialTripsCubit>()),
        ],
        child: SectionTripsListView(
          fallbackTitle: context.tr.homeSpecialTrips,
          cubitFactory: () => SectionTripsItemsCubit(
            ({int page = 1, int perPage = 15, String search = ''}) =>
                homeRepo.getSpecialTrips(
                  categoryId: categoryId,
                  page: page,
                  perPage: perPage,
                  search: search,
                ),
            wishlistRepo,
          ),
        ),
      ),
    );
  }

  Future<void> _onSpecialTripHeartTap(
    BuildContext context,
    TripModel trip,
  ) async {
    final specialCubit = context.read<SpecialTripsCubit>();
    final sectionsCubit = context.read<HomeSectionsCubit>();
    await specialCubit.toggleTripWishlist(trip.id);
    TripModel? updated;
    for (final t in specialCubit.state.trips) {
      if (t.id == trip.id) {
        updated = t;
        break;
      }
    }
    if (updated != null) {
      sectionsCubit.syncWishlistFromOtherList(trip.id, updated.isWishlisted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 16.w;
    final sheetTopRadius = 24.r;
    final sheetOverlap = 18.h;
    final sectionTitleStyle = AppTextStyles.heading3(
      color: AppColors.darkText(context),
    );
    final actionStyle = AppTextStyles.bodySmall(
      color: AppColors.primaryDark,
    ).copyWith(fontWeight: FontWeight.w600);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HomeSectionsCubit>()..loadSections()),
        BlocProvider(create: (_) => sl<HomeBannersCubit>()..loadBanners()),
        BlocProvider(
          create: (_) => sl<HomeCategoriesCubit>()..loadCategories(),
        ),
        BlocProvider(
          create: (_) => sl<TrendingDestinationsItemsCubit>()..loadInitial(),
        ),
        BlocProvider(create: (_) => sl<SpecialTripsCubit>()),
      ],
      child: Builder(
        builder: (innerContext) {
          _refreshContext = innerContext;
          return MultiBlocListener(
            listeners: [
              BlocListener<HomeSectionsCubit, HomeSectionsState>(
                listenWhen: (p, n) =>
                    n.wishlistErrorMessage != null &&
                    n.wishlistErrorMessage != p.wishlistErrorMessage,
                listener: (context, state) {
                  final msg = state.wishlistErrorMessage;
                  if (msg == null) {
                    return;
                  }
                  appToast(
                    context: context,
                    type: ToastType.error,
                    message: msg,
                  );
                  context.read<HomeSectionsCubit>().clearWishlistError();
                },
              ),
              BlocListener<SpecialTripsCubit, SpecialTripsState>(
                listenWhen: (p, n) =>
                    n.wishlistErrorMessage != null &&
                    n.wishlistErrorMessage != p.wishlistErrorMessage,
                listener: (context, state) {
                  final msg = state.wishlistErrorMessage;
                  if (msg == null) {
                    return;
                  }
                  appToast(
                    context: context,
                    type: ToastType.error,
                    message: msg,
                  );
                  context.read<SpecialTripsCubit>().clearWishlistError();
                },
              ),
            ],
            child: Scaffold(
              backgroundColor: AppColors.scaffoldBg(context),
              body: Builder(
                builder: (scrollContext) {
                  return CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: ClampingScrollPhysics(),
                    ),
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: HomeHeaderDelegate(
                          searchHint: scrollContext.tr.homeSearchHint,
                          locationText: _locationText.isNotEmpty
                              ? _locationText
                              : scrollContext.tr.homeLocationText,
                          topPadding: MediaQuery.paddingOf(scrollContext).top,
                          onNotificationsTap: () {},
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Transform.translate(
                          offset: Offset(0, -sheetOverlap),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.only(
                              start: horizontalPadding,
                              end: horizontalPadding,
                              top: 18.h,
                              bottom: 24.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.scaffoldBg(context),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(sheetTopRadius),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadow.withValues(
                                    alpha: 0.04,
                                  ),
                                  blurRadius: 18.r,
                                  offset: Offset(0, 10.h),
                                ),
                              ],
                            ),
                            child:
                                BlocBuilder<
                                  HomeSectionsCubit,
                                  HomeSectionsState
                                >(
                                  builder: (context, state) {
                                    if (state.status ==
                                            HomeSectionsStatus.loading ||
                                        state.status ==
                                            HomeSectionsStatus.initial) {
                                      return _buildHomeSectionsLoading();
                                    }

                                    if (state.status ==
                                        HomeSectionsStatus.failure) {
                                      return _buildError(
                                        context,
                                        state.errorMessage ??
                                            'Something went wrong',
                                      );
                                    }

                                    return _buildContent(
                                      context,
                                      state,
                                      sectionTitleStyle,
                                      actionStyle,
                                    );
                                  },
                                ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: sheetOverlap)),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    HomeSectionsState state,
    TextStyle sectionTitleStyle,
    TextStyle actionStyle,
  ) {
    final popularSection = state.sectionByKey('popular_trips');
    final sponsoredSection = state.sectionByKey('sponsored_trips');
    final domesticSection = state.sectionByKey('domestic_trips');
    final internationalSection = state.sectionByKey('international_trips');
    final recommendedSection = state.sectionByKey('recommended_for_you');

    void syncWishlistAfterTripDetails(TripWishlistPopResult? result) {
      if (result == null || !context.mounted) {
        return;
      }
      context.read<HomeSectionsCubit>().syncWishlistFromOtherList(
        result.tripId,
        result.isWishlisted,
      );
      context.read<SpecialTripsCubit>().syncWishlistFromOtherList(
        result.tripId,
        result.isWishlisted,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Trending Destinations (paginated section items API) ──
        HomeTrendingDestinationsSection(
          sectionTitleStyle: sectionTitleStyle,
          actionStyle: actionStyle,
        ),

        // ── Popular Trips ──
        if (popularSection != null) ...[
          _SectionHeader(
            title: popularSection.title,
            actionText: context.tr.homeSeeAll,
            titleStyle: sectionTitleStyle,
            actionStyle: actionStyle,
            onAction: () {
              sl<AppNavigator>().push(
                screen: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<HomeSectionsCubit>(),
                    ),
                    BlocProvider.value(
                      value: context.read<SpecialTripsCubit>(),
                    ),
                  ],
                  child: SectionTripsListView(
                    fallbackTitle: context.tr.homePopularTrips,
                    cubitFactory: () => SectionTripsItemsCubit(
                      sl<HomeRepository>().getPopularTripsItems,
                      sl<TripWishlistRepository>(),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 14.h),
          _TripHorizontalList(
            trips: popularSection.trips,
            onFavoriteTap: (trip) => _onPopularTripHeartTap(context, trip),
            onReturnedFromTripDetails: syncWishlistAfterTripDetails,
          ),
          SizedBox(height: 18.h),
        ],

        // ── Promo Banner ──
        BlocBuilder<HomeBannersCubit, HomeBannersState>(
          builder: (context, bannerState) {
            if (bannerState.status == HomeBannersStatus.success &&
                bannerState.banners.isNotEmpty) {
              return Column(
                children: [
                  _PromoBanner(banners: bannerState.banners),
                  SizedBox(height: 22.h),
                ],
              );
            }
            if (bannerState.status == HomeBannersStatus.loading) {
              return Column(
                children: [
                  SizedBox(
                    height: 140.h,
                    child: CustomLoading(strokeWidth: 2.5),
                  ),
                  SizedBox(height: 22.h),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),

        // ── Sponsored Trips ──
        if (sponsoredSection != null) ...[
          _SectionHeader(
            title: sponsoredSection.title,
            actionText: context.tr.homeSeeAll,
            titleStyle: sectionTitleStyle,
            actionStyle: actionStyle,
            onAction: () {
              sl<AppNavigator>().push(
                screen: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<HomeSectionsCubit>(),
                    ),
                    BlocProvider.value(
                      value: context.read<SpecialTripsCubit>(),
                    ),
                  ],
                  child: SectionTripsListView(
                    fallbackTitle: context.tr.homeSponsoredTrips,
                    cubitFactory: () => SectionTripsItemsCubit(
                      sl<HomeRepository>().getSponsoredTripsItems,
                      sl<TripWishlistRepository>(),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 14.h),
          _TripHorizontalList(
            trips: sponsoredSection.trips,
            onFavoriteTap: (trip) => _onPopularTripHeartTap(context, trip),
            onReturnedFromTripDetails: syncWishlistAfterTripDetails,
          ),
          SizedBox(height: 22.h),
        ],

        // ── Domestic Trips ──
        if (domesticSection != null) ...[
          _SectionHeader(
            title: domesticSection.title,
            actionText: context.tr.homeSeeAll,
            titleStyle: sectionTitleStyle,
            actionStyle: actionStyle,
            onAction: () {
              sl<AppNavigator>().push(
                screen: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<HomeSectionsCubit>(),
                    ),
                    BlocProvider.value(
                      value: context.read<SpecialTripsCubit>(),
                    ),
                  ],
                  child: SectionTripsListView(
                    fallbackTitle: context.tr.homeDomesticTripsInEgypt,
                    cubitFactory: () => SectionTripsItemsCubit(
                      sl<HomeRepository>().getDomesticTripsItems,
                      sl<TripWishlistRepository>(),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 14.h),
          _TripHorizontalList(
            trips: domesticSection.trips,
            onFavoriteTap: (trip) => _onPopularTripHeartTap(context, trip),
            onReturnedFromTripDetails: syncWishlistAfterTripDetails,
          ),
          SizedBox(height: 22.h),
        ],

        // ── International Trips ──
        if (internationalSection != null) ...[
          _SectionHeader(
            title: internationalSection.title,
            actionText: context.tr.homeSeeAll,
            titleStyle: sectionTitleStyle,
            actionStyle: actionStyle,
            onAction: () {
              sl<AppNavigator>().push(
                screen: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<HomeSectionsCubit>(),
                    ),
                    BlocProvider.value(
                      value: context.read<SpecialTripsCubit>(),
                    ),
                  ],
                  child: SectionTripsListView(
                    fallbackTitle: context.tr.homeInternationalTripsFromEgypt,
                    cubitFactory: () => SectionTripsItemsCubit(
                      sl<HomeRepository>().getInternationalTripsItems,
                      sl<TripWishlistRepository>(),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 14.h),
          _TripHorizontalList(
            trips: internationalSection.trips,
            onFavoriteTap: (trip) => _onPopularTripHeartTap(context, trip),
            onReturnedFromTripDetails: syncWishlistAfterTripDetails,
          ),
          SizedBox(height: 22.h),
        ],

        // ── Recommended For You ──
        if (recommendedSection != null) ...[
          _SectionHeader(
            title: recommendedSection.title,
            actionText: context.tr.homeSeeAll,
            titleStyle: sectionTitleStyle,
            actionStyle: actionStyle,
            onAction: () {
              sl<AppNavigator>().push(
                screen: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<HomeSectionsCubit>(),
                    ),
                    BlocProvider.value(
                      value: context.read<SpecialTripsCubit>(),
                    ),
                  ],
                  child: SectionTripsListView(
                    fallbackTitle: context.tr.homeRecommendedForYou,
                    cubitFactory: () => SectionTripsItemsCubit(
                      sl<HomeRepository>().getRecommendedForYouItems,
                      sl<TripWishlistRepository>(),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 14.h),
          _TripHorizontalList(
            trips: recommendedSection.trips,
            onFavoriteTap: (trip) => _onPopularTripHeartTap(context, trip),
            onReturnedFromTripDetails: syncWishlistAfterTripDetails,
          ),
          SizedBox(height: 22.h),
        ],

        // ── Categories + Special Trips ──
        BlocConsumer<HomeCategoriesCubit, HomeCategoriesState>(
          listenWhen: (prev, curr) =>
              curr.status == HomeCategoriesStatus.success &&
              (prev.status != HomeCategoriesStatus.success ||
                  prev.selectedId != curr.selectedId),
          listener: (context, catState) {
            if (catState.selectedId != null) {
              context.read<SpecialTripsCubit>().loadTrips(catState.selectedId!);
            }
          },
          builder: (context, catState) {
            if (catState.status == HomeCategoriesStatus.loading) {
              return SizedBox(
                height: 40.h,
                child: CustomLoading(size: 26, strokeWidth: 2),
              );
            }
            if (catState.status == HomeCategoriesStatus.success &&
                catState.categories.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(
                    title: context.tr.homeSpecialTrips,
                    actionText: context.tr.homeSeeAll,
                    titleStyle: sectionTitleStyle,
                    actionStyle: actionStyle,
                    onAction: () {
                      final selectedId = catState.selectedId;
                      if (selectedId == null) return;
                      _openSpecialTripsSeeAll(context, categoryId: selectedId);
                    },
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: catState.categories.length,
                      itemBuilder: (context, index) {
                        final cat = catState.categories[index];
                        final isSelected = cat.slug == catState.selectedSlug;
                        return CategoryChip(
                          label: cat.name,
                          isSelected: isSelected,
                          onTap: () {
                            context.read<HomeCategoriesCubit>().selectCategory(
                              cat.slug,
                              cat.id,
                            );
                            context.read<SpecialTripsCubit>().loadTrips(cat.id);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // ── Special Trips Vertical List (min height prevents jump on tab switch) ──
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 280.h),
                    child: BlocBuilder<SpecialTripsCubit, SpecialTripsState>(
                      builder: (context, tripState) {
                        if (tripState.status == SpecialTripsStatus.loading) {
                          return Center(
                            child: CustomLoading(size: 32, strokeWidth: 2.5),
                          );
                        }
                        if (tripState.status == SpecialTripsStatus.success ||
                            tripState.status ==
                                SpecialTripsStatus.loadingMore) {
                          if (tripState.trips.isEmpty) {
                            return SizedBox(
                              height: 100.h,
                              child: Center(
                                child: Text(
                                  'No trips available',
                                  style: AppTextStyles.bodyMedium(
                                    color: AppColors.greyText(context),
                                  ),
                                ),
                              ),
                            );
                          }
                          return _SpecialTripsVerticalList(
                            trips: tripState.trips,
                            onFavoriteTap: (trip) =>
                                _onSpecialTripHeartTap(context, trip),
                            onReturnedFromTripDetails:
                                syncWishlistAfterTripDetails,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  /// Primary home content loading — keeps sheet height stable without skeleton UI.
  Widget _buildHomeSectionsLoading() {
    return SizedBox(
      height: 420.h,
      child: CustomLoading(top: 32.h, size: 36, strokeWidth: 2.5),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: AppColors.greyText(context),
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(
                color: AppColors.greyText(context),
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                context.read<HomeSectionsCubit>().loadSections();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Retry',
                style: AppTextStyles.bodyMedium(
                  color: AppColors.onPrimary(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionText,
    required this.onAction,
    required this.titleStyle,
    required this.actionStyle,
  });

  final String title;
  final String actionText;
  final VoidCallback onAction;
  final TextStyle titleStyle;
  final TextStyle actionStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: titleStyle),
        GestureDetector(
          onTap: onAction,
          child: Text(actionText, style: actionStyle),
        ),
      ],
    );
  }
}

class _TripHorizontalList extends StatelessWidget {
  const _TripHorizontalList({
    required this.trips,
    required this.onFavoriteTap,
    required this.onReturnedFromTripDetails,
  });

  final List<TripModel> trips;
  final void Function(TripModel trip) onFavoriteTap;
  final void Function(TripWishlistPopResult? result) onReturnedFromTripDetails;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 346.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: trips.length,
        separatorBuilder: (_, __) => SizedBox(width: 14.w),
        itemBuilder: (context, index) {
          final trip = trips[index];
          return StaggeredFadeSlide(
            index: index,
            child: RepaintBoundary(
              child: SizedBox(
                width: 190.w,
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
                    onReturnedFromTripDetails(result);
                  },
                  onFavoriteTap: () => onFavoriteTap(trip),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PromoBanner extends StatefulWidget {
  const _PromoBanner({required this.banners});

  final List<HomeBannerModel> banners;

  @override
  State<_PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<_PromoBanner> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.banners.length,

          itemBuilder: (context, index, _) {
            final promo = widget.banners[index];
            return PromoBannerItem(
              title: promo.title,
              imageUrl: promo.image,
              buttonText: promo.ctaLabel,
              urlLaunch: promo.linkUrl,
              subtitle: promo.subtitle,
              currentIndex: index,
              totalCount: widget.banners.length,
              onBookNowTap: () {},
            );
          },
          options: CarouselOptions(
            height: 140.h,
            viewportFraction: 1,
            enlargeCenterPage: false,
            autoPlay: true,

            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (_, __) {},
          ),
        ),
      ],
    );
  }
}

class _SpecialTripsVerticalList extends StatelessWidget {
  const _SpecialTripsVerticalList({
    required this.trips,
    required this.onFavoriteTap,
    required this.onReturnedFromTripDetails,
  });

  static const int _homePreviewLimit = 2;

  final List<TripModel> trips;
  final void Function(TripModel trip) onFavoriteTap;
  final void Function(TripWishlistPopResult? result) onReturnedFromTripDetails;

  @override
  Widget build(BuildContext context) {
    final visibleTrips = trips.take(_homePreviewLimit).toList(growable: false);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: visibleTrips.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final trip = visibleTrips[index];
        return StaggeredFadeSlide(
          index: index,
          child: RepaintBoundary(
            child: SpecialTripWideCard(
              trip: trip,
              onTap: () async {
                final result = await sl<AppNavigator>()
                    .push<TripWishlistPopResult>(
                      screen: TripDetailsView(
                        tripId: trip.id,
                        initialIsWishlisted: trip.isWishlisted,
                      ),
                    );
                onReturnedFromTripDetails(result);
              },
              onFavoriteTap: () => onFavoriteTap(trip),
            ),
          ),
        );
      },
    );
  }
}
