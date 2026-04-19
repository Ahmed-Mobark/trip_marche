import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/company_profile/presentation/view/company_profile_view.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/config/app_images.dart';
import 'package:trip_marche/features/profile/presentation/widgets/followings_empty_state.dart';
import 'package:trip_marche/features/profile/presentation/widgets/followings_list.dart';

class MyFollowingsView extends StatefulWidget {
  const MyFollowingsView({super.key});

  @override
  State<MyFollowingsView> createState() => _MyFollowingsViewState();
}

class _MyFollowingsViewState extends State<MyFollowingsView> {
  final List<Map<String, dynamic>> _companies = [
    {
      'name': 'Travel Egypt Co.',
      'logo': AppImages.companyPlaceholder,
      'tripCount': 24,
      'isFollowing': true,
    },
    {
      'name': 'Nile Adventures',
      'logo': AppImages.companyPlaceholder,
      'tripCount': 18,
      'isFollowing': true,
    },
    {
      'name': 'Desert Safari Tours',
      'logo': AppImages.companyPlaceholder,
      'tripCount': 12,
      'isFollowing': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.followingsTitle,
          style: AppTextStyles.subtitle(),
        ),
        centerTitle: true,
      ),
      body: _companies.isEmpty
          ? const FollowingsEmptyState()
          : FollowingsList(
              companies: _companies,
              onCompanyTap: (index) {
                sl<AppNavigator>().push(
                  screen: const CompanyProfileView(),
                );
              },
              onFollowToggle: (index) {
                setState(() {
                  _companies[index]['isFollowing'] =
                      !(_companies[index]['isFollowing'] as bool);
                });
              },
            ),
    );
  }
}
