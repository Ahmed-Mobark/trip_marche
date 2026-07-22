import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../models/trip_category_model.dart';
import 'profile_section_title.dart';

class TripCategoryItem extends StatelessWidget {
  const TripCategoryItem({
    super.key,
    required this.category,
  });

  final TripCategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CompanyProfileFigmaTokens.categoryItemWidth,
      height: CompanyProfileFigmaTokens.categoryItemHeight,
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.cardRadiusLarge),
        border: Border.all(color: AppColors.cardBorder(context)),
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

  final List<TripCategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSectionTitle(title: context.tr.companyProfileTripCategories),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          SizedBox(
            height: CompanyProfileFigmaTokens.categoryItemHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
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
