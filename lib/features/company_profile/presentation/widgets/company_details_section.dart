import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../models/company_detail_model.dart';
import 'company_detail_row.dart';
import 'profile_section_title.dart';

class CompanyDetailsSection extends StatelessWidget {
  const CompanyDetailsSection({
    super.key,
    required this.about,
    required this.details,
  });

  final String about;
  final List<CompanyDetailModel> details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSectionTitle(title: context.tr.companyProfileCompanyDetails),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          Container(
            padding: EdgeInsets.all(CompanyProfileFigmaTokens.cardPadding),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.surfaceDivider(context)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.companyProfileAbout,
                  style: AppTextStyles.caption(color: AppColors.secondaryGrey(context)).copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                Text(
                  about,
                  style: AppTextStyles.bodySmall(color: AppColors.darkInk(context)).copyWith(height: 1.5),
                ),
                SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
                ...details.map((detail) => CompanyDetailRow(model: detail)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
