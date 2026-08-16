import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:trip_marche/features/payment_method/domain/usecases/get_payment_methods_use_case.dart';
import 'package:trip_marche/features/payment_method/presentation/cubit/payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit(this._getPaymentMethodsUseCase)
    : super(const PaymentMethodsState());

  final GetPaymentMethodsUseCase _getPaymentMethodsUseCase;

  Future<void> loadPaymentMethods() async {
    if (state.isLoading) return;
    emit(
      state.copyWith(status: PaymentMethodsStatus.loading, clearError: true),
    );

    final result = await _getPaymentMethodsUseCase();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: PaymentMethodsStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (methods) {
        if (methods.isEmpty) {
          emit(state.copyWith(status: PaymentMethodsStatus.empty));
        } else {
          emit(
            state.copyWith(
              status: PaymentMethodsStatus.success,
              paymentMethods: methods,
            ),
          );
        }
      },
    );
  }

  void selectPaymentMethod(PaymentMethodEntity method) {
    emit(state.copyWith(selectedPaymentMethod: method));
  }
}
