import 'package:flutter/material.dart';
import 'actions.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String host = "";
  String user = "";
  String password = "";
  Future<AuthData>? _authResponse;


  Future<void> _submit() async {
    _authResponse = ConnectionData().authDevice(host, user, password);
    _authResponse!.then((value) => ConnectionData().saveUserData(value));
  }

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
          return Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Hostname / IP',
                            hintText: 'x.x.x.x',
                          ),
                          keyboardType: TextInputType.url,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter host or IP Address';
                            }
                            host = value;
                            return null;
                          },
                          onChanged: (value) => setState(() => host = value),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email/Username',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {
                            setState(() {
                              user = value;
                            });
                          },
                          onChanged: (value) => setState(() => user = value),
                          autocorrect: false,
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          obscureText: true,
                          onFieldSubmitted: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          onChanged: (value) =>
                              setState(() => password = value),
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: ElevatedButton(
                                onPressed: _submit,
                                child: const Text('Submit')))),
                  ]));
        }));
  }
}
