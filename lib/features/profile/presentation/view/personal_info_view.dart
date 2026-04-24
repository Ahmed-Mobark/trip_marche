import 'package:flutter/material.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({super.key});

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
          context.tr.profilePersonalInfoTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 10.h),
        child: Column(
          children: [
            _InfoRow(
              label: context.tr.profileFullNameLabel,
              value: 'Abdallah Ibrahim',
              actionText: context.tr.profileEditAction,
              onAction: () {},
            ),
            _DividerLine(),
            _InfoRow(
              label: context.tr.profileEmailLabel,
              value: 'abdalaa2434@gmail.com',
            ),
            _DividerLine(),
            _InfoRow(
              label: context.tr.profilePhoneNumberLabel,
              value: '+20 114398594t',
              actionText: context.tr.profileEditAction,
              onAction: () {},
            ),
            _DividerLine(),
            _InfoRow(
              label: context.tr.profilePasswordLabel,
              value: '***********',
              actionText: context.tr.profileChangePasswordAction,
              onAction: () {},
            ),
            _DividerLine(),
            _InfoRow(
              label: context.tr.profileCountryLabel,
              value: 'Egypt',
            ),
            _DividerLine(),
            _InfoRow(
              label: context.tr.profileCityLabel,
              value: 'Cairo',
            ),
            _DividerLine(),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.actionText,
    this.onAction,
  });

  final String label;
  final String value;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 18.h, bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodyMedium(color: AppColors.darkText)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.h),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium(color: AppColors.greyText),
                ),
              ],
            ),
          ),
          if (actionText != null)
            Padding(
              padding: EdgeInsetsDirectional.only(top: 26.h),
              child: InkWell(
                onTap: onAction,
                child: Text(
                  actionText!,
                  style: AppTextStyles.bodyMedium(color: AppColors.darkText)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
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
