import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/booking/presentation/widgets/activity_item.dart';

class _Activity {
  final String name;
  final String description;
  final double price;
  final IconData icon;
  bool isSelected = false;

  _Activity({
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });
}

class SelectActivitiesView extends StatefulWidget {
  const SelectActivitiesView({super.key});

  @override
  State<SelectActivitiesView> createState() => _SelectActivitiesViewState();
}

class _SelectActivitiesViewState extends State<SelectActivitiesView> {
  final List<_Activity> _activities = [
    _Activity(
      name: 'Snorkeling',
      description: 'Explore the coral reefs at Blue Hole',
      price: 50,
      icon: Iconsax.ship,
    ),
    _Activity(
      name: 'Desert Safari',
      description: 'Jeep tour through the Sinai desert',
      price: 80,
      icon: Iconsax.sun_1,
    ),
    _Activity(
      name: 'Camel Ride',
      description: 'Sunset camel ride along the coast',
      price: 35,
      icon: Iconsax.routing,
    ),
    _Activity(
      name: 'Scuba Diving',
      description: 'Professional diving with certified instructor',
      price: 120,
      icon: Iconsax.bubble,
    ),
    _Activity(
      name: 'Quad Biking',
      description: 'ATV adventure in the desert dunes',
      price: 65,
      icon: Iconsax.driving,
    ),
    _Activity(
      name: 'Rock Climbing',
      description: 'Guided climbing in Sinai mountains',
      price: 90,
      icon: Iconsax.hierarchy_3,
    ),
    _Activity(
      name: 'Yoga Session',
      description: 'Morning yoga on the beach',
      price: 25,
      icon: Iconsax.health,
    ),
    _Activity(
      name: 'Photography Tour',
      description: 'Guided photo tour of scenic spots',
      price: 45,
      icon: Iconsax.camera,
    ),
  ];

  double get _totalActivitiesPrice {
    return _activities
        .where((a) => a.isSelected)
        .fold(0.0, (sum, a) => sum + a.price);
  }

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
        title: Text('Select Activities', style: AppTextStyles.subtitle(color: AppColors.darkText)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _activities.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return ActivityItem(
                  icon: activity.icon,
                  name: activity.name,
                  description: activity.description,
                  price: activity.price,
                  isSelected: activity.isSelected,
                  onTap: () => setState(() => activity.isSelected = !activity.isSelected),
                );
              },
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
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
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Activities Total', style: AppTextStyles.bodyMedium(color: AppColors.greyText)),
              Text(
                '+\$${_totalActivitiesPrice.toStringAsFixed(0)}',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text('Continue', style: AppTextStyles.button()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
