import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

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
  final String? hintText;

  static const double _fontSize = 14;
  static const double _iconSize = 20;
  static const double _fieldHeight = 48;
  static const double _radius = 999;

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
    if (mounted) setState(() {});
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

    final textStyle = TextStyle(
      fontSize: AppTripSearchTextField._fontSize.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.darkText(context),
    );
    final hintStyle = TextStyle(
      fontSize: AppTripSearchTextField._fontSize.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.greyText(context),
    );
    final iconSize = AppTripSearchTextField._iconSize.sp;
    final radius = BorderRadius.circular(AppTripSearchTextField._radius.r);

    return SizedBox(
      height: AppTripSearchTextField._fieldHeight.h,
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        textInputAction: TextInputAction.search,
        style: textStyle,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintStyle,
          prefixIcon: Icon(
            Iconsax.search_normal_1,
            size: iconSize,
            color: AppColors.greyText(context),
          ),
          suffixIcon: showClear
              ? IconButton(
                  onPressed: widget.onClear,
                  icon: Icon(
                    Iconsax.close_circle,
                    size: iconSize,
                    color: AppColors.greyText(context),
                  ),
                  tooltip:
                      MaterialLocalizations.of(context).deleteButtonTooltip,
                )
              : null,
          filled: true,
          fillColor: AppColors.background(context),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: radius,
            borderSide: BorderSide(color: AppColors.border(context)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: BorderSide(color: AppColors.border(context)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
