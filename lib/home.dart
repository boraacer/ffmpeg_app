import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("FFmpeg Manager"),
          elevation: 0.0,
        ),
        body: ListView(children: [
          SizedBox(
              height: 350,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Expanded(
                            child: Text(
                          "Hello World, Text 1",
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ],
                ),
              ))
        ]));
  }
}

class ExtendedServerWidget extends StatelessWidget {
  const ExtendedServerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
    );
  }
}
