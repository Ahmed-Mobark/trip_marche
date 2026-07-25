import 'package:equatable/equatable.dart';

enum AddVendorReviewStatus { initial, loading, success, failure }

class AddVendorReviewState extends Equatable {
  final AddVendorReviewStatus status;
  final String? errorMessage;
  final String? successMessage;

  const AddVendorReviewState({
    this.status = AddVendorReviewStatus.initial,
    this.errorMessage,
    this.successMessage,
  });

  AddVendorReviewState copyWith({
    AddVendorReviewStatus? status,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
  }) {
    return AddVendorReviewState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, successMessage];
}
