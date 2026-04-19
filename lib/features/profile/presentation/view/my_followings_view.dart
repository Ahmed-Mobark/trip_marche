import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/profile/presentation/widgets/company_card.dart';

class MyFollowingsView extends StatefulWidget {
  const MyFollowingsView({super.key});

  @override
  State<MyFollowingsView> createState() => _MyFollowingsViewState();
}

class _MyFollowingsViewState extends State<MyFollowingsView> {
  final List<Map<String, dynamic>> _companies = [
    {
      'name': 'Travel Egypt Co.',
      'logo': 'assets/images/company_placeholder.png',
      'tripCount': 24,
      'isFollowing': true,
    },
    {
      'name': 'Nile Adventures',
      'logo': 'assets/images/company_placeholder.png',
      'tripCount': 18,
      'isFollowing': true,
    },
    {
      'name': 'Desert Safari Tours',
      'logo': 'assets/images/company_placeholder.png',
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
          'My Followings',
          style: AppTextStyles.subtitle(),
        ),
        centerTitle: true,
      ),
      body: _companies.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _companies.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final company = _companies[index];
                return CompanyCard(
                  name: company['name'] as String,
                  logo: company['logo'] as String,
                  tripCount: company['tripCount'] as int,
                  isFollowing: company['isFollowing'] as bool,
                  onTap: () {
                    Navigator.pushNamed(context, '/company-profile');
                  },
                  onFollowTap: () {
                    setState(() {
                      _companies[index]['isFollowing'] =
                          !(company['isFollowing'] as bool);
                    });
                  },
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.building,
            size: 64,
            color: AppColors.greyText.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'No followings yet',
            style: AppTextStyles.subtitle(color: AppColors.greyText),
          ),
          const SizedBox(height: 8),
          Text(
            'Start following companies to see\ntheir trips here.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.greyText,
            ),
          ),
        ],
      ),
    );
  }
}
