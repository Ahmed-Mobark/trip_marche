import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../models/social_button_model.dart';

class CompanyActionButtons extends StatelessWidget {
  const CompanyActionButtons({
    super.key,
    required this.onCallPressed,
    required this.onWhatsAppPressed,
    required this.socialButtons,
    this.onCallEnabled,
    this.onWhatsAppEnabled,
  });

  final VoidCallback? onCallPressed;
  final VoidCallback? onWhatsAppPressed;
  final List<SocialButtonModel> socialButtons;
  final bool? onCallEnabled;
  final bool? onWhatsAppEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CompanyProfileFigmaTokens.screenPadding,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Iconsax.call,
                  label: context.tr.csCall,
                  onPressed: onCallPressed,
                  iconColor: AppColors.primary,
                  textColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  fillColor: AppColors.transparent,
                  enabled: onCallEnabled ?? onCallPressed != null,
                ),
              ),
              SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
              Expanded(
                child: _ActionButton(
                  icon: Iconsax.message_circle,
                  label: context.tr.csWhatsApp,
                  onPressed: onWhatsAppPressed,
                  iconColor: AppColors.white,
                  textColor: AppColors.white,
                  borderColor: AppColors.whatsAppGreen,
                  fillColor: AppColors.whatsAppGreen,
                  enabled: onWhatsAppEnabled ?? onWhatsAppPressed != null,
                ),
              ),
            ],
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          Row(
            children: [
              ...List.generate(
                socialButtons.isEmpty ? 0 : socialButtons.length * 2 - 1,
                (index) {
                  if (index.isOdd) {
                    return SizedBox(
                      width: CompanyProfileFigmaTokens.rowGapMedium,
                    );
                  }
                  final buttonIndex = index ~/ 2;
                  return _SocialIconButton(data: socialButtons[buttonIndex]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.textColor,
    required this.borderColor,
    required this.fillColor,
    this.onPressed,
    this.enabled = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final Color iconColor;
  final Color textColor;
  final Color borderColor;
  final Color fillColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: AnimatedOpacity(
        opacity: enabled ? 1.0 : 0.5,
        duration: const Duration(milliseconds: 200),
        child: Container(
          height: CompanyProfileFigmaTokens.actionButtonHeight,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(
              CompanyProfileFigmaTokens.actionButtonRadius,
            ),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: CompanyProfileFigmaTokens.largeIconSize,
                color: iconColor,
              ),
              SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
              Text(
                label,
                style: AppTextStyles.button(
                  color: textColor,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  const _SocialIconButton({required this.data});

  final SocialButtonModel data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: CompanyProfileFigmaTokens.socialIconButtonHeight,
        decoration: BoxDecoration(
          color: AppColors.background(context),
          borderRadius: BorderRadius.circular(
            CompanyProfileFigmaTokens.socialIconButtonRadius,
          ),
          border: Border.all(color: AppColors.socialBorder(context)),
        ),
        child: Center(child: data.icon),
      ),
    );
  }
}
