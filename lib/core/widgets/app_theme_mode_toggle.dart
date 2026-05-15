import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/app_colors.dart';

/// Premium dark/light toggle: sliding thumb + sun/moon cues. Uses theme colors.
///
/// [value] mirrors [Switch]: `true` when **dark** mode is active.
/// [onChanged] receives the **new** dark-mode value after tap.
class AppThemeModeToggle extends StatelessWidget {
  const AppThemeModeToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.semanticsLabel,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = scheme.primary;
    final border = AppColors.border(context);
    final muted = AppColors.greyText(context);
    final trackFill = AppColors.inputBg(context);
    final thumbSurface = AppColors.cardBg(context);

    final trackH = 46.w;
    final trackW = 132.w;
    final thumb = 36.w;
    final inset = 5.w;
    final inactiveFade = muted.withValues(alpha: 0.42);

    return Semantics(
      toggled: value,
      label: semanticsLabel,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChanged(!value),
          borderRadius: BorderRadius.circular(trackH / 2),
          splashColor: accent.withValues(alpha: 0.14),
          highlightColor: accent.withValues(alpha: 0.07),
          child: Ink(
            height: trackH,
            width: trackW,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(trackH / 2),
              color: trackFill,
              border: Border.all(color: border),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: value ? 0.22 : 0.10),
                  blurRadius: value ? 12 : 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(trackH / 2),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 14.w, end: 14.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Iconsax.sun,
                          size: 18.sp,
                          color: value ? inactiveFade : accent,
                        ),
                        Icon(
                          Iconsax.moon,
                          size: 18.sp,
                          color: value ? accent : inactiveFade,
                        ),
                      ],
                    ),
                  ),
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutCubic,
                    alignment: value
                        ? AlignmentDirectional.centerEnd
                        : AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: inset,
                        end: inset,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 320),
                        curve: Curves.easeOutCubic,
                        width: thumb,
                        height: thumb,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: thumbSurface,
                          border: Border.all(
                            color: accent.withValues(alpha: 0.9),
                            width: 1.5.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.14),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 260),
                          // Avoid overshooting curves (e.g. easeOutBack): they can push the
                          // incoming animation past 1.0 and break nested CurvedAnimation.
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: Tween<double>(begin: 0.82, end: 1.0)
                                  .animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOutCubic,
                                    ),
                                  ),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Icon(
                            value ? Icons.dark_mode : Icons.light_mode,
                            key: ValueKey<bool>(value),
                            size: 17.sp,
                            color: accent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
