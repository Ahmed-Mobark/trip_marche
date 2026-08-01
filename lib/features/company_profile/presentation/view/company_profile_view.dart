import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/features/my_trips/presentation/my_trips_figma_tokens.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/toast/app_toast.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../models/social_button_model.dart';
import '../models/company_detail_model.dart';
import '../models/trip_category_model.dart';
import '../models/team_member_model.dart';
import '../models/review_model.dart';
import '../models/trip_card_model.dart';
import '../models/faq_model.dart';
import '../cubit/vendor_profile_cubit.dart';
import '../cubit/vendor_profile_state.dart';
import '../../data/models/vendor_profile_model.dart';
import '../widgets/company_profile_header.dart';
import '../widgets/company_action_buttons.dart';
import '../widgets/company_details_section.dart';
import '../widgets/trip_categories_section.dart';
import '../widgets/team_section.dart';
import '../widgets/customer_reviews_section.dart';
import '../widgets/available_trips_section.dart';
import '../widgets/faq_section.dart';

class CompanyProfileView extends StatefulWidget {
  const CompanyProfileView({super.key, required this.vendorId});
  final int vendorId;

  @override
  State<CompanyProfileView> createState() => _CompanyProfileViewState();
}

class _CompanyProfileViewState extends State<CompanyProfileView> {
  late final VendorProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<VendorProfileCubit>();
    if (widget.vendorId > 0) {
      _cubit.loadVendorProfile(widget.vendorId);
    }
  }

  List<SocialButtonModel> _buildSocialButtons(
    BuildContext context,
    VendorProfileModel profile,
  ) {
    final social = profile.social;
    final buttons = <SocialButtonModel>[];

    Future<void> launch(String? url) async {
      if (url == null || url.isEmpty) return;
      final uri = Uri.tryParse(url);
      if (uri == null || !uri.hasScheme) return;
      if (!mounted) return;
      try {
        if (await canLaunchUrl(uri)) {
          launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } catch (_) {}
    }

    if (social.website != null && social.website!.isNotEmpty) {
      buttons.add(
        SocialButtonModel(
          icon: const FaIcon(FontAwesomeIcons.globe, size: 18),
          iconColor: AppColors.websiteBlue,
          borderColor: AppColors.socialBorder(context),
          onTap: () => launch(social.website),
        ),
      );
    }
    if (social.facebook != null && social.facebook!.isNotEmpty) {
      buttons.add(
        SocialButtonModel(
          icon: const FaIcon(FontAwesomeIcons.facebook, size: 18),
          iconColor: AppColors.facebookBlue,
          borderColor: AppColors.socialBorder(context),
          onTap: () => launch(social.facebook),
        ),
      );
    }
    if (social.instagram != null && social.instagram!.isNotEmpty) {
      buttons.add(
        SocialButtonModel(
          icon: const FaIcon(FontAwesomeIcons.instagram, size: 18),
          iconColor: AppColors.instagramPink,
          borderColor: AppColors.socialBorder(context),
          onTap: () => launch(social.instagram),
        ),
      );
    }
    if (social.tiktok != null && social.tiktok!.isNotEmpty) {
      buttons.add(
        SocialButtonModel(
          icon: const FaIcon(FontAwesomeIcons.tiktok, size: 18),
          iconColor: AppColors.darkText(context),
          borderColor: AppColors.socialBorder(context),
          onTap: () => launch(social.tiktok),
        ),
      );
    }
    if (social.youtube != null && social.youtube!.isNotEmpty) {
      buttons.add(
        SocialButtonModel(
          icon: const FaIcon(FontAwesomeIcons.youtube, size: 18),
          iconColor: AppColors.youtubeRed,
          borderColor: AppColors.socialBorder(context),
          onTap: () => launch(social.youtube),
        ),
      );
    }

    return buttons;
  }

  List<CompanyDetailModel> _buildCompanyDetails(
    BuildContext context,
    VendorProfileModel profile,
  ) {
    final details = profile.companyDetails;
    final contact = profile.contact;
    final lat = details.locationLat;
    final lng = details.locationLng;
    final canOpenMap = lat != null && lng != null;
    final rows = <CompanyDetailModel>[];

    final location = details.location;
    if ((location != null && location.trim().isNotEmpty) || canOpenMap) {
      rows.add(
        CompanyDetailModel(
          label: context.tr.companyProfileLocation,
          value: details.location ?? '',
          trailing: GestureDetector(
            onTap: canOpenMap
                ? () async {
                    final uri = Uri.parse(
                      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
                    );
                    if (await canLaunchUrl(uri)) {
                      launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  }
                : null,
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
              child: Center(
                child: AppIcons.icon(icon: AppIcons.googleMapsIcon, size: 20),
              ),
            ),
          ),
        ),
      );
    }

    if (contact.email != null && contact.email!.isNotEmpty) {
      rows.add(
        CompanyDetailModel(
          label: context.tr.companyProfileEmail,
          value: contact.email!,
        ),
      );
    }
    if (details.yearEstablished != null &&
        details.yearEstablished!.isNotEmpty) {
      rows.add(
        CompanyDetailModel(
          label: context.tr.companyProfileYearOfEstablishment,
          value: details.yearEstablished!,
        ),
      );
    }
    if (details.commercialRegistration != null &&
        details.commercialRegistration!.isNotEmpty) {
      rows.add(
        CompanyDetailModel(
          label: context.tr.companyProfileCommercialRegistration,
          value: details.commercialRegistration!,
        ),
      );
    }
    if (details.businessLicense != null &&
        details.businessLicense!.isNotEmpty) {
      rows.add(
        CompanyDetailModel(
          label: context.tr.companyProfileBusinessLicense,
          value: details.businessLicense!,
        ),
      );
    }
    if (details.taxCard != null && details.taxCard!.isNotEmpty) {
      rows.add(
        CompanyDetailModel(
          label: context.tr.companyProfileTaxCard,
          value: details.taxCard!,
        ),
      );
    }
    return rows;
  }

  List<TripCategoryModel> _buildCategories(VendorProfileModel profile) {
    return profile.categories.map((c) {
      final normalized = c.name.toLowerCase();
      Widget icon;
      if (normalized.contains('international')) {
        icon = Icon(Iconsax.airplane, size: 20);
      } else if (normalized.contains('domestic')) {
        icon = Icon(Iconsax.people, size: 20);
      } else if (normalized.contains('camping')) {
        icon = Icon(Iconsax.activity, size: 20);
      } else if (normalized.contains('fish')) {
        icon = Icon(Icons.agriculture, size: 20);
      } else {
        icon = Icon(Iconsax.airplane, size: 20);
      }
      return TripCategoryModel(icon: icon, label: c.name);
    }).toList();
  }

  Widget _buildErrorScreen(BuildContext context, String message) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16.h),
              FilledButton(
                onPressed: () => _cubit.loadVendorProfile(widget.vendorId),
                child: Text(context.tr.tripDetailsTryAgain),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocListener<VendorProfileCubit, VendorProfileState>(
        listenWhen: (previous, current) =>
            current is VendorProfileError && previous is VendorProfileSuccess,
        listener: (context, state) {
          if (state is VendorProfileError) {
            appToast(
              context: context,
              type: ToastType.error,
              message: state.message,
            );
          }
        },
        child: BlocBuilder<VendorProfileCubit, VendorProfileState>(
          buildWhen: (previous, current) {
            if (current is VendorProfileLoading) return true;
            if (current is VendorProfileError) return true;
            if (current is VendorProfileSuccess) return true;
            return false;
          },
          builder: (context, state) {
            if (state is VendorProfileLoading) {
              return const Scaffold(
                body: Center(
                  child: CustomLoading(top: 40, bottom: 40),
                ),
              );
            }

            if (state is VendorProfileError) {
              return _buildErrorScreen(context, state.message);
            }

            if (state is VendorProfileSuccess) {
              final profile = state.profile;
              final vendor = profile.vendor;
              final contact = profile.contact;
              final companyDetails = profile.companyDetails;
              final categories = _buildCategories(profile);
              final detailsList = _buildCompanyDetails(context, profile);
              final team = profile.team;
              final reviews = profile.reviews;
              final trips = profile.availableTrips;
              final faqs = profile.faqs;

              final phone = contact.phone ?? '';
              final whatsapp = contact.whatsapp ?? '';

              return Scaffold(
                backgroundColor: AppColors.primary,
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                      ),
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
                                top: Radius.circular(
                                  MyTripsFigmaTokens.sheetTopRadius,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.translate(
                                  offset: Offset(0, -24.h),
                                  child: CompanyProfileHeader(
                                    companyName: vendor.name,
                                    avatarUrl: vendor.avatar ?? '',
                                    rating: vendor.rating ?? 0.0,
                                    reviewsCount: vendor.reviewsCount ?? 0,
                                    isFollowing: _cubit.isFollowing(
                                      widget.vendorId,
                                    ),
                                    onFollowToggle: () {
                                      _cubit.toggleFollow(widget.vendorId);
                                    },
                                    followersCount: vendor.followersCount,
                                    tripsCount: vendor.tripsCount,
                                    isVerified: vendor.isVerified,
                                  ),
                                ),
                                SizedBox(height: 14.h),
                                CompanyActionButtons(
                                  onCallPressed: phone.isNotEmpty
                                      ? () async {
                                          final uri = Uri.parse('tel:$phone');
                                          if (await canLaunchUrl(uri)) {
                                            await launchUrl(uri);
                                          } else if (mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  context.tr.somethingWentWrong,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      : null,
                                  onWhatsAppPressed: whatsapp.isNotEmpty
                                      ? () async {
                                          final sanitized = whatsapp.replaceAll(
                                            RegExp(r'[\s\-\+]'),
                                            '',
                                          );
                                          final uri = Uri.parse(
                                            'https://wa.me/$sanitized',
                                          );

                                          bool launched = false;
                                          if (await canLaunchUrl(uri)) {
                                            launched = await launchUrl(
                                              uri,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }

                                          if (!launched && mounted) {
                                            launched = await launchUrl(
                                              uri,
                                              mode: LaunchMode.platformDefault,
                                            );
                                          }

                                          if (!launched && mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  context.tr.somethingWentWrong,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      : null,
                                  onCallEnabled: phone.isNotEmpty,
                                  onWhatsAppEnabled: whatsapp.isNotEmpty,
                                  socialButtons: _buildSocialButtons(
                                    context,
                                    profile,
                                  ),
                                ),
                                SizedBox(height: 14.h),
                              if ((companyDetails.about ?? '').trim().isNotEmpty ||
                                  detailsList.isNotEmpty) ...[
                                SizedBox(height: 14.h),
                                CompanyDetailsSection(
                                  about: companyDetails.about ?? '',
                                  details: detailsList,
                                ),
                              ],
                              if (categories.isNotEmpty) ...[
                                SizedBox(height: 14.h),
                                TripCategoriesSection(categories: categories),
                              ],
                              if (team.isNotEmpty) ...[
                                SizedBox(height: 14.h),
                                TeamSection(
                                  members: team
                                      .map(
                                        (t) => TeamMemberModel(
                                          name: t.name,
                                          role: t.title,
                                          avatarUrl: t.avatar ?? '',
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                              if (reviews.isNotEmpty) ...[
                                SizedBox(height: 14.h),
                                CustomerReviewsSection(
                                  reviews: reviews
                                      .map(
                                        (r) => ReviewModel(
                                          name: r.reviewer.name,
                                          avatarUrl: r.reviewer.avatar ?? '',
                                          country: r.reviewer.country,
                                          countryFlagUrl:
                                              r.reviewer.countryCode.isNotEmpty
                                              ? 'https://flagcdn.com/40x30/${r.reviewer.countryCode.toLowerCase()}.png'
                                              : '',
                                          rating: r.rating,
                                          comment: r.comment,
                                          galleryImages: r.images,
                                          createdAt: r.createdAt,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                              if (trips.isNotEmpty) ...[
                                SizedBox(height: 14.h),
                                AvailableTripsSection(
                                  trips: trips
                                      .map(
                                        (t) => TripCardModel(
                                          id: t.id,
                                          title: t.title,
                                          imageUrl: t.coverImage,
                                          rating: t.rating,
                                          reviewsCount: t.reviewsCount,
                                          fromCity: t.fromLocation,
                                          dateFrom: t.startDate,
                                          dateTo: t.endDate,
                                          oldPrice: t.discountPrice ?? t.price,
                                          newPrice: t.price,
                                          currency: t.currency,
                                          badge: t.primaryBadge,
                                          isFavorite: t.isWishlisted,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                              if (faqs.isNotEmpty) ...[
                                SizedBox(height: 14.h),
                                FAQSection(
                                  faqs: faqs
                                      .map(
                                        (f) => FAQModel(
                                          question: f.question,
                                          answer: f.answer,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                              SizedBox(
                                height:
                                    CompanyProfileFigmaTokens.sectionBottom,
                              ),
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

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
