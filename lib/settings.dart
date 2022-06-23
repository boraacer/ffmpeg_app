import 'dart:convert';

import 'package:ffmpeg_app/actions.dart';
import 'package:flutter/material.dart';

import 'welcome_screen.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            Card(
                child: ListTile(
              title: const Text("Server Connection"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ServerConnection())),
            )),
            const Card(
              child: ListTile(
                title: Text("List Item 2"),
              ),
            ),
            Card(
                child: ListTile(
              title: const Text("Log out"),
              onTap: () {
                ConnectionData().deleteUserData("_AuthData");
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const WelcomeScreen()));
              },
            )),
          ],
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
        ));
  }
}

class ServerConnection extends StatefulWidget {
  const ServerConnection({Key? key}) : super(key: key);

  @override
  State<ServerConnection> createState() => _ServerConnectionState();
}

class _ServerConnectionState extends State<ServerConnection> {
  TextStyle? _textStyle;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = (brightness == Brightness.dark);
    final String data = ConnectionData().connectionDetails().toString();

    /// Update TextStyle depending on the theme
    if (isDarkMode) {
      _textStyle = const TextStyle(color: Colors.white);
    } else {
      _textStyle = const TextStyle(color: Colors.black);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Server Connection", style: _textStyle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white.withOpacity(0),
          elevation: 0.0,
        ),
        body: ListView(children: [
          SizedBox(
              height: 350,
              child: Card(
                margin: const EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Text(
                              "Connection and User Details",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "${json.decode(data)["connection"]}",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Text(
                          "Hello World, Text 1",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ]));
  }
}
