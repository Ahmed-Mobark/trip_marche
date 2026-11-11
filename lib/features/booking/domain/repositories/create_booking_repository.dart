import '../entities/booking_quote.dart';
import '../entities/booking_review_data.dart';
import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';

abstract class CreateBookingRepository {
  Future<Either<Failure, BookingQuote>> quoteBooking(
    BookingReviewData data, {
    String? couponCode,
  });
  Future<Either<Failure, CreateBookingResponse>> createBooking(
    int tripId,
    CreateBookingRequest request,
  );
}
