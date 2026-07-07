import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';

enum CreateBookingStatus {
  initial,
  loading,
  success,
  failure,
  validationFailure,
}

class CreateBookingState extends Equatable {
  const CreateBookingState({
    this.status = CreateBookingStatus.initial,
    this.errorMessage,
    this.validationErrors,
    this.bookingResponse,
  });

  final CreateBookingStatus status;
  final String? errorMessage;
  final Map<String, String>? validationErrors;
  final CreateBookingResponse? bookingResponse;

  bool get isLoading => status == CreateBookingStatus.loading;
  bool get isSuccess => status == CreateBookingStatus.success;
  bool get isFailure => status == CreateBookingStatus.failure;
  bool get isValidationFailure =>
      status == CreateBookingStatus.validationFailure;

  CreateBookingState copyWith({
    CreateBookingStatus? status,
    String? errorMessage,
    Map<String, String>? validationErrors,
    CreateBookingResponse? bookingResponse,
    bool clearError = false,
    bool clearValidation = false,
  }) {
    return CreateBookingState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      validationErrors:
          clearValidation ? null : (validationErrors ?? this.validationErrors),
      bookingResponse: bookingResponse ?? this.bookingResponse,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        validationErrors,
        bookingResponse,
      ];
}
