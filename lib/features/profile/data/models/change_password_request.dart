class ChangePasswordRequest {
  final String currentPassword;
  final String password;

  const ChangePasswordRequest({
    required this.currentPassword,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'password': password,
    };
  }
}
