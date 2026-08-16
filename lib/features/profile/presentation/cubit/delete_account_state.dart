import 'package:equatable/equatable.dart';

enum DeleteAccountStatus { initial, loading, success, failure }

class DeleteAccountState extends Equatable {
  final DeleteAccountStatus status;
  final String? errorMessage;

  const DeleteAccountState({
    this.status = DeleteAccountStatus.initial,
    this.errorMessage,
  });

  DeleteAccountState copyWith({
    DeleteAccountStatus? status,
    String? errorMessage,
  }) {
    return DeleteAccountState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
