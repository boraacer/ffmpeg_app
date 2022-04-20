import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConnectionData with ChangeNotifier {
  final authStorage = new FlutterSecureStorage();

  Future<AuthData> authDevice(String host, String user, String password) async {
    String? deviceId = await _getId();

    final response = await http.post(Uri.parse("$host/auth/new"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user': user,
          'password': password,
          'device': deviceId!,
        }));
    if (response.statusCode == 200) {
      return AuthData(
          host: host, user: user, apiKey: json.decode(response.body)["apiKey"]);
    } else {
      throw Exception('Failed to create AuthData.');
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
    return null;
  }

  Future<void> loadUserData() async {
    await SharedPreferences.getInstance().then((prefs) {
      // String host = prefs.getString(key)
    });
  }

  Future<void> saveUserData(data) async {
    await authStorage.write(key: "_AuthData", value: data.toString());
  }
}

class AuthData {
  final String host;
  final String user;
  final String apiKey;

  AuthData({
    required this.host,
    required this.user,
    required this.apiKey,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      host: json['host'],
      user: json['user'],
      apiKey: json['apiKey'],
    );
  }

  @override
  toString() => {'host': host, 'user': user, 'password': apiKey}.toString();
}
