import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/notifications/presentation/widgets/notification_item.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  static final List<Map<String, dynamic>> _notifications = [
    {
      'group': 'Today',
      'items': [
        {
          'icon': Iconsax.ticket,
          'title': 'Booking Confirmed',
          'description':
              'Your booking for Sharm El Sheikh Adventure has been confirmed.',
          'time': '2h ago',
        },
        {
          'icon': Iconsax.discount_shape,
          'title': 'Special Offer',
          'description':
              'Get 20% off on your next trip! Use code TRIP20 at checkout.',
          'time': '5h ago',
        },
      ],
    },
    {
      'group': 'Yesterday',
      'items': [
        {
          'icon': Iconsax.star,
          'title': 'Rate Your Trip',
          'description':
              'How was your Luxor Historical Tour? Leave a review to help others.',
          'time': '1d ago',
        },
        {
          'icon': Iconsax.notification,
          'title': 'Price Drop Alert',
          'description':
              'The price for Alexandria Beach Trip has dropped by 15%!',
          'time': '1d ago',
        },
      ],
    },
    {
      'group': 'Earlier',
      'items': [
        {
          'icon': Iconsax.message_text,
          'title': 'New Message',
          'description':
              'Travel Egypt Co. has sent you a message about your upcoming trip.',
          'time': '3d ago',
        },
        {
          'icon': Iconsax.info_circle,
          'title': 'Trip Update',
          'description':
              'Your trip schedule for Red Sea Diving has been updated. Check the details.',
          'time': '5d ago',
        },
      ],
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
          'Notification',
          style: AppTextStyles.subtitle(),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: Text(
              'Mark all read',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _notifications.length,
        itemBuilder: (context, groupIndex) {
          final group = _notifications[groupIndex];
          final items = group['items'] as List<Map<String, dynamic>>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  group['group'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.greyText,
                  ),
                ),
              ),
              // Items
              ...items.map((item) => NotificationItem(
                    icon: item['icon'] as IconData,
                    title: item['title'] as String,
                    description: item['description'] as String,
                    timestamp: item['time'] as String,
                    onTap: () {
                      // Handle notification tap
                    },
                  )),
            ],
          );
        },
      ),
    );
  }
}
