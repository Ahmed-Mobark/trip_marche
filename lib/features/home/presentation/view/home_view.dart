import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
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
  String _selectedSpecialCategory = DummyData.specialCategories.first;

  static const List<Map<String, String>> _promoItems = [
    {
      'title': 'Get 15% Off!',
      'subtitle': 'On all summer trips this week only',
    },
    {
      'title': 'Early Bird Deal',
      'subtitle': 'Book 30 days ahead and save 20%',
    },
    {
      'title': 'Group Discount',
      'subtitle': 'Travel with 4+ friends, get 10% off',
    },
    {
      'title': 'Weekend Special',
      'subtitle': 'Domestic trips starting at \$99',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 16.w;
    final sheetTopRadius = 24.r;
    final sheetOverlap = 18.h;
    final sectionTitleStyle = AppTextStyles.heading3(color: AppColors.darkText);
    final actionStyle = AppTextStyles.bodySmall(color: AppColors.primaryDark)
        .copyWith(fontWeight: FontWeight.w600);

    return Scaffold(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.tr.homeTrendingDestinations,
                        style: sectionTitleStyle),
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 110.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: DummyData.trendingDestinations.length,
                        itemBuilder: (context, index) {
                          final dest = DummyData.trendingDestinations[index];
                          return TrendingDestinationCard(
                            name: dest.name,
                            imageUrl: dest.imageUrl,
                            rank: dest.rank,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 22.h),
                    _SectionHeader(
                      title: context.tr.homePopularTrips,
                      actionText: context.tr.homeSeeAll,
                      titleStyle: sectionTitleStyle,
                      actionStyle: actionStyle,
                      onAction: () {},
                    ),
                    SizedBox(height: 14.h),
                    _TripHorizontalList(trips: DummyData.popularTrips),
                    SizedBox(height: 18.h),
                    _PromoBanner(promoItems: _promoItems),
                    SizedBox(height: 22.h),
                    _SectionHeader(
                      title: context.tr.homeSponsoredTrips,
                      actionText: context.tr.homeSeeAll,
                      titleStyle: sectionTitleStyle,
                      actionStyle: actionStyle,
                      onAction: () {},
                    ),
                    SizedBox(height: 14.h),
                    _TripHorizontalList(trips: DummyData.sponsoredTrips),
                    SizedBox(height: 22.h),
                    _SectionHeader(
                      title: context.tr.homeDomesticTripsInEgypt,
                      actionText: context.tr.homeSeeAll,
                      titleStyle: sectionTitleStyle,
                      actionStyle: actionStyle,
                      onAction: () {},
                    ),
                    SizedBox(height: 14.h),
                    _TripHorizontalList(trips: DummyData.domesticTrips),
                    SizedBox(height: 22.h),
                    _SectionHeader(
                      title: context.tr.homeInternationalTripsFromEgypt,
                      actionText: context.tr.homeSeeAll,
                      titleStyle: sectionTitleStyle,
                      actionStyle: actionStyle,
                      onAction: () {},
                    ),
                    SizedBox(height: 14.h),
                    _TripHorizontalList(trips: DummyData.internationalTrips),
                    SizedBox(height: 22.h),
                    _SectionHeader(
                      title: context.tr.homeRecommendedForYou,
                      actionText: context.tr.homeSeeAll,
                      titleStyle: sectionTitleStyle,
                      actionStyle: actionStyle,
                      onAction: () {},
                    ),
                    SizedBox(height: 14.h),
                    _TripHorizontalList(trips: DummyData.recommendedTrips),
                    SizedBox(height: 22.h),
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
                        itemCount: DummyData.specialCategories.length,
                        itemBuilder: (context, index) {
                          final cat = DummyData.specialCategories[index];
                          final isSelected = cat == _selectedSpecialCategory;
                          return CategoryChip(
                            label: cat,
                            isSelected: isSelected,
                            onTap: () => setState(() {
                              _selectedSpecialCategory = cat;
                            }),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 14.h),
                    SpecialTripWideCard(
                      trip: DummyData.specialTrips.first,
                      onTap: () => sl<AppNavigator>().push(
                        screen: const TripDetailsView(),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: sheetOverlap)),
        ],
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
        GestureDetector(onTap: onAction, child: Text(actionText, style: actionStyle)),
      ],
    );
  }
}

class _TripHorizontalList extends StatelessWidget {
  const _TripHorizontalList({required this.trips});

  final List<TripItem> trips;

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
              onTap: () => sl<AppNavigator>().push(
                screen: const TripDetailsView(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PromoBanner extends StatefulWidget {
  const _PromoBanner({required this.promoItems});

  final List<Map<String, String>> promoItems;

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
          itemCount: widget.promoItems.length,
          itemBuilder: (context, index, _) {
            final promo = widget.promoItems[index];
            return PromoBannerItem(
              title: promo['title']!,
              subtitle: promo['subtitle']!,
              currentIndex: index,
              totalCount: widget.promoItems.length,
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
            widget.promoItems.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: _currentIndex == i ? 18.w : 6.w,
              height: 6.w,
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                color: _currentIndex == i ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
