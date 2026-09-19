import 'package:equatable/equatable.dart';

class BookingOptionalExtraSelection extends Equatable {
  const BookingOptionalExtraSelection({
    required this.extraId,
    required this.name,
    required this.unitPrice,
    required this.currency,
    required this.quantity,
  });

  final int extraId;
  final String name;
  final double unitPrice;
  final String currency;
  final int quantity;

  double get totalPrice => unitPrice * quantity;

  @override
  List<Object?> get props => [extraId, name, unitPrice, currency, quantity];
}
