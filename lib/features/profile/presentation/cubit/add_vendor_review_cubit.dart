import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/submit_review_request.dart';
import '../../domain/usecases/add_vendor_review_usecase.dart';
import 'add_vendor_review_state.dart';

class AddVendorReviewCubit extends Cubit<AddVendorReviewState> {
  AddVendorReviewCubit(this._addVendorReviewUseCase)
      : super(const AddVendorReviewState());

  final AddVendorReviewUseCase _addVendorReviewUseCase;

  Future<void> submitReview({
    required int tripId,
    required int vendorId,
    required int tripRating,
    required String tripComment,
    required int vendorRating,
    required String vendorComment,
  }) async {
    if (tripRating <= 0 || vendorRating <= 0) {
      emit(state.copyWith(
        status: AddVendorReviewStatus.failure,
        errorMessage: 'Please select a rating star.',
      ));
      return;
    }

    emit(state.copyWith(
      status: AddVendorReviewStatus.loading,
      clearError: true,
    ));

    final request = SubmitReviewRequest(
      reviews: [
        ReviewItemRequest(
          type: 'trip',
          targetId: tripId,
          rating: tripRating,
          comment: tripComment,
        ),
        ReviewItemRequest(
          type: 'vendor',
          targetId: vendorId,
          rating: vendorRating,
          comment: vendorComment,
        ),
      ],
    );

    final result = await _addVendorReviewUseCase(request);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AddVendorReviewStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (response) {
        final message = response['message'] as String? ?? 'Review submitted successfully!';
        emit(state.copyWith(
          status: AddVendorReviewStatus.success,
          successMessage: message,
        ));
      },
    );
  }
}
