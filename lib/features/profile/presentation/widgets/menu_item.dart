import 'package:flutter/material.dart';

import '../theme/profile_handoff_tokens.dart';

/// Single row in profile handoff cards — Figma **1:22365** (24px icon, 8 gap,
/// 16px chevron, 20px vertical padding; delete row 16px vertical, no chevron).
class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.titleColor,
    this.iconColor,
    this.showChevron = true,
    this.trailing,
    this.verticalPaddingFigma = 20,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? iconColor;
  final bool showChevron;
  final Widget? trailing;

  /// Vertical padding measured on Figma 430 frame (e.g. 20 or 16).
  final double verticalPaddingFigma;

  @override
  Widget build(BuildContext context) {
    final t = ProfileHandoffTokens.of(context);
    final iconSize = t.w(24);
    final chevronSize = t.w(16);
    final gap = t.w(8);
    final vPad = t.w(verticalPaddingFigma);
    final defaultIcon = iconColor ?? ProfileHandoffTokens.menuTitle(context);
    final chevronColor = ProfileHandoffTokens.sectionLabelColor(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: vPad),
          child: Row(
            children: [
              SizedBox(
                width: iconSize,
                height: iconSize,
                child: Center(
                  child: Icon(
                    icon,
                    size: iconSize,
                    color: defaultIcon,
                  ),
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: t.menuRowTitleStyle(context).copyWith(
                    color: titleColor,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
              if (showChevron)
                _HandoffChevron(size: chevronSize, color: chevronColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _HandoffChevron extends StatelessWidget {
  const _HandoffChevron({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Icon(
      isRtl ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios,
      size: size,
      color: color,
    );
  }
}
