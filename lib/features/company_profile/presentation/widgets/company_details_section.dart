import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import 'company_detail_row.dart';

class CompanyDetailData {
  const CompanyDetailData({
    required this.label,
    required this.value,
    this.trailing,
  });

  final String label;
  final String value;
  final Widget? trailing;
}

class CompanyDetailsSection extends StatelessWidget {
  const CompanyDetailsSection({
    super.key,
    required this.about,
    required this.details,
  });

  final String about;
  final List<CompanyDetailData> details;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPadding),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.cardRadius),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(CompanyProfileFigmaTokens.cardPadding, CompanyProfileFigmaTokens.cardPadding, CompanyProfileFigmaTokens.cardPadding, 0),
            child: Text(
              context.tr.companyProfileCompanyDetails,
              style: AppTextStyles.heading3(
                color: AppColors.darkText(context),
              ).copyWith(fontSize: CompanyProfileFigmaTokens.titleFontSize, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          Container(
            padding: EdgeInsets.all(CompanyProfileFigmaTokens.cardPadding),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.surfaceDivider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.companyProfileAbout,
                  style: AppTextStyles.caption(color: AppColors.secondaryGrey).copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                Text(
                  about,
                  style: AppTextStyles.bodySmall(color: AppColors.darkInk).copyWith(height: 1.5),
                ),
                SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: details.length,
                  itemBuilder: (context, index) {
                    final detail = details[index];
                    return CompanyDetailRow(
                      label: detail.label,
                      value: detail.value,
                      trailing: detail.trailing,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
