import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiktok_sdk_v2/tiktok_sdk_v2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TikTokSDK.instance.setup(clientKey: 'TikTokAppID');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String loginResult = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await TikTokSDK.instance.login(permissions: {
                    TikTokPermissionType.userInfoBasic,
                    TikTokPermissionType.videoList
                  }, redirectUri: "...");
                  setState(() => loginResult = result.toString());
                },
                child: const Text('Tiktok sdk 2.0 Login'),
              ),
              const SizedBox(height: 16),
              Text('Login result: $loginResult'),
            ],
          ),
        ),
      ),
    );
  }
}
