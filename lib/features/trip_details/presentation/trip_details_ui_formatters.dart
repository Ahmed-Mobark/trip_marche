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
}
