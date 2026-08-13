import 'package:flutter/material.dart';
import 'package:trip_marche/core/config/styles/font_utils.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'trip_details_info_card.dart';

/// Trip details stat row — Duration, Group Size, Cities, Type in one horizontal row.
class TripDetailsStatGrid extends StatelessWidget {
  const TripDetailsStatGrid({super.key, required this.cells});

  final List<TripDetailsStatCellData> cells;

  static const double _gap = 6;
  static const double _cardRadius = 10;
  static const double _cardPad = 8;

  @override
  Widget build(BuildContext context) {
    if (cells.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        for (var i = 0; i < cells.length; i++) ...[
          if (i > 0) const SizedBox(width: _gap),
          Expanded(child: TripDetailsStatCell(data: cells[i])),
        ],
      ],
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

  static const double _iconSize = 16;
  static const double _gapIconToLabel = 3;
  static const double _gapLabelToValue = 1;
  static const double _labelSize = 9;
  static const double _valueSize = 11;

  @override
  Widget build(BuildContext context) {
    final cardBorder = AppColors.border(context).withValues(alpha: 0.35);
    return TripDetailsInfoCard(
      padding: const EdgeInsetsDirectional.all(TripDetailsStatGrid._cardPad),
      borderRadius: TripDetailsStatGrid._cardRadius,
      borderColor: cardBorder,
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
              height: 1.1,
              letterSpacing: 0,
              color: AppColors.tripDetailsSecondaryGrey(context),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: _gapLabelToValue),
          Text(
            data.value,
            style: TextStyle(
              fontFamily: AppFont.fontFamily,
              fontSize: _valueSize,
              fontWeight: FontWeight.w600,
              height: 1.1,
              letterSpacing: 0,
              color: AppColors.darkText(context),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
