import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import '../../data/models/home_section_response.dart';
import '../cubit/home_sections_cubit.dart';
import '../cubit/home_sections_state.dart';
import '../cubit/home_banners_cubit.dart';
import '../cubit/home_banners_state.dart';
import '../../data/models/home_banner_model.dart';
import '../cubit/home_categories_cubit.dart';
import '../cubit/home_categories_state.dart';
import '../cubit/special_trips_cubit.dart';
import '../cubit/special_trips_state.dart';
import '../widgets/home_header.dart';
import '../widgets/trending_destination_card.dart';
import '../widgets/popular_trip_grid_card.dart';
import '../widgets/promo_banner_item.dart';
import '../widgets/category_chip.dart';
import '../widgets/special_trip_wide_card.dart';
import '../../../trip_details/presentation/view/trip_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 16.w;
    final sheetTopRadius = 24.r;
    final sheetOverlap = 18.h;
    final sectionTitleStyle = AppTextStyles.heading3(color: AppColors.darkText);
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
        BlocProvider(create: (_) => sl<SpecialTripsCubit>()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColorLight,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: HomeHeader(
                searchHint: context.tr.homeSearchHint,
                locationText: context.tr.homeLocationText,
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
                    color: AppColors.scaffoldColorLight,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(sheetTopRadius),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 18.r,
                        offset: Offset(0, 10.h),
                      ),
                    ],
                  ),
                  child: BlocBuilder<HomeSectionsCubit, HomeSectionsState>(
                    builder: (context, state) {
                      if (state.status == HomeSectionsStatus.loading ||
                          state.status == HomeSectionsStatus.initial) {
                        return _buildShimmerLoading();
                      }

                      if (state.status == HomeSectionsStatus.failure) {
                        return _buildError(
                          context,
                          state.errorMessage ?? 'Something went wrong',
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
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    HomeSectionsState state,
    TextStyle sectionTitleStyle,
    TextStyle actionStyle,
  ) {
    final trendingSection = state.sectionByKey('trending_destinations');
    final popularSection = state.sectionByKey('popular_trips');
    final sponsoredSection = state.sectionByKey('sponsored_trips');
    final domesticSection = state.sectionByKey('domestic_trips');
    final internationalSection = state.sectionByKey('international_trips');
    final recommendedSection = state.sectionByKey('recommended_for_you');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Trending Destinations ──
        if (trendingSection != null) ...[
          Text(trendingSection.title, style: sectionTitleStyle),
          SizedBox(height: 12.h),
          SizedBox(
            height: 110.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendingSection.destinations.length,
              itemBuilder: (context, index) {
                final dest = trendingSection.destinations[index];
                return TrendingDestinationCard(
                  name: dest.name,
                  imageUrl: dest.image,
                  rank: dest.trendingRank,
                );
              },
            ),
          ),
          SizedBox(height: 22.h),
        ],

        // ── Popular Trips ──
        if (popularSection != null) ...[
          _SectionHeader(
            title: popularSection.title,
            actionText: context.tr.homeSeeAll,
            titleStyle: sectionTitleStyle,
            actionStyle: actionStyle,
            onAction: () {},
          ),
          SizedBox(height: 14.h),
          _TripHorizontalList(trips: popularSection.trips),
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
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 140.h,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
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
            onAction: () {},
          ),
          SizedBox(height: 14.h),
          _TripHorizontalList(trips: sponsoredSection.trips),
          SizedBox(height: 22.h),
        ],

        // ── Domestic Trips ──
        if (domesticSection != null) ...[
          _SectionHeader(
            title: domesticSection.title,
            actionText: context.tr.homeSeeAll,
            titleStyle: sectionTitleStyle,
            actionStyle: actionStyle,
            onAction: () {},
          ),
          SizedBox(height: 14.h),
          _TripHorizontalList(trips: domesticSection.trips),
          SizedBox(height: 22.h),
        ],

        // ── International Trips ──
        if (internationalSection != null) ...[
          _SectionHeader(
            title: internationalSection.title,
            actionText: context.tr.homeSeeAll,
            titleStyle: sectionTitleStyle,
            actionStyle: actionStyle,
            onAction: () {},
          ),
          SizedBox(height: 14.h),
          _TripHorizontalList(trips: internationalSection.trips),
          SizedBox(height: 22.h),
        ],

        // ── Recommended For You ──
        if (recommendedSection != null) ...[
          _SectionHeader(
            title: recommendedSection.title,
            actionText: context.tr.homeSeeAll,
            titleStyle: sectionTitleStyle,
            actionStyle: actionStyle,
            onAction: () {},
          ),
          SizedBox(height: 14.h),
          _TripHorizontalList(trips: recommendedSection.trips),
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
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (_, __) => Container(
                      width: 80.w,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                    ),
                  ),
                ),
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
                    onAction: () {},
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
                  SizedBox(height: 14.h),
                  // ── Special Trips Horizontal Paginated List ──
                  BlocBuilder<SpecialTripsCubit, SpecialTripsState>(
                    builder: (context, tripState) {
                      if (tripState.status == SpecialTripsStatus.loading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 224.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                        );
                      }
                      if (tripState.status == SpecialTripsStatus.success ||
                          tripState.status == SpecialTripsStatus.loadingMore) {
                        if (tripState.trips.isEmpty) {
                          return SizedBox(
                            height: 100.h,
                            child: Center(
                              child: Text(
                                'No trips available',
                                style: AppTextStyles.bodyMedium(
                                  color: AppColors.greyText,
                                ),
                              ),
                            ),
                          );
                        }
                        return _SpecialTripsHorizontalList(
                          trips: tripState.trips,
                          isLoadingMore:
                              tripState.status ==
                              SpecialTripsStatus.loadingMore,
                          hasMore: tripState.hasMore,
                          onLoadMore: () {
                            context.read<SpecialTripsCubit>().loadMore();
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
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

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title shimmer
          Container(
            width: 200.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 12.h),
          // Trending destinations shimmer
          SizedBox(
            height: 110.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (_, __) => Container(
                width: 118.w,
                margin: EdgeInsetsDirectional.only(end: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 22.h),
          // Section header shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 140.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              Container(
                width: 60.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // Trip cards shimmer
          SizedBox(
            height: 340.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, __) => SizedBox(width: 14.w),
              itemBuilder: (_, __) => Container(
                width: 190.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: AppColors.greyText),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(color: AppColors.greyText),
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
                style: AppTextStyles.bodyMedium(color: Colors.white),
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
  const _TripHorizontalList({required this.trips});

  final List<TripModel> trips;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: trips.length,
        separatorBuilder: (_, __) => SizedBox(width: 14.w),
        itemBuilder: (context, index) {
          final trip = trips[index];
          return SizedBox(
            width: 190.w,
            child: PopularTripGridCard(
              trip: trip,
              onTap: () =>
                  sl<AppNavigator>().push(screen: const TripDetailsView()),
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
  int _currentIndex = 0;

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
            onPageChanged: (index, _) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.banners.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: _currentIndex == i ? 18.w : 6.w,
              height: 6.w,
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                color: _currentIndex == i
                    ? AppColors.primary
                    : AppColors.border,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SpecialTripsHorizontalList extends StatefulWidget {
  const _SpecialTripsHorizontalList({
    required this.trips,
    required this.isLoadingMore,
    required this.hasMore,
    required this.onLoadMore,
  });

  final List<TripModel> trips;
  final bool isLoadingMore;
  final bool hasMore;
  final VoidCallback onLoadMore;

  @override
  State<_SpecialTripsHorizontalList> createState() =>
      _SpecialTripsHorizontalListState();
}

class _SpecialTripsHorizontalListState
    extends State<_SpecialTripsHorizontalList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    // Trigger load more when user is within 200px of the end
    if (currentScroll >= maxScroll - 200 &&
        widget.hasMore &&
        !widget.isLoadingMore) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.trips.length + (widget.hasMore ? 1 : 0);

    return SizedBox(
      height: 224.h,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (_, __) => SizedBox(width: 14.w),
        itemBuilder: (context, index) {
          if (index >= widget.trips.length) {
            return SizedBox(
              width: 60.w,
              child: Center(
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.primary,
                  ),
                ),
              ),
            );
          }
          final trip = widget.trips[index];
          return SizedBox(
            width: 350.w,
            child: SpecialTripWideCard(
              trip: trip,
              onTap: () =>
                  sl<AppNavigator>().push(screen: const TripDetailsView()),
            ),
          );
        },
      ),
    );
  }
}
