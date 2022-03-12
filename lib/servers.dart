import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class ServersPage extends StatelessWidget {
  const ServersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servers", style: TextStyle(color: Colors.black)),
        backgroundColor:
            Colors.white.withOpacity(0), //You can make this transparent
        elevation: 0.0,
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: const Text('Lorem Ipsum'),
          subtitle: Text('$index'),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Platform.isAndroid || Platform.isIOS) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddServerMobile()));
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddServerMobile extends StatelessWidget {
  const AddServerMobile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''), // You can add title here
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor:
            Colors.white.withOpacity(0), //You can make this transparent
        elevation: 0.0, //No shadow
      ),
    );
  }


}
