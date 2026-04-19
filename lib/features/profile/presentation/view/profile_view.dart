import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/profile/presentation/widgets/menu_item.dart';
import 'package:trip_marche/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:trip_marche/features/profile/presentation/view/personal_info_view.dart';
import 'package:trip_marche/features/profile/presentation/view/my_reviews_view.dart';
import 'package:trip_marche/features/profile/presentation/view/my_followings_view.dart';
import 'package:trip_marche/features/settings/presentation/view/settings_view.dart';
import 'package:trip_marche/features/settings/presentation/view/customer_service_view.dart';
import 'package:trip_marche/features/settings/presentation/view/faqs_view.dart';
import 'package:trip_marche/features/settings/presentation/view/terms_view.dart';
import 'package:trip_marche/core/extensions/localization.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Avatar
              ProfileAvatar(
                radius: 40,
                editIcon: Iconsax.edit_2,
                editButtonSize: 28,
                editIconSize: 14,
                onEditTap: () {},
              ),
              const SizedBox(height: 12),
              Text(
                'Abdallah Ibrahim',
                style: AppTextStyles.heading3(),
              ),
              const SizedBox(height: 4),
              Text(
                'abdallah@gmail.com',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '14 Trips booked',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 24),

              // Account Section
              _buildSectionHeader(context.tr.profileTitleAccount),
              ProfileMenuItem(
                icon: Iconsax.user,
                title: context.tr.profilePersonalInfo,
                onTap: () {
                  sl<AppNavigator>().push(screen: const PersonalInfoView());
                },
              ),
              _buildDivider(),
              ProfileMenuItem(
                icon: Iconsax.card,
                title: context.tr.profilePaymentMethod,
                onTap: () {},
              ),
              _buildDivider(),
              ProfileMenuItem(
                icon: Iconsax.star,
                title: context.tr.profileMyReviews,
                onTap: () {
                  sl<AppNavigator>().push(screen: const MyReviewsView());
                },
              ),
              _buildDivider(),
              ProfileMenuItem(
                icon: Iconsax.building,
                title: context.tr.profileFollowingCompanies,
                onTap: () {
                  sl<AppNavigator>().push(screen: const MyFollowingsView());
                },
              ),
              const SizedBox(height: 16),

              // Settings
              ProfileMenuItem(
                icon: Iconsax.setting_2,
                title: context.tr.profileSettings,
                onTap: () {
                  sl<AppNavigator>().push(screen: const SettingsView());
                },
              ),
              const SizedBox(height: 16),

              // Support Section
              _buildSectionHeader(context.tr.profileTitleSupport),
              ProfileMenuItem(
                icon: Iconsax.headphone,
                title: context.tr.profileCustomerService,
                onTap: () {
                  sl<AppNavigator>().push(screen: const CustomerServiceView());
                },
              ),
              _buildDivider(),
              ProfileMenuItem(
                icon: Iconsax.message_question,
                title: context.tr.profileFaqs,
                onTap: () {
                  sl<AppNavigator>().push(screen: const FaqsView());
                },
              ),
              _buildDivider(),
              ProfileMenuItem(
                icon: Iconsax.document_text,
                title: context.tr.profileTermsAndConditions,
                onTap: () {
                  sl<AppNavigator>().push(screen: const TermsView());
                },
              ),
              const SizedBox(height: 16),

              // Delete Account
              ProfileMenuItem(
                icon: Iconsax.trash,
                title: context.tr.profileDeleteAccount,
                titleColor: AppColors.error,
                iconColor: AppColors.error,
                showChevron: false,
                onTap: () {
                  _showDeleteAccountDialog(context);
                },
              ),
              const SizedBox(height: 24),

              // Log Out Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Log Out',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.greyText,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 1, color: AppColors.border),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Account',
          style: AppTextStyles.subtitle(),
        ),
        content: Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: AppTextStyles.body(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: AppColors.greyText),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: GoogleFonts.inter(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Log Out',
          style: AppTextStyles.subtitle(),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: AppTextStyles.body(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: AppColors.greyText),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Log Out',
              style: GoogleFonts.inter(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
