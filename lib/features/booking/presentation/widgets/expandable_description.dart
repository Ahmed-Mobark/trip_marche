import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/review_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class ExpandableDescription extends StatefulWidget {
  const ExpandableDescription({
    super.key,
    required this.text,
    this.initiallyExpanded = true,
  });

  final String text;
  final bool initiallyExpanded;

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    if (!_expanded) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsetsDirectional.only(top: 10.h, bottom: 12.h),
      child: Text(
        widget.text,
        style: AppTextStyles.bodyMedium(
          color: AppColors.metaGrey(context),
        ).copyWith(
          fontSize: ReviewFigmaTokens.bodySize,
          fontWeight: FontWeight.w400,
          height: 1.45,
        ),
      ),
    );
  }

  bool get isExpanded => _expanded;

  void toggle() => setState(() => _expanded = !_expanded);
}

class ExpandableDescriptionHeader extends StatelessWidget {
  const ExpandableDescriptionHeader({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onToggle,
  });

  final String title;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.subtitle(
                color: AppColors.ink(context),
              ).copyWith(
                fontSize: ReviewFigmaTokens.tripNameSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            isExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: AppColors.metaGrey(context),
            size: 22.sp,
          ),
        ],
      ),
    );
  }
}
