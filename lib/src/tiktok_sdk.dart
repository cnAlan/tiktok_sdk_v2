part of '../tiktok_sdk_v2.dart';

class TikTokSDK {
  static const MethodChannel _channel =
      MethodChannel('com.tofinds.tiktok_sdk_v2');

  /// singleton object of TikTokSDK
  static final TikTokSDK instance = TikTokSDK._();

  TikTokSDK._();

  /// setup TikTokSDK
  /// Must be called only on Android.
  Future<void> setup({required String clientKey}) async {
    if (Platform.isIOS) {
      return;
    }

    await _channel.invokeMethod(
      'setup',
      <String, dynamic>{
        'clientKey': clientKey,
      },
    );
  }

  /// login TikTok
  ///
  /// [permissionType] You must apply for permissions at the time of app registration.
  Future<TikTokLoginResult> login({
    required Set<TikTokPermissionType> permissions,
    required String redirectUri,
    bool? browserAuthEnabled,
    String? state,
  }) async {
    try {
      final scope =
          permissions.map((permission) => permission.scopeName).join(',');
      final result = await _channel.invokeMapMethod<String, Object>(
        'login',
        <String, dynamic>{
          'scope': scope,
          'redirectUri': redirectUri,
          'browserAuthEnabled': browserAuthEnabled ?? false,
          'state': state,
        },
      );

      if (result != null) {
        final grantedPermissionsStringList =
            result["grantedPermissions"] != null
                ? (result['grantedPermissions'] as String).split(',')
                : [];
        final grantedPermissions = grantedPermissionsStringList
            .map((permission) => _fromScopeName(permission))
            .whereType<TikTokPermissionType>()
            .toSet();

        return TikTokLoginResult(
          status: result["authCode"] != null
              ? TikTokLoginStatus.success
              : TikTokLoginStatus.error,
          authCode:
              result["authCode"] != null ? result["authCode"] as String : "",
          codeVerifier: result["codeVerifier"] as String,
          state: result["state"] as String?,
          grantedPermissions: grantedPermissions,
        );
      } else {
        return const TikTokLoginResult(
          status: TikTokLoginStatus.error,
        );
      }
    } on PlatformException catch (e) {
      final status = e.code == "-2"
          ? TikTokLoginStatus.cancelled
          : TikTokLoginStatus.error;

      return TikTokLoginResult(
        status: status,
        errorCode: e.code,
        errorMessage: e.message,
      );
    }
  }
}
