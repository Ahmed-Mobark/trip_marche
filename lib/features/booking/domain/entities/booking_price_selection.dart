import 'package:equatable/equatable.dart';

class BookingPriceSelection extends Equatable {
  const BookingPriceSelection({
    required this.priceOptionId,
    required this.travelerType,
    required this.label,
    required this.unitPrice,
    required this.quantity,
  });
  final int priceOptionId, quantity;
  final String travelerType, label;
  final double unitPrice;
  double get totalPrice => unitPrice * quantity;
  @override
  List<Object?> get props => [
    priceOptionId,
    travelerType,
    label,
    unitPrice,
    quantity,
  ];
}
