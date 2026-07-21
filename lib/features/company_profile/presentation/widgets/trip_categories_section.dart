import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';

class TripCategoryItem extends StatelessWidget {
  const TripCategoryItem({
    super.key,
    required this.category,
  });

  final TripCategoryItemData category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CompanyProfileFigmaTokens.categoryItemWidth,
      height: CompanyProfileFigmaTokens.categoryItemHeight,
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.cardRadiusLarge),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(color: AppColors.primary, size: CompanyProfileFigmaTokens.largeIconSize),
            child: category.icon,
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
          Text(
            category.label,
            style: AppTextStyles.caption(color: AppColors.darkText(context)).copyWith(fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class TripCategoriesSection extends StatelessWidget {
  const TripCategoriesSection({super.key, required this.categories});

  final List<TripCategoryItemData> categories;

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
            padding: EdgeInsets.fromLTRB(CompanyProfileFigmaTokens.screenPaddingSmall, CompanyProfileFigmaTokens.cardPadding, CompanyProfileFigmaTokens.screenPaddingSmall, 0),
            child: Text(
              context.tr.companyProfileTripCategories,
              style: AppTextStyles.heading3(
                color: AppColors.darkText(context),
              ).copyWith(fontSize: CompanyProfileFigmaTokens.titleFontSize, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          SizedBox(
            height: CompanyProfileFigmaTokens.categoryItemHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPaddingSmall),
              itemCount: categories.length,
              separatorBuilder: (_, __) => SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
              itemBuilder: (context, index) {
                final category = categories[index];
                return TripCategoryItem(category: category);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TripCategoryItemData {
  const TripCategoryItemData({required this.icon, required this.label});

  final Widget icon;
  final String label;
}
