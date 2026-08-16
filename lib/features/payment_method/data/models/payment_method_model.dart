import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/payment_method/domain/entities/payment_method_entity.dart';

class PaymentMethodModel extends Equatable {
  const PaymentMethodModel({
    required this.key,
    required this.name,
    required this.description,
    required this.icon,
    required this.isOnline,
  });

  final String key;
  final String name;
  final String description;
  final String icon;
  final bool isOnline;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      key: json['key'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      isOnline: json['is_online'] as bool? ?? true,
    );
  }

  PaymentMethodEntity toEntity() {
    return PaymentMethodEntity(
      key: key,
      name: name,
      description: description,
      icon: icon,
      isOnline: isOnline,
    );
  }

  @override
  List<Object?> get props => [key, name, description, icon, isOnline];
}

class PaymentMethodsResponse extends Equatable {
  const PaymentMethodsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final List<PaymentMethodModel> data;

  factory PaymentMethodsResponse.fromJson(Map<String, dynamic> json) {
    final rawList = json['data'] as List<dynamic>? ?? const [];
    final methods = rawList
        .map(
          (item) => PaymentMethodModel.fromJson(item as Map<String, dynamic>),
        )
        .toList();
    return PaymentMethodsResponse(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      data: methods,
    );
  }

  @override
  List<Object?> get props => [success, message, data];
}
