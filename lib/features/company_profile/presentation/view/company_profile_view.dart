import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/features/my_trips/presentation/my_trips_figma_tokens.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../models/social_button_model.dart';
import '../models/company_detail_model.dart';
import '../models/trip_category_model.dart';
import '../models/team_member_model.dart';
import '../models/review_model.dart';
import '../models/trip_card_model.dart';
import '../models/faq_model.dart';
import '../widgets/company_profile_header.dart';
import '../widgets/company_action_buttons.dart';
import '../widgets/company_details_section.dart';
import '../widgets/trip_categories_section.dart';
import '../widgets/team_section.dart';
import '../widgets/customer_reviews_section.dart';
import '../widgets/available_trips_section.dart';
import '../widgets/faq_section.dart';

class CompanyProfileView extends StatefulWidget {
  const CompanyProfileView({super.key});

  @override
  State<CompanyProfileView> createState() => _CompanyProfileViewState();
}

class _CompanyProfileViewState extends State<CompanyProfileView> {
  bool _isFollowing = false;

  List<SocialButtonModel> _buildSocialButtons(BuildContext context) => [
    SocialButtonModel(
      icon: FaIcon(FontAwesomeIcons.facebook, size: 18),
      iconColor: AppColors.facebookBlue,
      borderColor: AppColors.socialBorder(context),
    ),
    SocialButtonModel(
      icon: FaIcon(FontAwesomeIcons.instagram, size: 18),
      iconColor: AppColors.instagramPink,
      borderColor: AppColors.socialBorder(context),
    ),
    SocialButtonModel(
      icon: FaIcon(FontAwesomeIcons.tiktok, size: 16),
      iconColor: AppColors.darkText(context),
      borderColor: AppColors.socialBorder(context),
    ),
    SocialButtonModel(
      icon: FaIcon(FontAwesomeIcons.youtube, size: 18),
      iconColor: AppColors.youtubeRed,
      borderColor: AppColors.socialBorder(context),
    ),
    SocialButtonModel(
      icon: FaIcon(FontAwesomeIcons.globe, size: 18),
      iconColor: AppColors.websiteBlue,
      borderColor: AppColors.socialBorder(context),
    ),
  ];

  List<CompanyDetailModel> _buildCompanyDetails(BuildContext context) => [
    CompanyDetailModel(
      label: context.tr.companyProfileLocation,
      value: '18 El Tesen Road, New Cairo, Egypt',
      trailing: GestureDetector(
        onTap: () {},
        child: Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: AppColors.mapButtonBg(context),
            borderRadius: BorderRadius.circular(
              CompanyProfileFigmaTokens.cardRadius,
            ),
            border: Border.all(color: AppColors.mapButtonBorder(context)),
          ),
          child: Icon(
            Icons.map_outlined,
            size: CompanyProfileFigmaTokens.mediumIconSize,
            color: AppColors.mapBlue,
          ),
        ),
      ),
    ),
    CompanyDetailModel(
      label: context.tr.companyProfileEmail,
      value: 'tripmarche@gmail.com',
    ),
    CompanyDetailModel(
      label: context.tr.companyProfileYearOfEstablishment,
      value: '2015',
    ),
    CompanyDetailModel(
      label: context.tr.companyProfileCommercialRegistration,
      value: 'CR123456789',
    ),
    CompanyDetailModel(
      label: context.tr.companyProfileBusinessLicense,
      value: 'BL987654321',
    ),
    CompanyDetailModel(
      label: context.tr.companyProfileTaxCard,
      value: 'TC456789123',
    ),
  ];

  static const _tripCategories = [
    TripCategoryModel(icon: Icon(Iconsax.airplane, size: 20), label: 'International'),
    TripCategoryModel(icon: Icon(Iconsax.people, size: 20), label: 'Domestic'),
    TripCategoryModel(icon: Icon(Iconsax.activity, size: 20), label: 'Camping'),
    TripCategoryModel(icon: Icon(Icons.agriculture, size: 20), label: 'Fishing'),
  ];

  static const _teamMembers = [
    TeamMemberModel(name: 'John Smith', role: 'CEO', avatarUrl: ''),
    TeamMemberModel(name: 'Sarah Johnson', role: 'Tour Manager', avatarUrl: ''),
    TeamMemberModel(name: 'Sarah Johnson', role: 'Tour Manager', avatarUrl: ''),
    TeamMemberModel(name: 'Sarah Johnson', role: 'Tour Manager', avatarUrl: ''),
  ];

  static const _reviews = [
    ReviewModel(
      name: 'Emma Thompson',
      avatarUrl: '',
      country: 'Spain',
      countryFlagUrl: '',
      rating: 5,
      comment:
      'Amazing experience with Wanderlust! The Maldives trip was perfectly organized and the staff was very professional.',
      galleryImages: ['', '', '', '', ''],
    ),
  ];

  static const _trips = [
    TripCardModel(
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
    TripCardModel(
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
    TripCardModel(
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
  ];

  static const _faqs = [
    FAQModel(
      question: '1. How do I book a trip?',
      answer:
      'you can book a trip by selecting your desired destination, choosing your preferred dates and package, then clicking "Book Now" and following the checkout steps.',
      isExpanded: true,
    ),
    FAQModel(question: '2. Can I cancel my booking?', answer: ''),
    FAQModel(question: '5. How do I contact customer support?', answer: ''),
    FAQModel(question: '4. Are payments secure?', answer: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(gradient: AppColors.primaryGradient),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: MyTripsFigmaTokens.padH,
                      end: MyTripsFigmaTokens.padH,
                      top: MyTripsFigmaTokens.headerPadTop,
                      bottom: MyTripsFigmaTokens.headerPadBottom,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.onImage,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            context.tr.companyProfileTitle,
                            style:
                            AppTextStyles.heading2(
                              color: AppColors.onImage,
                            ).copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBg(context),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(MyTripsFigmaTokens.sheetTopRadius),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: Offset(0, -24.h),
                        child: CompanyProfileHeader(
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
                      ),
                      SizedBox(height: 14.h),
                      CompanyActionButtons(
                        onCallPressed: () {},
                        onWhatsAppPressed: () {},
                        socialButtons: _buildSocialButtons(context),
                      ),
                      SizedBox(height: 14.h),
                      CompanyDetailsSection(
                        about: context.tr.companyProfileAboutDescription,
                        details: _buildCompanyDetails(context),
                      ),
                      SizedBox(height: 14.h),
                      TripCategoriesSection(categories: _tripCategories),
                      SizedBox(height: 14.h),
                      TeamSection(members: _teamMembers),
                      SizedBox(height: 14.h),
                      CustomerReviewsSection(reviews: _reviews),
                      SizedBox(height: 14.h),
                      AvailableTripsSection(trips: _trips),
                      SizedBox(height: 14.h),
                      FAQSection(faqs: _faqs),
                      SizedBox(height: CompanyProfileFigmaTokens.sectionBottom),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
