import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSettingsView extends StatefulWidget {
  const NotificationSettingsView({super.key});

  @override
  State<NotificationSettingsView> createState() =>
      _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<NotificationSettingsView> {
  bool _bookingUpdates = true;
  bool _tours = true;
  bool _reviews = true;
  bool _promotions = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkText,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.notificationSettingsTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(top: 6.h, bottom: 18.h),
              child: Text(
                context.tr.notificationSettingsIntro,
                style: AppTextStyles.bodySmall(color: AppColors.greyText),
              ),
            ),
            _ToggleTile(
              title: context.tr.notificationSettingsBookingUpdatesTitle,
              subtitle: context.tr.notificationSettingsBookingUpdatesSubtitle,
              value: _bookingUpdates,
              onChanged: (v) => setState(() => _bookingUpdates = v),
            ),
            _DividerLine(),
            _ToggleTile(
              title: context.tr.notificationSettingsToursTitle,
              subtitle: context.tr.notificationSettingsToursSubtitle,
              value: _tours,
              onChanged: (v) => setState(() => _tours = v),
            ),
            _DividerLine(),
            _ToggleTile(
              title: context.tr.notificationSettingsReviewsTitle,
              subtitle: context.tr.notificationSettingsReviewsSubtitle,
              value: _reviews,
              onChanged: (v) => setState(() => _reviews = v),
            ),
            _DividerLine(),
            _ToggleTile(
              title: context.tr.notificationSettingsPromotions,
              subtitle: context.tr.notificationSettingsPromotionsSubtitle,
              value: _promotions,
              onChanged: (v) => setState(() => _promotions = v),
            ),
            _DividerLine(),
          ],
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium(color: AppColors.darkText)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall(color: AppColors.greyText),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.border,
            thumbColor: WidgetStateProperty.resolveWith<Color>(
              (_) => AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 1.h, color: AppColors.border);
  }
}
