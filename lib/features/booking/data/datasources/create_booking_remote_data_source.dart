import '../../domain/entities/booking_quote.dart';
import '../../domain/entities/booking_review_data.dart';
import '../models/booking_quote_model.dart';
import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';

abstract class CreateBookingRemoteDataSource {
  Future<BookingQuote> quoteBooking(
    BookingReviewData data, {
    String? couponCode,
  });
  Future<CreateBookingResponse> createBooking(
    int tripId,
    CreateBookingRequest request,
  );
}

class CreateBookingRemoteDataSourceImpl
    implements CreateBookingRemoteDataSource {
  CreateBookingRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<BookingQuote> quoteBooking(
    BookingReviewData data, {
    String? couponCode,
  }) async {
    final response = await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.bookingQuote(data.tripId),
      body: BookingQuoteRequest(data, couponCode: couponCode).toJson(),
      includeCurrency: true,
    );
    return BookingQuoteModel.fromApiResponse(response);
  }

  @override
  Future<CreateBookingResponse> createBooking(
    int tripId,
    CreateBookingRequest request,
  ) async {
    final response = await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.createBooking(tripId),
      body: request.toJson(),
      includeCurrency: true,
    );
    return CreateBookingResponse.fromApiResponse(response);
  }
}
