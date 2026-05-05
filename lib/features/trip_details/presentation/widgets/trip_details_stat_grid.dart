import 'package:flutter/material.dart';
import 'package:trip_marche/core/config/styles/font_utils.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'trip_details_info_card.dart';

/// Trip details 2×2 stat cards — fixed logical sizes (Figma @1×), no ScreenUtil.
class TripDetailsStatGrid extends StatelessWidget {
  const TripDetailsStatGrid({super.key, required this.cells});

  final List<TripDetailsStatCellData> cells;

  static const double _gridGap = 10;
  static const double _aspect = 1.56;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      mainAxisSpacing: _gridGap,
      crossAxisSpacing: _gridGap,
      childAspectRatio: _aspect,
      children: cells.map((c) => TripDetailsStatCell(data: c)).toList(),
    );
  }
}

class TripDetailsStatCellData {
  const TripDetailsStatCellData({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

class TripDetailsStatCell extends StatelessWidget {
  const TripDetailsStatCell({super.key, required this.data});

  final TripDetailsStatCellData data;

  static final Color _cardBorder =
      AppColors.border.withValues(alpha: 0.35);

  /// Figma: icon ~20, label 12 / w400, value 16 / w600, tight vertical rhythm.
  static const double _cardRadius = 14;
  static const double _cardPad = 14;
  static const double _iconSize = 20;
  static const double _gapIconToLabel = 6;
  static const double _gapLabelToValue = 2;
  static const double _labelSize = 12;
  static const double _valueSize = 16;

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      padding: const EdgeInsetsDirectional.all(_cardPad),
      borderRadius: _cardRadius,
      borderColor: _cardBorder,
      withShadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            data.icon,
            color: AppColors.tripDetailsStatIconPurple,
            size: _iconSize,
          ),
          const SizedBox(height: _gapIconToLabel),
          Text(
            data.label,
            style: TextStyle(
              fontFamily: AppFont.fontFamily,
              fontSize: _labelSize,
              fontWeight: FontWeight.w400,
              height: 1.2,
              letterSpacing: 0,
              color: AppColors.tripDetailsSecondaryGrey,
            ),
          ),
          const SizedBox(height: _gapLabelToValue),
          Text(
            data.value,
            style: TextStyle(
              fontFamily: AppFont.fontFamily,
              fontSize: _valueSize,
              fontWeight: FontWeight.w600,
              height: 1.15,
              letterSpacing: 0,
              color: AppColors.darkText,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
