import 'booking_price_selection.dart';
import 'booking_review_data.dart';
import 'coupon_validation.dart';

class BookingQuote {
  const BookingQuote({
    required this.breakdown,
    required this.currency,
    this.coupon,
    this.priceSelections = const [],
    required this.totalBase,
  });
  final BookingPriceBreakdown breakdown;
  final String currency;
  final double totalBase;
  final List<BookingPriceSelection> priceSelections;
  final CouponValidation? coupon;
}
