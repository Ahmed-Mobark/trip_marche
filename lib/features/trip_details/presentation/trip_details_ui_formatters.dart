import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract final class TripDetailsUiFormatters {
  static String timeOfDay(BuildContext context, DateTime utc) {
    final loc = Localizations.localeOf(context).toString();
    return DateFormat.jm(loc).format(utc.toLocal());
  }

  static String monthDay(BuildContext context, DateTime utc) {
    final loc = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(loc).format(utc.toLocal());
  }

  static String formatAmount(num value) {
    return NumberFormat('#,###', 'en').format(value.round());
  }

  static String transportTypeLabel(String type) {
    if (type.isEmpty) {
      return type;
    }
    return type[0].toUpperCase() + type.substring(1).toLowerCase();
  }

  /// Compact range for hero overlay, e.g. "27 Nov → 4 Dec" (locale-aware).
  static String heroTripDateRange(BuildContext context, String start, String end) {
    final startDt = DateTime.tryParse(start);
    final endDt = DateTime.tryParse(end);
    if (startDt == null || endDt == null) {
      return '';
    }
    final loc = Localizations.localeOf(context).toString();
    final startLocal = startDt.toLocal();
    final endLocal = endDt.toLocal();
    final dayMonth = DateFormat('d MMM', loc);
    return '${dayMonth.format(startLocal)} → ${dayMonth.format(endLocal)}';
  }
}
