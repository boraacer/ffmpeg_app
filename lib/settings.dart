import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Screen", style: TextStyle(
    color: Colors.black
  )),
        backgroundColor:
            Colors.white.withOpacity(0), //You can make this transparent
        elevation: 0.0,
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: const Text('SettingsPage'),
          subtitle: Text('$index'),
        );
      }),
    );
  }
}