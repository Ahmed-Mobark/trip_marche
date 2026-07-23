import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';

class ProfileSectionTitle extends StatelessWidget {
  const ProfileSectionTitle({
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
    final titleStyle =
        AppTextStyles.heading3(color: AppColors.darkText(context)).copyWith(
          fontSize: CompanyProfileFigmaTokens.titleFontSize,
          fontWeight: FontWeight.w700,
        );

    final actionStyle = AppTextStyles.bodyMedium(color: AppColors.primary)
        .copyWith(
          fontSize: CompanyProfileFigmaTokens.bodyMediumFontSize,
          fontWeight: FontWeight.w500,
        );

    return Padding(
      padding: EdgeInsets.only(
        top: CompanyProfileFigmaTokens.cardPadding,
        bottom: CompanyProfileFigmaTokens.rowGapMedium,
      ),
      child: actionText != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: titleStyle),
                TextButton(
                  onPressed: onActionTap,
                  child: Text(actionText!, style: actionStyle),
                ),
              ],
            )
          : Text(title, style: titleStyle),
    );
  }
}
