import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../models/company_detail_model.dart';

class CompanyDetailRow extends StatelessWidget {
  const CompanyDetailRow({super.key, required this.model});

  final CompanyDetailModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.label,
                style: AppTextStyles.caption(
                  color: AppColors.secondaryGrey(context),
                ),
              ),
              SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
              Text(
                model.value,
                style: AppTextStyles.bodySmall(
                  color: AppColors.darkText(context),
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        if (model.trailing != null) model.trailing!,
      ],
    );
  }
}
