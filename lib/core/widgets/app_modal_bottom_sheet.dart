import 'package:flutter/material.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/extensions/media_query_extensions.dart';

/// Shows a modal bottom sheet whose surface extends behind the system navigation
/// area while keeping [builder] content above the inset.
Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useRootNavigator = false,
  ShapeBorder? shape,
  Clip? clipBehavior,
  bool applySystemBottomInset = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    useRootNavigator: useRootNavigator,
    useSafeArea: false,
    backgroundColor: backgroundColor ?? AppColors.cardBg(context),
    shape: shape,
    clipBehavior: clipBehavior,
    builder: (ctx) {
      if (!applySystemBottomInset) {
        return builder(ctx);
      }
      final bottomInset = ctx.systemBottomInset;
      if (bottomInset == 0) {
        return builder(ctx);
      }
      return Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: builder(ctx),
      );
    },
  );
}

/// Wraps [child] so [color] fills the system navigation inset while [child]
/// stays above it. Use for sheets/bars that own their own background.
class BottomSystemInsetSurface extends StatelessWidget {
  const BottomSystemInsetSurface({
    super.key,
    required this.color,
    required this.child,
    this.borderRadius,
    this.additionalBottomPadding = 0,
  });

  final Color color;
  final Widget child;
  final BorderRadius? borderRadius;
  final double additionalBottomPadding;

  @override
  Widget build(BuildContext context) {
    final bottomInset = context.systemBottomInset + additionalBottomPadding;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: child,
      ),
    );
  }
}
