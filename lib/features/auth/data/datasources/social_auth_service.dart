import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/social_login_request.dart';

class SocialLoginCancelled implements Exception {}

class SocialAuthService {
  SocialAuthService({GoogleSignIn? googleSignIn})
    : _googleSignIn = googleSignIn ?? GoogleSignIn(scopes: const ['email']);

  final GoogleSignIn _googleSignIn;

  Future<SocialLoginRequest> signInWithGoogle() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw SocialLoginCancelled();
    }

    return SocialLoginRequest(
      name: account.displayName?.trim().isNotEmpty == true
          ? account.displayName!.trim()
          : account.email.split('@').first,
      email: account.email,
      oauthProvider: 'google',
      oauthProviderId: account.id,
    );
  }

  Future<SocialLoginRequest> signInWithApple() async {
    if (!Platform.isIOS && !Platform.isMacOS) {
      throw UnsupportedError(
        'Apple sign in is available on Apple devices only.',
      );
    }

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: const [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final providerId = credential.userIdentifier;
    if (providerId == null || providerId.isEmpty) {
      throw SocialLoginCancelled();
    }

    final fullName = [
      credential.givenName,
      credential.familyName,
    ].where((part) => part != null && part.trim().isNotEmpty).join(' ').trim();

    return SocialLoginRequest(
      name: fullName.isNotEmpty ? fullName : 'Apple User',
      email: credential.email ?? _fallbackAppleEmail(providerId),
      oauthProvider: 'apple',
      oauthProviderId: providerId,
    );
  }

  String _fallbackAppleEmail(String providerId) {
    final safeId = providerId
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '.')
        .replaceAll(RegExp(r'^\.+|\.+$'), '');

    return '${safeId.isEmpty ? 'user' : safeId}@apple.trevlen.local';
  }
}
