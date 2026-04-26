import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/data/dummy_data.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/extensions/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Scaffold(
      backgroundColor: AppColors.scaffoldColorLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(
              searchHint: context.tr.homeSearchHint,
              locationText: context.tr.homeLocationText,
              onNotificationsTap: () {},
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
                end: 16.w,
                top: 18.h,
                bottom: 24.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.scaffoldColorLight,
                borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr.homeTrendingDestinations,
                    style: AppTextStyles.heading3(color: AppColors.darkText),
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr.homePopularTrips,
                        style: AppTextStyles.heading3(
                          color: AppColors.darkText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          context.tr.homeSeeAll,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 340.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: DummyData.popularTrips.length,
                      separatorBuilder: (_, __) => SizedBox(width: 14.w),
                      itemBuilder: (context, index) {
                        final trip = DummyData.popularTrips[index];
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
                  ),

                  SizedBox(height: 18.h),
                  _PromoBanner(promoItems: _promoItems),

                  SizedBox(height: 22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr.homeSponsoredTrips,
                        style: AppTextStyles.heading3(color: AppColors.darkText),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          context.tr.homeSeeAll,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 340.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: DummyData.sponsoredTrips.length,
                      separatorBuilder: (_, __) => SizedBox(width: 14.w),
                      itemBuilder: (context, index) {
                        final trip = DummyData.sponsoredTrips[index];
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
                  ),

                  SizedBox(height: 22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr.homeDomesticTripsInEgypt,
                        style: AppTextStyles.heading3(color: AppColors.darkText),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          context.tr.homeSeeAll,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 340.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: DummyData.domesticTrips.length,
                      separatorBuilder: (_, __) => SizedBox(width: 14.w),
                      itemBuilder: (context, index) {
                        final trip = DummyData.domesticTrips[index];
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
                  ),

                  SizedBox(height: 22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr.homeInternationalTripsFromEgypt,
                        style: AppTextStyles.heading3(color: AppColors.darkText),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          context.tr.homeSeeAll,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 340.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: DummyData.internationalTrips.length,
                      separatorBuilder: (_, __) => SizedBox(width: 14.w),
                      itemBuilder: (context, index) {
                        final trip = DummyData.internationalTrips[index];
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
                  ),

                  SizedBox(height: 22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr.homeRecommendedForYou,
                        style: AppTextStyles.heading3(color: AppColors.darkText),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          context.tr.homeSeeAll,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 340.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: DummyData.recommendedTrips.length,
                      separatorBuilder: (_, __) => SizedBox(width: 14.w),
                      itemBuilder: (context, index) {
                        final trip = DummyData.recommendedTrips[index];
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
                  ),

                  SizedBox(height: 22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr.homeSpecialTrips,
                        style: AppTextStyles.heading3(color: AppColors.darkText),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          context.tr.homeSeeAll,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
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
                ],
              ),
            ),
          ],
        ),
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
