import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Log in",
              style: TextStyle(color: Colors.black)), // You can add title here

          backgroundColor:
              Colors.white.withOpacity(0), //You can make this transparent
          elevation: 0.0, //No shadow
        ),
        body: Builder(builder: (BuildContext context) {
          return Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Hostname / IP',
                        hintText: 'x.x.x.x',
                      ),
                      autocorrect: false,
                    )),
                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email/Username',
                      ),
                      autocorrect: false,
                    )),
                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border:  OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      autocorrect: false,
                      obscureText: true,
                    )),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Submit')))),
              ]);
        }));
  }
}
