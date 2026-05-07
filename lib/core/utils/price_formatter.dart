import 'package:intl/intl.dart';

abstract final class PriceFormatter {
  static String format(num value, {String currency = 'EGP'}) {
    final amount = NumberFormat('#,###', 'en').format(value.round());
    return '$amount $currency';
  }
}
