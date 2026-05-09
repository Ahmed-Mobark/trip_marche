import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

/// Pill search field used on trip catalog / section list screens (wishlist hint, Iconsax, 999 radius).
class AppTripSearchTextField extends StatefulWidget {
  const AppTripSearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onSubmitted,
    required this.onClear,
    this.hintText,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback onClear;

  /// Defaults to [AppLocalizations.wishlistSearchHint].
  final String? hintText;

  @override
  State<AppTripSearchTextField> createState() => _AppTripSearchTextFieldState();
}

class _AppTripSearchTextFieldState extends State<AppTripSearchTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerTick);
  }

  @override
  void didUpdateWidget(covariant AppTripSearchTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onControllerTick);
      widget.controller.addListener(_onControllerTick);
    }
  }

  void _onControllerTick() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerTick);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showClear = widget.controller.text.isNotEmpty;
    final hint = widget.hintText ?? context.tr.wishlistSearchHint;
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      textInputAction: TextInputAction.search,
      style: AppTextStyles.bodyMedium(color: AppColors.darkText(context)),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodyMedium(color: AppColors.greyText(context)),
        prefixIcon: Icon(
          Iconsax.search_normal_1,
          size: 20.sp,
          color: AppColors.greyText(context),
        ),
        suffixIcon: showClear
            ? IconButton(
                onPressed: widget.onClear,
                icon: Icon(
                  Iconsax.close_circle,
                  size: 20.sp,
                  color: AppColors.greyText(context),
                ),
                tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
              )
            : null,
        filled: true,
        fillColor: AppColors.background(context),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColors.border(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColors.border(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
