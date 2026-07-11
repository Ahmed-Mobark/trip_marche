import 'package:equatable/equatable.dart';

class PaymentMethodEntity extends Equatable {
  const PaymentMethodEntity({
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

  @override
  List<Object?> get props => [key, name, description, icon, isOnline];
}
