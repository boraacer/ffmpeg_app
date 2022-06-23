import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConnectionData with ChangeNotifier {
  final authStorage = const FlutterSecureStorage();

  Future<AuthData> authDevice(String host, String user, String password) async {
    if (!isURL(host, requireTld: true)) {
      throw Exception('Host URL is invaild');
    } else {
      String? deviceId = await _getId();

      final response = await http.post(Uri.parse("$host/auth/client/new"),
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
            host: host,
            user: user,
            apiKey: json.decode(response.body)["apiKey"]);
      } else {
        throw Exception('Failed to create AuthData');
      }
    }
  }

  Future<int> authclient(data) async {
    AuthData _data = AuthData(
        host: json.decode(data)["host"],
        user: json.decode(data)["user"],
        apiKey: json.decode(data)["apiKey"]);
    if (!isURL(_data.host, requireTld: true)) {
      return 3;
    } else {
      final response = await http.post(Uri.parse("${_data.host}/auth/client"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'user': _data.user,
            'apiKey': _data.apiKey,
          }));
      if (response.statusCode == 200) {
        return 0;
      } else {
        return 1;
      }
    }
  }

  Future<ConnectionDetails> connectionDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String? data = await userData("_AuthData");
    AuthData _data = AuthData(
        host: json.decode(data!)["host"],
        user: json.decode(data)["user"],
        apiKey: json.decode(data)["apiKey"]);
    if (!isURL(_data.host, requireTld: true)) {
      throw Exception('Host URL is invaild');
    } else {
      Stopwatch stopwatch = Stopwatch()..start();
      final response = await http.post(Uri.parse("${_data.host}/auth/client"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'user': _data.user,
            'apiKey': _data.apiKey,
          }));
      stopwatch.stop();

      if (response.statusCode == 200) {
        return ConnectionDetails(
            connection: true,
            name: json.decode(response.body)["name"],
            clientVersion: packageInfo.version,
            serverVersion: json.decode(response.body)["serverVersion"],
            host: _data.host,
            user: _data.user,
            ping: "${stopwatch.elapsed} ms");
      } else {
        throw Exception('Failed to create Connection Details');
      }
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

  Future<String?> userData(_key) async {
    final String? data = await authStorage.read(key: _key);
    return data;
  }

  Future<int> loadUserData(_key) async {
    return await authclient(userData(_key));
  }

  Future<void> deleteUserData(_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await authStorage.deleteAll();
    await prefs.setBool('seen', false);
  }

  Future<void> saveUserData(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('seen', true);
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
  toString() => "{'host': '$host', 'user': '$user', 'password': '$apiKey'}";
}

class ConnectionDetails {
  final bool connection;
  final String name;
  final String host;
  final String user;
  final String ping;
  final String clientVersion;
  final String serverVersion;

  ConnectionDetails({
    required this.connection,
    required this.name,
    required this.clientVersion,
    required this.serverVersion,
    required this.host,
    required this.user,
    required this.ping,
  });

  factory ConnectionDetails.fromJson(Map<String, dynamic> json) {
    return ConnectionDetails(
      host: json['N/A'],
      user: json['N/A'],
      name: json['N/A'],
      clientVersion: 'clientVersion',
      connection: false,
      ping: "N/A",
      serverVersion: 'serverVersion',
    );
  }

  @override
  toString() =>
      "{'host': '$host', 'user': '$user', 'name': '$name', 'clientVersion': '$clientVersion', 'connection': '$connection', 'ping': '$ping', 'serverVersion': '$serverVersion'}";
}
