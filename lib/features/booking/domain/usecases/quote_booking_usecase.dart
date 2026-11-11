import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import '../entities/booking_quote.dart';
import '../repositories/create_booking_repository.dart';
import '../entities/booking_review_data.dart';

class QuoteBookingUseCase {
  const QuoteBookingUseCase(this._repository);
  final CreateBookingRepository _repository;
  Future<Either<Failure, BookingQuote>> call(
    BookingReviewData data, {
    String? couponCode,
  }) => _repository.quoteBooking(data, couponCode: couponCode);
}
