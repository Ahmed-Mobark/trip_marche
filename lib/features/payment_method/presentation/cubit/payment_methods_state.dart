import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/payment_method/domain/entities/payment_method_entity.dart';

enum PaymentMethodsStatus { initial, loading, success, failure, empty }

class PaymentMethodsState extends Equatable {
  const PaymentMethodsState({
    this.status = PaymentMethodsStatus.initial,
    this.paymentMethods = const [],
    this.selectedPaymentMethod,
    this.errorMessage,
  });

  final PaymentMethodsStatus status;
  final List<PaymentMethodEntity> paymentMethods;
  final PaymentMethodEntity? selectedPaymentMethod;
  final String? errorMessage;

  bool get isLoading => status == PaymentMethodsStatus.loading;
  bool get isSuccess => status == PaymentMethodsStatus.success;
  bool get isFailure => status == PaymentMethodsStatus.failure;
  bool get isEmpty => status == PaymentMethodsStatus.empty;

  PaymentMethodsState copyWith({
    PaymentMethodsStatus? status,
    List<PaymentMethodEntity>? paymentMethods,
    PaymentMethodEntity? selectedPaymentMethod,
    String? errorMessage,
    bool clearError = false,
    bool clearSelected = false,
  }) {
    return PaymentMethodsState(
      status: status ?? this.status,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      selectedPaymentMethod: clearSelected
          ? null
          : (selectedPaymentMethod ?? this.selectedPaymentMethod),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    status,
    paymentMethods,
    selectedPaymentMethod,
    errorMessage,
  ];
}
