import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  final jsonResponse =
      await http.get(Uri.parse('http://192.168.13.25:4000/api'));
  print(jsonDecode(jsonResponse.body.toString()).toString());
}

class ConnectionData with ChangeNotifier{
  final AuthData _host = AuthData(host: "");
 

  Future<void> _loadUserData() async {
    await SharedPreferences.getInstance().then((prefs) {
      String host = prefs.getString(key)
    });
  }

  Future<void> _saveUserData() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString('192.168.13.25', _host.host);

    });
  }
}

class AuthData {
  final String host;

  AuthData({this.host = ''});

  AuthData.fromJson(Map<String, dynamic> json)
      : host = json['host'];

  Map<String, dynamic> toJson() => {
        'host': host,
      };
}
