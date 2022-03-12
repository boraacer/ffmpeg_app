// ignore: file_names
import 'package:flutter/material.dart';

class StreamPage extends StatelessWidget {
  const StreamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Strean Screen"),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: const Text('Strean'),
          subtitle: Text('$index'),
        );
      }),
    );
  }
}