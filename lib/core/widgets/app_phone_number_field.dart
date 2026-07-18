import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/contact_info_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/theme/calendar_theme.dart';
import 'package:trip_marche/core/widgets/app_text_form_field.dart';

enum AppPhoneNumberFieldVariant { auth, booking }

class AppPhoneNumberField extends StatelessWidget {
  const AppPhoneNumberField({
    super.key,
    required this.controller,
    required this.hint,
    required this.selectedDialCode,
    required this.onDialCodeChanged,
    this.initialCountryCode,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.variant = AppPhoneNumberFieldVariant.auth,
  });

  final TextEditingController controller;
  final String hint;
  final String selectedDialCode;
  final String? initialCountryCode;
  final ValueChanged<String> onDialCodeChanged;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final AppPhoneNumberFieldVariant variant;

  @override
  Widget build(BuildContext context) {
    if (variant == AppPhoneNumberFieldVariant.auth) {
      return AppTextFormField(
        controller: controller,
        hintText: hint,
        keyboardType: TextInputType.phone,
        onlyDigit: true,
        validator: validator,
        cardColor: AppColors.inputBg(context),
        hintStyle: AppTextStyles.body(
          color: AppColors.captionText(context),
        ).copyWith(fontSize: 14.sp),
        borderColor: AppColors.border(context),
        focusedBorderColor: AppColors.primary.withValues(alpha: 0.95),
        errorBorderColor: AppColors.error.withValues(alpha: 0.9),
        borderRadius: 18.r,
        contentPadding: EdgeInsetsDirectional.fromSTEB(0, 16.h, 16.w, 16.h),
        onChanged: onChanged,
        prefixWidget: _CountryPrefix(
          selectedDialCode: selectedDialCode,
          initialCountryCode: initialCountryCode,
          onDialCodeChanged: onDialCodeChanged,
          variant: variant,
        ),
      );
    }

    final radius = BorderRadius.circular(ContactInfoFigmaTokens.fieldRadius);
    final border = AppColors.softBorder(context);

    OutlineInputBorder outline(Color color) => OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: color, width: 1),
        );

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: validator,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      style: AppTextStyles.bodyMedium(
        color: AppColors.ink(context),
      ).copyWith(
        fontSize: ContactInfoFigmaTokens.inputFontSize,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.body(
          color: AppColors.captionText(context),
        ).copyWith(fontSize: ContactInfoFigmaTokens.inputFontSize),
        filled: true,
        fillColor: AppColors.cardBg(context),
        contentPadding: EdgeInsetsDirectional.fromSTEB(0, 14.h, 14.w, 14.h),
        prefixIcon: _CountryPrefix(
          selectedDialCode: selectedDialCode,
          initialCountryCode: initialCountryCode,
          onDialCodeChanged: onDialCodeChanged,
          variant: variant,
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 118.w),
        border: outline(border),
        enabledBorder: outline(border),
        focusedBorder: outline(AppColors.primary),
        errorBorder: outline(AppColors.error),
        focusedErrorBorder: outline(AppColors.error),
      ),
    );
  }
}

class _CountryPrefix extends StatelessWidget {
  const _CountryPrefix({
    required this.selectedDialCode,
    this.initialCountryCode,
    required this.onDialCodeChanged,
    required this.variant,
  });

  final String selectedDialCode;
  final String? initialCountryCode;
  final ValueChanged<String> onDialCodeChanged;
  final AppPhoneNumberFieldVariant variant;

  @override
  Widget build(BuildContext context) {
    final isBooking = variant == AppPhoneNumberFieldVariant.booking;
    final initialSelection = _resolveCountryCode(initialCountryCode);
    final dialCodeStyle = AppTextStyles.bodyMedium(
      color: isBooking ? AppColors.greyText(context) : AppColors.darkText(context),
    ).copyWith(
      fontSize: isBooking
          ? ContactInfoFigmaTokens.inputFontSize
          : 14.sp,
    );

    final picker = Theme(
      data: Theme.of(context).copyWith(
        canvasColor: AppColors.cardBg(context),
        dialogTheme: CalendarTheme.getCalendarTheme(context).dialogTheme,
      ),
      child: CountryCodePicker(
        onChanged: (countryCode) {
          onDialCodeChanged(countryCode.dialCode ?? '+20');
        },
        initialSelection: initialSelection,
        favorite: const ['EG', '+20'],
        showCountryOnly: false,
        showOnlyCountryWhenClosed: false,
        showDropDownButton: false,
        alignLeft: false,
        padding: EdgeInsets.zero,
        dialogSize: Size(340.w, 520.h),
        textStyle: dialCodeStyle,
        dialogTextStyle: AppTextStyles.body(
          color: AppColors.darkText(context),
        ).copyWith(fontSize: 14.sp),
        searchDecoration: InputDecoration(
          hintText: 'Search',
          hintStyle: AppTextStyles.body(
            color: AppColors.captionText(context),
          ).copyWith(fontSize: 13.sp),
          filled: true,
          fillColor: AppColors.inputBg(context),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.greyText(context),
            size: 18.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: AppColors.border(context).withValues(alpha: 0.85),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: AppColors.primary.withValues(alpha: 0.95),
            ),
          ),
        ),
        flagWidth: isBooking ? 20.w : 18.w,
        boxDecoration: const BoxDecoration(),
        barrierColor: AppColors.shadow.withValues(alpha: 0.25),
        closeIcon: Icon(
          Icons.close_rounded,
          color: AppColors.darkText(context),
          size: 18.sp,
        ),
      ),
    );

    final arrow = Icon(
      Icons.keyboard_arrow_down_rounded,
      color: AppColors.greyText(context),
      size: isBooking ? 18.sp : 16.sp,
    );

    final divider = Container(
      width: 1.w,
      height: isBooking ? 24.h : 30.h,
      margin: EdgeInsetsDirectional.only(
        start: isBooking ? 6.w : 4.w,
        end: isBooking ? 4.w : 0,
      ),
      color: isBooking
          ? AppColors.softBorder(context)
          : AppColors.border(context),
    );

    if (isBooking) {
      return Padding(
        padding: EdgeInsetsDirectional.only(start: 4.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [picker, arrow, divider],
        ),
      );
    }

    return SizedBox(
      width: 132.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [picker, arrow, divider],
      ),
    );
  }
}

String _resolveCountryCode(String? dialCode) {
  final code = dialCode?.trim();
  if (code == null || code.isEmpty) return 'EG';
  final match = codes.firstWhere(
    (json) => json['dial_code'] == code,
    orElse: () => const {'name': 'Egypt', 'code': 'EG', 'dial_code': '+20', 'flag_uri': 'flags/eg.png'},
  );
  return match['code'] as String;
}
