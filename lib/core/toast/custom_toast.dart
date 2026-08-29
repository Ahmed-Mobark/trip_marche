import '../theme/app_colors.dart';
import '../config/styles/styles.dart';
import 'app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomToast extends StatefulWidget {
  final AnimationController? controller;
  final ToastType type;
  final String message;
  final String? description;
  final TextStyle? messageStyle;
  final TextStyle? descriptionStyle;
  final Function()? onTap;
  final Curve? curve;
  final bool? isClosable;
  final bool isInFront;
  final VoidCallback? onClose;

  const CustomToast({
    required this.controller,
    required this.message,
    required this.type,
    required this.isInFront,
    this.onTap,
    this.onClose,
    this.description,
    this.descriptionStyle,
    this.messageStyle,
    this.isClosable,
    this.curve,
    super.key,
  });

  @override
  State<CustomToast> createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast> {
  Color getColor() => switch (widget.type) {
    ToastType.success => AppColors.success,
    ToastType.warning => AppColors.warning,
    ToastType.error => AppColors.error,
    ToastType.info => AppColors.infoBlue,
  };

  IconData getIconData() => switch (widget.type) {
    ToastType.success => Icons.check_circle_rounded,
    ToastType.warning => Icons.warning_rounded,
    ToastType.error => Icons.error_rounded,
    ToastType.info => Icons.info_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller!,
      builder: (context, _) {
        return Material(
          color: AppColors.transparent,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: const Offset(0.0, 0.0),
                ).animate(
                  CurvedAnimation(
                    parent: widget.controller!,
                    curve: widget.curve ?? Curves.elasticOut,
                    reverseCurve: widget.curve ?? Curves.elasticOut,
                  ),
                ),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 9.h,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: getColor().withValues(alpha: 0.28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow.withValues(alpha: 0.1),
                        blurRadius: 12.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32.r,
                        height: 32.r,
                        decoration: BoxDecoration(
                          color: getColor().withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          getIconData(),
                          color: getColor(),
                          size: 19.r,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.message,
                              style:
                                  widget.messageStyle ??
                                  TextStyles.textViewMedium14.copyWith(
                                    color: AppColors.darkText(context),
                                    height: 1.2,
                                  ),
                            ),
                            if (widget.description != null) ...[
                              SizedBox(height: 3.h),
                              Text(
                                widget.description!,
                                style:
                                    widget.descriptionStyle ??
                                    TextStyles.textViewRegular12.copyWith(
                                      color: AppColors.greyText(context),
                                      height: 1.25,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
