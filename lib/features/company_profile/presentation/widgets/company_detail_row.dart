import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';

class CompanyDetailRow extends StatelessWidget {
  const CompanyDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.trailing,
  });

  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.cardPadding, vertical: 12.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.surfaceDivider, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption(color: AppColors.secondaryGrey),
                ),
                SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                Text(
                  value,
                  style: AppTextStyles.bodySmall(color: AppColors.darkText(context)).copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
