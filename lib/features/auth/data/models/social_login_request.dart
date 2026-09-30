class SocialLoginRequest {
  const SocialLoginRequest({
    required this.name,
    required this.email,
    required this.oauthProvider,
    required this.oauthProviderId,
  });

  final String name;
  final String email;
  final String oauthProvider;
  final String oauthProviderId;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'oauth_provider': oauthProvider,
      'oauth_provider_id': oauthProviderId,
    };
  }
}
