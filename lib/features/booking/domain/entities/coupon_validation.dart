import 'package:equatable/equatable.dart';

class CouponValidation extends Equatable {
  const CouponValidation({
    required this.code,
    required this.type,
    required this.value,
    required this.discountAmount,
    required this.message,
  });

  final String code;
  final String type;
  final double value;
  final double discountAmount;
  final String message;

  bool get isPercent => type == 'percent';

  @override
  List<Object?> get props => [code, type, value, discountAmount, message];
}
