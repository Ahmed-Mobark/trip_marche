import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'package:trip_marche/features/booking/presentation/cubit/create_booking_state.dart';
import 'package:trip_marche/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:trip_marche/features/payment_method/domain/entities/payment_method_entity.dart';

class CreateBookingCubit extends Cubit<CreateBookingState> {
  CreateBookingCubit(this._createBookingUseCase)
    : super(const CreateBookingState());

  final CreateBookingUseCase _createBookingUseCase;

  void selectPaymentMethod(PaymentMethodEntity method) {
    emit(state.copyWith(selectedPaymentMethod: method));
  }

  Future<void> createBooking({
    required BookingReviewData data,
    String? notes,
    String? couponCode,
  }) async {
    if (state.isLoading) {
      return;
    }
    final trimmedNotes = notes?.trim();
    final trimmedCoupon = couponCode?.trim();

    final validationErrors = <String, String>{};

    if (data.departureId <= 0) {
      validationErrors['departure_id'] = 'Please select a departure date';
    }

    if (data.travelers.isEmpty) {
      validationErrors['travelers'] = 'At least one traveler is required';
    }

    if (data.selectedRooms.isEmpty) {
      validationErrors['rooms'] = 'Please select at least one room';
    }

    if (state.selectedPaymentMethod == null) {
      validationErrors['payment_method'] = 'Please select a payment method';
    }

    final adultCount = data.adultCount;
    final kidCount = data.kidCount;
    final babyCount = data.babyCount;

    for (var i = 0; i < data.travelers.length; i++) {
      final traveler = data.travelers[i];
      final name = traveler.fullName.trim();
      if (name.isEmpty) {
        validationErrors['traveler_$i'] = 'Traveler name is required';
        continue;
      }

      if (i < adultCount) {
        final phone = traveler.phoneNumber.trim();
        final code = traveler.countryCode.trim();
        if (code.isEmpty || !code.startsWith('+')) {
          validationErrors['traveler_${i}_code'] = 'Country code is required';
        }
        if (phone.isEmpty) {
          validationErrors['traveler_${i}_phone'] = 'Phone number is required';
        }
      }
    }

    for (var i = 0; i < data.activities.length; i++) {
      final activityList = data.activities[i].activities;
      for (final activity in activityList) {
        final activityId = int.tryParse(activity.id);
        if (activityId == null) {
          validationErrors['activity_$i'] = 'Invalid activity';
        }
      }
    }

    if (validationErrors.isNotEmpty) {
      emit(
        state.copyWith(
          status: CreateBookingStatus.validationFailure,
          validationErrors: Map<String, String>.unmodifiable(validationErrors),
          clearError: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: CreateBookingStatus.loading,
        clearError: true,
        clearValidation: true,
      ),
    );

    final travelers = <CreateBookingTraveler>[];
    for (var i = 0; i < data.travelers.length; i++) {
      final traveler = data.travelers[i];
      if (i < adultCount) {
        travelers.add(
          CreateBookingTraveler(
            fullName: traveler.fullName.trim(),
            phoneCountryCode: traveler.countryCode.trim(),
            phone: traveler.phoneNumber.trim(),
            type: 'adult',
          ),
        );
      } else if (i < adultCount + kidCount) {
        travelers.add(
          CreateBookingTraveler(
            fullName: traveler.fullName.trim(),
            type: 'kid',
          ),
        );
      } else {
        travelers.add(
          CreateBookingTraveler(
            fullName: traveler.fullName.trim(),
            type: 'baby',
          ),
        );
      }
    }

    final rooms = data.selectedRooms
        .map(
          (room) => CreateBookingRoom(
            roomTypeId: room.roomTypeId,
            persons: room.persons,
          ),
        )
        .toList(growable: false);

    final activities = <CreateBookingActivity>[];
    for (var i = 0; i < data.activities.length; i++) {
      for (final activity in data.activities[i].activities) {
        final activityId = int.tryParse(activity.id);
        if (activityId != null) {
          activities.add(
            CreateBookingActivity(travelerIndex: i, activityId: activityId),
          );
        }
      }
    }

    final request = CreateBookingRequest(
      departureId: data.departureId,
      adults: adultCount,
      kids: kidCount,
      babies: babyCount,
      rooms: rooms,
      activities: activities,
      couponCode: trimmedCoupon,
      travelers: travelers,
      notes: trimmedNotes,
      paymentMethod: state.selectedPaymentMethod?.key,
    );

    debugPrint('CreateBookingRequest body: ${request.toJson()}');

    final result = await _createBookingUseCase(
      tripId: data.tripId,
      request: request,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CreateBookingStatus.failure,
            errorMessage: failure.message,
            clearValidation: true,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: CreateBookingStatus.success,
            bookingResponse: response,
            clearError: true,
            clearValidation: true,
          ),
        );
      },
    );
  }

  void clearValidation() {
    if (state.isValidationFailure) {
      emit(state.copyWith(clearValidation: true));
    }
  }
}
