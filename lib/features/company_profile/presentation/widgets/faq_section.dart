import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../models/faq_model.dart';
import 'profile_section_title.dart';

class FAQItem extends StatefulWidget {
  const FAQItem({
    super.key,
    required this.faq,
  });

  final FAQModel faq;

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.faq.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: AppColors.background(context),
          borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.faqRadius),
          border: Border.all(color: AppColors.faqBorder(context)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.faqPadding, vertical: CompanyProfileFigmaTokens.faqPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.faq.question,
                      style: AppTextStyles.bodySmall(color: AppColors.darkInk(context)).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: CompanyProfileFigmaTokens.largeIconSize,
                      color: AppColors.secondaryGrey(context),
                    ),
                  ),
                ],
              ),
            ),
            if (_isExpanded)
              Padding(
                padding: EdgeInsets.fromLTRB(CompanyProfileFigmaTokens.faqPadding, 0, CompanyProfileFigmaTokens.faqPadding, CompanyProfileFigmaTokens.faqPadding),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.faq.answer,
                    style: AppTextStyles.bodySmall(color: AppColors.secondaryGrey(context)).copyWith(height: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FAQSection extends StatelessWidget {
  const FAQSection({super.key, required this.faqs});

  final List<FAQModel> faqs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSectionTitle(title: context.tr.profileFaqs),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          ...faqs.map((faq) => FAQItem(faq: faq)),
          SizedBox(height: CompanyProfileFigmaTokens.cardPadding),
        ],
      ),
    );
  }
}
