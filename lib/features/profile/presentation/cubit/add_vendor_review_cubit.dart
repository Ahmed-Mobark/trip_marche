import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_vendor_review_usecase.dart';
import 'add_vendor_review_state.dart';

class AddVendorReviewCubit extends Cubit<AddVendorReviewState> {
  AddVendorReviewCubit(this._addVendorReviewUseCase)
      : super(const AddVendorReviewState());

  final AddVendorReviewUseCase _addVendorReviewUseCase;

  Future<void> submitReview({
    required int vendorId,
    required double rating,
    required String comment,
  }) async {
    if (rating <= 0) {
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

    final result = await _addVendorReviewUseCase(
      vendorId: vendorId,
      rating: rating,
      comment: comment,
    );

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
