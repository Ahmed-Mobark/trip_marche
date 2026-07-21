import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../widgets/company_profile_header.dart';
import '../widgets/company_action_buttons.dart';
import '../widgets/company_details_section.dart';
import '../widgets/trip_categories_section.dart';
import '../widgets/team_section.dart';
import '../widgets/customer_reviews_section.dart';
import '../widgets/available_trips_section.dart';
import '../widgets/company_trip_card.dart';
import '../widgets/faq_section.dart';

class CompanyProfileView extends StatefulWidget {
  const CompanyProfileView({super.key});

  @override
  State<CompanyProfileView> createState() => _CompanyProfileViewState();
}

class _CompanyProfileViewState extends State<CompanyProfileView> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            backgroundColor: AppColors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppColors.onImage.withValues(alpha: 0.9),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.darkText(context),
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.searchResultHeaderStart, AppColors.primary],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 14.h),
                CompanyProfileHeader(
                  companyName: context.tr.companyProfileCompanyName,
                  avatarUrl: '',
                  rating: 4.9,
                  reviewsCount: 112,
                  isFollowing: _isFollowing,
                  onFollowToggle: () {
                    setState(() {
                      _isFollowing = !_isFollowing;
                    });
                  },
                ),
                SizedBox(height: 14.h),
                CompanyActionButtons(
                  onCallPressed: () {},
                  onWhatsAppPressed: () {},
                  socialButtons: [
                    SocialButtonData(
                      icon: const Icon(
                        Icons.facebook,
                        color: AppColors.facebookBlue,
                        size: 18,
                      ),
                      iconColor: AppColors.facebookBlue,
                      borderColor: AppColors.socialBorder,
                    ),
                    SocialButtonData(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: AppColors.instagramPink,
                        size: 18,
                      ),
                      iconColor: AppColors.instagramPink,
                      borderColor: AppColors.socialBorder,
                    ),
                    SocialButtonData(
                      icon: const Icon(
                        Icons.music_note,
                        color: AppColors.black,
                        size: 16,
                      ),
                      iconColor: AppColors.black,
                      borderColor: AppColors.socialBorder,
                    ),
                    SocialButtonData(
                      icon: const Icon(
                        Icons.play_circle_filled,
                        color: AppColors.youtubeRed,
                        size: 18,
                      ),
                      iconColor: AppColors.youtubeRed,
                      borderColor: AppColors.socialBorder,
                    ),
                    SocialButtonData(
                      icon: const Icon(
                        Iconsax.global,
                        color: AppColors.websiteBlue,
                        size: 18,
                      ),
                      iconColor: AppColors.websiteBlue,
                      borderColor: AppColors.socialBorder,
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                CompanyDetailsSection(
                  about: context.tr.companyProfileAboutDescription,
                  details: [
                    CompanyDetailData(
                      label: context.tr.companyProfileLocation,
                      value: '18 El Tesen Road, New Cairo, Egypt',
                      trailing: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 36.r,
                          height: 36.r,
                          decoration: BoxDecoration(
                            color: AppColors.mapButtonBg,
                            borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.cardRadius),
                            border: Border.all(color: AppColors.mapButtonBorder),
                          ),
                          child: Icon(
                            Icons.map_outlined,
                            size: CompanyProfileFigmaTokens.mediumIconSize,
                            color: AppColors.mapBlue,
                          ),
                        ),
                      ),
                    ),
                    CompanyDetailData(
                      label: context.tr.companyProfileEmail,
                      value: 'tripmarche@gmail.com',
                    ),
                    CompanyDetailData(
                      label: context.tr.companyProfileYearOfEstablishment,
                      value: '2015',
                    ),
                    CompanyDetailData(
                      label: context.tr.companyProfileCommercialRegistration,
                      value: 'CR123456789',
                    ),
                    CompanyDetailData(
                      label: context.tr.companyProfileBusinessLicense,
                      value: 'BL987654321',
                    ),
                    CompanyDetailData(
                      label: context.tr.companyProfileTaxCard,
                      value: 'TC456789123',
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                TripCategoriesSection(
                  categories: [
                    TripCategoryItemData(
                      icon: const Icon(Iconsax.airplane, size: 20),
                      label: 'International',
                    ),
                    TripCategoryItemData(
                      icon: const Icon(Iconsax.people, size: 20),
                      label: 'Domestic',
                    ),
                    TripCategoryItemData(
                      icon: const Icon(Iconsax.activity, size: 20),
                      label: 'Camping',
                    ),
                    TripCategoryItemData(
                      icon: const Icon(Icons.agriculture, size: 20),
                      label: 'Fishing',
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                TeamSection(
                  members: [
                    TeamMemberData(
                      name: 'John Smith',
                      role: 'CEO',
                      avatarUrl: '',
                    ),
                    TeamMemberData(
                      name: 'Sarah Johnson',
                      role: 'Tour Manager',
                      avatarUrl: '',
                    ),
                    TeamMemberData(
                      name: 'Sarah Johnson',
                      role: 'Tour Manager',
                      avatarUrl: '',
                    ),
                    TeamMemberData(
                      name: 'Sarah Johnson',
                      role: 'Tour Manager',
                      avatarUrl: '',
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                CustomerReviewsSection(
                  reviews: [
                    ReviewData(
                      name: 'Emma Thompson',
                      avatarUrl: '',
                      country: 'Spain',
                      countryFlagUrl: '',
                      rating: 5,
                      comment:
                          'Amazing experience with Wanderlust! The Maldives trip was perfectly organized and the staff was very professional.',
                      galleryImages: ['', '', '', '', ''],
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                AvailableTripsSection(
                  trips: [
                    CompanyTripCardData(
                      title: 'Dahab Trip',
                      imageUrl: '',
                      rating: 4.9,
                      reviewsCount: 112,
                      fromCity: 'From Cairo',
                      dateFrom: '27 Nov',
                      dateTo: '4 Dec',
                      oldPrice: 1000,
                      newPrice: 699,
                      currency: '\$',
                      badge: 'Top Rated',
                      isFavorite: false,
                    ),
                    CompanyTripCardData(
                      title: 'Dahab Trip',
                      imageUrl: '',
                      rating: 4.9,
                      reviewsCount: 112,
                      fromCity: 'From Cairo',
                      dateFrom: '27 Nov',
                      dateTo: '4 Dec',
                      oldPrice: 1000,
                      newPrice: 699,
                      currency: '\$',
                      badge: 'Recommended',
                      isFavorite: false,
                    ),
                    CompanyTripCardData(
                      title: 'Dahab Trip',
                      imageUrl: '',
                      rating: 4.9,
                      reviewsCount: 112,
                      fromCity: 'From Cairo',
                      dateFrom: '27 Nov',
                      dateTo: '4 Dec',
                      oldPrice: 1000,
                      newPrice: 699,
                      currency: '\$',
                      badge: 'Best Price',
                      isFavorite: false,
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                FAQSection(
                  faqs: [
                    FAQData(
                      question: '1. How do I book a trip?',
                      answer:
                          'you can book a trip by selecting your desired destination, choosing your preferred dates and package, then clicking "Book Now" and following the checkout steps.',
                      isExpanded: true,
                    ),
                    FAQData(
                      question: '2. Can I cancel my booking?',
                      answer: '',
                    ),
                    FAQData(
                      question: '5. How do I contact customer support?',
                      answer: '',
                    ),
                    FAQData(question: '4. Are payments secure?', answer: ''),
                  ],
                ),
                SizedBox(height: CompanyProfileFigmaTokens.sectionBottom),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
