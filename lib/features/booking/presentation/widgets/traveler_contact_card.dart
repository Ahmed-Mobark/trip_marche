import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/contact_info_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_phone_number_field.dart';

class TravelerContactCard extends StatelessWidget {
  const TravelerContactCard({
    super.key,
    required this.travelerTitle,
    required this.fullNameLabel,
    required this.fullNameHint,
    required this.phoneLabel,
    required this.phoneHint,
    required this.nameController,
    required this.phoneController,
    required this.countryCode,
    required this.onCountryCodeChanged,
    required this.requiredErrorText,
    this.autovalidateMode,
  });

  final String travelerTitle;
  final String fullNameLabel;
  final String fullNameHint;
  final String phoneLabel;
  final String phoneHint;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final String countryCode;
  final ValueChanged<String> onCountryCodeChanged;
  final String requiredErrorText;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final fieldRadius = BorderRadius.circular(ContactInfoFigmaTokens.fieldRadius);
    final borderColor = ContactInfoFigmaTokens.fieldBorder;

    OutlineInputBorder outline(Color color) => OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: color, width: 1),
        );

    return Container(
      padding: EdgeInsetsDirectional.all(ContactInfoFigmaTokens.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ContactInfoFigmaTokens.cardRadius),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            travelerTitle,
            style: AppTextStyles.subtitle(
              color: AppColors.tripDetailsFigmaBlack,
            ).copyWith(
              fontSize: ContactInfoFigmaTokens.travelerTitleSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ContactInfoFigmaTokens.fieldGap),
          _FieldLabel(label: fullNameLabel),
          SizedBox(height: ContactInfoFigmaTokens.labelGap),
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            autovalidateMode: autovalidateMode,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return requiredErrorText;
              }
              return null;
            },
            style: AppTextStyles.bodyMedium(
              color: AppColors.tripDetailsFigmaBlack,
            ).copyWith(
              fontSize: ContactInfoFigmaTokens.inputFontSize,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: fullNameHint,
              hintStyle: AppTextStyles.body(
                color: AppColors.captionText(context),
              ).copyWith(fontSize: ContactInfoFigmaTokens.inputFontSize),
              filled: true,
              fillColor: AppColors.white,
              prefixIcon: Icon(
                Iconsax.user,
                color: AppColors.greyText(context),
                size: 20.sp,
              ),
              contentPadding: EdgeInsetsDirectional.symmetric(
                horizontal: 14.w,
                vertical: 14.h,
              ),
              border: outline(borderColor),
              enabledBorder: outline(borderColor),
              focusedBorder: outline(AppColors.primary),
              errorBorder: outline(AppColors.error),
              focusedErrorBorder: outline(AppColors.error),
            ),
          ),
          SizedBox(height: ContactInfoFigmaTokens.fieldGap),
          _FieldLabel(label: phoneLabel),
          SizedBox(height: ContactInfoFigmaTokens.labelGap),
          AppPhoneNumberField(
            variant: AppPhoneNumberFieldVariant.booking,
            controller: phoneController,
            hint: phoneHint,
            selectedDialCode: countryCode,
            onDialCodeChanged: onCountryCodeChanged,
            autovalidateMode: autovalidateMode,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return requiredErrorText;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.bodyMedium(
        color: ContactInfoFigmaTokens.labelGrey,
      ).copyWith(
        fontSize: ContactInfoFigmaTokens.labelSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
