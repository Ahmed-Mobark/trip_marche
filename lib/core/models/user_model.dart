class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  final int id;
  final String name;
  final String email;
  final String phoneNumber;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
      };
}

