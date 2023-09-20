# tiktok_sdk_v2

Native SDK documentation 👉 https://developers.tiktok.com/doc/getting-started-create-an-app/

# iOS Configuration
Go to https://developers.tiktok.com/doc/getting-started-ios-quickstart-swift
### Step 1: Configure TikTok App Settings for iOS
Go to TikTok Developer App Registration Page to create your app. After approval, you will get the Client Key and Client Secret.

### Step 2: Configure Xcode Project
Configure Info.plist
```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tiktokopensdk</string>
    <string>tiktoksharesdk</string>
    <string>snssdk1180</string>
    <string>snssdk1233</string>
</array>
<key>TikTokClientKey</key>
<string>$TikTokClientKey</string>
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>$TikTokClientKey</string>
    </array>
  </dict>
</array>
```
### Step 3: Edit AppDelegate.swift
Add the following code to your AppDelegate.swift file.
```
import UIKit
import Flutter

// Add this line
import TikTokOpenSDKCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Add this function
  override func application(
      _ app: UIApplication,
      open url: URL,
      options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
      if TikTokURLHandler.handleOpenURL(url) {
          return true
      }
      return false
  }
  
  // Add this function
  override func application(
      _ application: UIApplication,
      continue userActivity: NSUserActivity,
      restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
      if (TikTokURLHandler.handleOpenURL(userActivity.webpageURL)) {
          return true
      }
      return false
  }
}
```

# Android Configuration
Go to https://developers.tiktok.com/doc/getting-started-android-quickstart
### Step 1: Configure TikTok App Settings for Android
Use the Developer Portal to apply for Android client_key and client_secret access. Upon application approval, the Developer Portal will provide access to these keys.

### Step 2: Edit Your Manifest
Due to changes in Android 11 regarding package visibility, when impementing Tiktok SDK for devices targeting Android 11 and higher, add the following to the Android Manifest file:
```
<queries>
    <package android:name="com.zhiliaoapp.musically" />
    <package android:name="com.ss.android.ugc.trill" />
</queries>
```

# flutter
### Step 1: Setup config
```
await TikTokSDK.instance.setup(clientKey: DefaultConfig.user.tiktokClientKey);
```

### Step 2: Call login
```
final result = await TikTokSDK.instance.login(permissions: {
  TikTokPermissionType.userInfoBasic,
  TikTokPermissionType.videoList
}, redirectUri: DefaultConfig.system.redirectUri);
```

# Example code
[example](https://github.com/cnAlan/tiktok_sdk_v2/tree/master/example)

