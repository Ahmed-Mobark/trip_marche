import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/core/widgets/section_header.dart';
import 'package:trip_marche/core/widgets/trip_card.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/home/presentation/widgets/location_top_bar.dart';
import 'package:trip_marche/features/home/presentation/widgets/home_search_bar.dart';
import 'package:trip_marche/features/home/presentation/widgets/trending_destination_item.dart';
import 'package:trip_marche/features/home/presentation/widgets/promo_banner_item.dart';
import 'package:trip_marche/features/home/presentation/widgets/category_chip.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _promoCurrentIndex = 0;
  String _selectedSpecialCategory = 'Popular';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // a) Top bar
              const LocationTopBar(locationName: 'Sharm El Sheikh'),
              const SizedBox(height: 12),

              // b) Search bar
              const HomeSearchBar(),
              const SizedBox(height: 20),

              // c) Trending Destinations
              _buildTrendingDestinations(),
              const SizedBox(height: 20),

              // d) Popular Trips
              const SectionHeader(title: 'Popular Trips'),
              _buildHorizontalTripList(DummyData.popularTrips),
              const SizedBox(height: 20),

              // e) Promo Banner
              _buildPromoBanner(),
              const SizedBox(height: 20),

              // f) Sponsored Trips
              const SectionHeader(title: 'Sponsored Trips'),
              _buildHorizontalTripList(DummyData.sponsoredTrips),
              const SizedBox(height: 20),

              // g) Domestic Trips In Egypt
              const SectionHeader(title: 'Domestic Trips In Egypt'),
              _buildHorizontalTripList(DummyData.domesticTrips),
              const SizedBox(height: 20),

              // h) International Trips From Egypt
              const SectionHeader(title: 'International Trips From Egypt'),
              _buildHorizontalTripList(DummyData.internationalTrips),
              const SizedBox(height: 20),

              // i) Recommended For You
              const SectionHeader(title: 'Recommended For You'),
              _buildHorizontalTripList(DummyData.recommendedTrips),
              const SizedBox(height: 20),

              // j) Special Trips with category chips
              _buildSpecialTripsSection(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────
  // c) Trending Destinations
  // ──────────────────────────────────────────
  Widget _buildTrendingDestinations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Trending Destinations', style: AppTextStyles.heading3()),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: DummyData.trendingDestinations.length,
            itemBuilder: (context, index) {
              final dest = DummyData.trendingDestinations[index];
              return TrendingDestinationItem(
                name: dest.name,
                imageUrl: dest.imageUrl,
                rank: dest.rank,
              );
            },
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────
  // Horizontal trip list (reused for sections d, f, g, h, i)
  // ──────────────────────────────────────────
  Widget _buildHorizontalTripList(List<TripItem> trips) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return TripCard(
            trip: trips[index],
            onTap: () => sl<AppNavigator>().push(
              screen: const TripDetailsView(),
            ),
          );
        },
      ),
    );
  }

  // ──────────────────────────────────────────
  // e) Promo Banner Carousel
  // ──────────────────────────────────────────
  Widget _buildPromoBanner() {
    final promoItems = [
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

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: promoItems.length,
          itemBuilder: (context, index, _) {
            final promo = promoItems[index];
            return PromoBannerItem(
              title: promo['title']!,
              subtitle: promo['subtitle']!,
              currentIndex: index,
              totalCount: promoItems.length,
            );
          },
          options: CarouselOptions(
            height: 160,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, _) {
              setState(() {
                _promoCurrentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            promoItems.length,
            (index) => Container(
              width: _promoCurrentIndex == index ? 20 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: _promoCurrentIndex == index
                    ? AppColors.primary
                    : AppColors.border,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────
  // j) Special Trips with category chips + vertical list
  // ──────────────────────────────────────────
  Widget _buildSpecialTripsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Special Trips', actionText: null),
        const SizedBox(height: 4),

        // Category chips
        SizedBox(
          height: 38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: DummyData.specialCategories.length,
            itemBuilder: (context, index) {
              final cat = DummyData.specialCategories[index];
              final isSelected = cat == _selectedSpecialCategory;
              return CategoryChip(
                label: cat,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedSpecialCategory = cat;
                  });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        // "Top Rated" label
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Top Rated',
            style: AppTextStyles.subtitle(color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 8),

        // Vertical list of wide special trip cards
        ...DummyData.specialTrips
            .map((trip) => TripCardWide(
                  trip: trip,
                  onTap: () => sl<AppNavigator>().push(
                    screen: const TripDetailsView(),
                  ),
                )),
      ],
    );
  }
}
