class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String countryCode;

  const RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'phone_number': phoneNumber,
        'country_code': countryCode,
      };
}
