import 'package:flutter/material.dart';

import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/styles/styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.heading3(color: AppColors.darkText),
            ),
          ),
          if (actionText != null)
            InkWell(
              onTap: onActionTap,
              child: Text(
                actionText!,
                style: AppTextStyles.bodySmall(color: AppColors.primaryDark),
              ),
            ),
        ],
      ),
    );
  }
}

