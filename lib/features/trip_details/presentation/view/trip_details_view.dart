import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/circle_icon_button.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_detail_item.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/itinerary_day.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/review_item_display.dart';

class TripDetailsView extends StatefulWidget {
  const TripDetailsView({super.key});

  @override
  State<TripDetailsView> createState() => _TripDetailsViewState();
}

class _TripDetailsViewState extends State<TripDetailsView> {
  bool _isFavorite = false;
  int _expandedDay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroImage(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildTitleAndRating(),
                      const SizedBox(height: 16),
                      _buildCompanyInfo(),
                      const SizedBox(height: 20),
                      _buildTripDetailsRow(),
                      const SizedBox(height: 20),
                      _buildPriceSection(),
                      const SizedBox(height: 24),
                      _buildDescription(),
                      const SizedBox(height: 24),
                      _buildTripItinerary(),
                      const SizedBox(height: 24),
                      _buildTripIncludes(),
                      const SizedBox(height: 24),
                      _buildTripImages(),
                      const SizedBox(height: 24),
                      _buildReviewsSection(),
                      const SizedBox(height: 24),
                      _buildRelatedTrips(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.lightBg,
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=800',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: CircleIconButton(
            icon: Iconsax.arrow_left,
            onTap: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 60,
          child: CircleIconButton(icon: Iconsax.share, onTap: () {}),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 16,
          child: CircleIconButton(
            icon: _isFavorite ? Iconsax.heart5 : Iconsax.heart,
            iconColor: _isFavorite ? AppColors.error : Colors.white,
            onTap: () => setState(() => _isFavorite = !_isFavorite),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(context.tr.tripDetailsTitle, style: AppTextStyles.heading3()),
        Row(
          children: [
            const Icon(Iconsax.star1, color: AppColors.starYellow, size: 18),
            const SizedBox(width: 4),
            Text(
              '4.9',
              style: AppTextStyles.bodyMedium(color: AppColors.darkText),
            ),
            Text(
              '(112)',
              style: AppTextStyles.bodySmall(color: AppColors.greyText),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompanyInfo() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.lightBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(
            Iconsax.building,
            size: 20,
            color: AppColors.greyText,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.tr.tripDetailsCompanyName, style: AppTextStyles.bodyMedium()),
              Text(context.tr.tripDetailsCompanyTagline, style: AppTextStyles.bodySmall()),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          ),
          child: Text(
            context.tr.tripDetailsFollow,
            style: AppTextStyles.bodyMedium(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildTripDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TripDetailItem(
          icon: Iconsax.calendar,
          value: context.tr.tripDetailsDurationValue,
          label: context.tr.tripDetailsDurationLabel,
        ),
        TripDetailItem(
          icon: Iconsax.people,
          value: context.tr.tripDetailsGroupSizeValue,
          label: context.tr.tripDetailsGroupSizeLabel,
        ),
        TripDetailItem(
          icon: Iconsax.user_octagon,
          value: context.tr.tripDetailsTypeValue,
          label: context.tr.tripDetailsTypeLabel,
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '\$699',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        Text(
          context.tr.tripDetailsPerPerson,
          style: AppTextStyles.bodyMedium(color: AppColors.greyText),
        ),
        const SizedBox(width: 12),
        Text(
          '\$1000',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.greyText,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsDescriptionTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        const SizedBox(height: 8),
        ReadMoreText(
          context.tr.tripDetailsDescriptionBody,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: context.tr.tripDetailsReadMore,
          trimExpandedText: context.tr.tripDetailsShowLess,
          style: AppTextStyles.body(color: AppColors.secondaryText),
          moreStyle: AppTextStyles.bodyMedium(color: AppColors.primary),
          lessStyle: AppTextStyles.bodyMedium(color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildTripItinerary() {
    final days = [
      {
        'title': context.tr.tripDetailsDay1Title,
        'desc': context.tr.tripDetailsDay1Desc,
      },
      {
        'title': context.tr.tripDetailsDay2Title,
        'desc': context.tr.tripDetailsDay2Desc,
      },
      {
        'title': context.tr.tripDetailsDay3Title,
        'desc': context.tr.tripDetailsDay3Desc,
      },
      {
        'title': context.tr.tripDetailsDay4Title,
        'desc': context.tr.tripDetailsDay4Desc,
      },
      {
        'title': context.tr.tripDetailsDay5Title,
        'desc': context.tr.tripDetailsDay5Desc,
      },
      {
        'title': context.tr.tripDetailsDay6Title,
        'desc': context.tr.tripDetailsDay6Desc,
      },
      {
        'title': context.tr.tripDetailsDay7Title,
        'desc': context.tr.tripDetailsDay7Desc,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsItineraryTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        const SizedBox(height: 12),
        ...List.generate(days.length, (index) {
          final isExpanded = _expandedDay == index;
          return ItineraryDay(
            title: days[index]['title']!,
            description: days[index]['desc']!,
            isExpanded: isExpanded,
            onTap: () => setState(() => _expandedDay = isExpanded ? -1 : index),
          );
        }),
      ],
    );
  }

  Widget _buildTripIncludes() {
    final includes = [
      {'icon': Iconsax.building_4, 'label': context.tr.tripDetailsIncludesHotel},
      {'icon': Iconsax.bus, 'label': context.tr.tripDetailsIncludesTransportation},
      {'icon': Iconsax.coffee, 'label': context.tr.tripDetailsIncludesMeals},
      {'icon': Iconsax.activity, 'label': context.tr.tripDetailsIncludesActivities},
      {'icon': Iconsax.user, 'label': context.tr.tripDetailsIncludesTourGuide},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsIncludesTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: includes.map((item) {
            return Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['label'] as String,
                  style: AppTextStyles.caption(color: AppColors.secondaryText),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTripImages() {
    final images = [
      'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
      'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400',
      'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=400',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsImagesTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  width: 160,
                  height: 120,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: AppColors.lightBg,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.lightBg,
                    child: const Icon(Iconsax.image, color: AppColors.greyText),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsReviewsTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Average rating
            Column(
              children: [
                Text(
                  '4.9',
                  style: GoogleFonts.inter(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkText,
                  ),
                ),
                Row(
                  children: List.generate(5, (i) {
                    return const Icon(
                      Iconsax.star1,
                      color: AppColors.starYellow,
                      size: 16,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  context.tr.tripDetailsReviewsCount('112'),
                  style: AppTextStyles.bodySmall(),
                ),
              ],
            ),
            const SizedBox(width: 24),
            // Star distribution
            Expanded(
              child: Column(
                children: [
                  _buildStarBar(5, 0.85),
                  _buildStarBar(4, 0.10),
                  _buildStarBar(3, 0.03),
                  _buildStarBar(2, 0.01),
                  _buildStarBar(1, 0.01),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ReviewItemDisplay(
          name: 'Ahmed Hassan',
          rating: 5,
          date: 'Dec 2025',
          comment:
              'Amazing trip! The Blue Hole snorkeling was a once-in-a-lifetime experience. Great organization.',
        ),
        const SizedBox(height: 12),
        ReviewItemDisplay(
          name: 'Sara Mohamed',
          rating: 5,
          date: 'Nov 2025',
          comment:
              'Beautiful destination and very well organized. The desert safari was the highlight for me.',
        ),
      ],
    );
  }

  Widget _buildStarBar(int star, double fraction) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$star',
            style: AppTextStyles.caption(color: AppColors.greyText),
          ),
          const SizedBox(width: 6),
          const Icon(Iconsax.star1, color: AppColors.starYellow, size: 12),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fraction,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.starYellow,
                ),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedTrips() {
    final trips = [
      {
        'name': context.tr.tripDetailsRelatedNameSharm,
        'price': '\$499',
        'rating': '4.7',
        'days': '5 Days',
      },
      {
        'name': context.tr.tripDetailsRelatedNameHurghada,
        'price': '\$599',
        'rating': '4.8',
        'days': '6 Days',
      },
      {
        'name': context.tr.tripDetailsRelatedNameLuxorAswan,
        'price': '\$799',
        'rating': '4.9',
        'days': '4 Days',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsRelatedTripsTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: trips.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final trip = trips[index];
              return Container(
                width: 180,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(14),
                      ),
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        color: AppColors.lightBg,
                        child: const Icon(
                          Iconsax.image,
                          color: AppColors.greyText,
                          size: 32,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trip['name']!,
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.star1,
                                color: AppColors.starYellow,
                                size: 14,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                trip['rating']!,
                                style: AppTextStyles.caption(
                                  color: AppColors.darkText,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                trip['days']!,
                                style: AppTextStyles.caption(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            trip['price']!,
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.tr.tripDetailsTotalPrice, style: AppTextStyles.caption()),
                Text(
                  context.tr.tripDetailsPricePerPersonShort('\$699'),
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(context.tr.tripDetailsBookNow, style: AppTextStyles.button()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
