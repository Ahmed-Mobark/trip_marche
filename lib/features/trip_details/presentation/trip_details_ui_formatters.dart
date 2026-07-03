import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_marche/core/utils/price_formatter.dart';

abstract final class TripDetailsUiFormatters {
  static String timeOfDay(BuildContext context, DateTime utc) {
    final loc = Localizations.localeOf(context).toString();
    return DateFormat.jm(loc).format(utc.toLocal());
  }

  static String monthDay(BuildContext context, DateTime utc) {
    final loc = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(loc).format(utc.toLocal());
  }

  /// Formats an API clock string ("HH:mm" / "HH:mm:ss") into a locale-aware
  /// time, e.g. "05:00" -> "5:00 AM". Falls back to the raw value on failure.
  static String clockTime(BuildContext context, String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return '';
    }
    final parts = trimmed.split(':');
    if (parts.length < 2) {
      return trimmed;
    }
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) {
      return trimmed;
    }
    final loc = Localizations.localeOf(context).toString();
    return DateFormat.jm(loc).format(DateTime(2000, 1, 1, hour, minute));
  }

  static String formatAmount(num value, {String currency = 'EGP'}) {
    return PriceFormatter.format(value, currency: currency);
  }

  static String transportTypeLabel(String type) {
    if (type.isEmpty) {
      return type;
    }
    return type[0].toUpperCase() + type.substring(1).toLowerCase();
  }

  /// Compact range for hero overlay, e.g. "27 Nov → 4 Dec" (locale-aware).
  static String heroTripDateRange(
    BuildContext context,
    String start,
    String end,
  ) {
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

  /// Booking date chip, e.g. "3 Jun - 11 Jun" (locale-aware).
  static String departureDateRange(
    BuildContext context,
    String start,
    String end,
  ) {
    final startDt = DateTime.tryParse(start);
    final endDt = DateTime.tryParse(end);
    if (startDt == null || endDt == null) {
      return '';
    }
    final loc = Localizations.localeOf(context).toString();
    final dayMonth = DateFormat('d MMM', loc);
    return '${dayMonth.format(startDt.toLocal())} - ${dayMonth.format(endDt.toLocal())}';
  }
}
