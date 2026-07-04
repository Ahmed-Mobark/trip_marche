import 'package:trip_marche/core/network/network_service/exceptions.dart';
import 'package:trip_marche/features/booking/domain/entities/coupon_validation.dart';

class CouponValidationModel {
  const CouponValidationModel({
    required this.message,
    required this.code,
    required this.type,
    required this.value,
    required this.discountAmount,
  });

  final String message;
  final String code;
  final String type;
  final double value;
  final double discountAmount;

  factory CouponValidationModel.fromApiResponse(Map<String, dynamic> json) {
    final success = json['success'] == true;
    if (!success) {
      final message = json['message']?.toString().trim();
      throw ValidationException(
        message != null && message.isNotEmpty
            ? message
            : 'Invalid coupon code',
      );
    }

    final data = json['data'];
    if (data is! Map<String, dynamic>) {
      throw ValidationException('Invalid coupon response');
    }

    return CouponValidationModel(
      message: json['message']?.toString() ?? '',
      code: data['code']?.toString() ?? '',
      type: data['type']?.toString() ?? 'fixed',
      value: _asDouble(data['value']),
      discountAmount: _asDouble(data['discount_amount']),
    );
  }

  CouponValidation toEntity() {
    return CouponValidation(
      code: code,
      type: type,
      value: value,
      discountAmount: discountAmount,
      message: message,
    );
  }

  static double _asDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    return 0;
  }
}
