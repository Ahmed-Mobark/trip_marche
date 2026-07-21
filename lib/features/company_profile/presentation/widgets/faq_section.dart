import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';

class FAQItem extends StatefulWidget {
  const FAQItem({
    super.key,
    required this.faq,
  });

  final FAQData faq;

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
          border: Border.all(color: AppColors.faqBorder),
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
                      style: AppTextStyles.bodySmall(color: AppColors.darkInk).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: CompanyProfileFigmaTokens.largeIconSize,
                      color: AppColors.secondaryGrey,
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
                    style: AppTextStyles.bodySmall(color: AppColors.secondaryGrey).copyWith(height: 1.5),
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

  final List<FAQData> faqs;

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
              context.tr.profileFaqs,
              style: AppTextStyles.heading3(
                color: AppColors.darkText(context),
              ).copyWith(fontSize: CompanyProfileFigmaTokens.titleFontSize, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: faqs.length,
            separatorBuilder: (_, __) => SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
            itemBuilder: (context, index) {
              final faq = faqs[index];
              return FAQItem(faq: faq);
            },
          ),
          SizedBox(height: CompanyProfileFigmaTokens.cardPadding),
        ],
      ),
    );
  }
}

class FAQData {
  const FAQData({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  final String question;
  final String answer;
  final bool isExpanded;
}
