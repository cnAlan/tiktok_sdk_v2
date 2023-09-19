part of '../tiktok_sdk_v2.dart';

class TikTokLoginResult {
  const TikTokLoginResult({
    required this.status,
    this.authCode,
    this.state,
    this.codeVerifier,
    this.grantedPermissions,
    this.errorCode,
    this.errorMessage,
  });
  final TikTokLoginStatus status;
  final String? authCode;
  final String? state;
  final String? codeVerifier;
  final Set<TikTokPermissionType>? grantedPermissions;
  final String? errorCode;
  final String? errorMessage;

  @override
  String toString() {
    return 'TikTokLoginResult{status: $status, authCode: $authCode, codeVerifier: $codeVerifier state: $state, grantedPermissions: $grantedPermissions, errorCode: $errorCode, errorMessage: $errorMessage}';
  }
}

enum TikTokLoginStatus {
  success,
  cancelled,
  error,
}
