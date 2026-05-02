import 'package:flutter/material.dart';
import 'company_card.dart';

class FollowingsList extends StatelessWidget {
  const FollowingsList({
    super.key,
    required this.companies,
    required this.onCompanyTap,
    required this.onFollowToggle,
  });

  final List<Map<String, dynamic>> companies;
  final void Function(int index) onCompanyTap;
  final void Function(int index) onFollowToggle;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: companies.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final company = companies[index];
        return CompanyCard(
          name: company['name'] as String,
          logo: company['logo'] as String,
          tripCount: company['tripCount'] as int,
          isFollowing: company['isFollowing'] as bool,
          onTap: () => onCompanyTap(index),
          onFollowTap: () => onFollowToggle(index),
        );
      },
    );
  }
}
