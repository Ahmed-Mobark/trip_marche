import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_reviews_usecase.dart';
import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(this._getReviewsUseCase) : super(const ReviewsState());

  final GetReviewsUseCase _getReviewsUseCase;

  Future<void> fetchReviews() async {
    if (state.status == ReviewsStatus.loading) return;
    emit(state.copyWith(status: ReviewsStatus.loading, clearError: true));

    final result = await _getReviewsUseCase();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ReviewsStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (parsed) {
        emit(state.copyWith(
          status: ReviewsStatus.success,
          reviews: parsed.reviews,
          meta: parsed.meta,
          errorMessage: null,
        ));
      },
    );
  }
}
