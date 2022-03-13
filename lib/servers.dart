// ignore_for_file: unnecessary_const

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:io' show Platform;

class ServersPage extends StatefulWidget {
  const ServersPage(PageStorageKey<String> pageStorageKey, {Key? key})
      : super(key: key);

  @override
  _ServersPageState createState() => _ServersPageState();
}

class _ServersPageState extends State<ServersPage> {
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
            Navigator.pushNamed(context, AddServerMobile.routeName);
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddServerMobile extends StatefulWidget {
  const AddServerMobile({Key? key, required this.title}) : super(key: key);

  static const String routeName = "/AddServerMobile";

  final String title;

  @override
  _AddServerMobileState createState() => _AddServerMobileState();
}

class _AddServerMobileState extends State<AddServerMobile> {
  TextEditingController _hostControl = new TextEditingController();
  TextEditingController _apikeyControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Server",
              style: TextStyle(color: Colors.black)), // You can add title here
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Hostname / IP',
                        hintText: 'x.x.x.x',
                      ),
                      controller: _hostControl,
                      autocorrect: false,
                    )),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'API Key',
                        hintText: 'xxxxxxx-xxxxxxx-xxxxxxx-xxxxxxx',
                      ),
                      controller: _apikeyControl,
                      autocorrect: false,
                    )),
                Row(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: ElevatedButton(
                              onPressed: () {
                                scanQR();
                              },
                              child: const Text('QR Code')))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text('Submit')))),
                ]),
              ]);
        }));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      Map<String, dynamic> jsonMap = jsonDecode(barcodeScanRes);
      _hostControl.text = Json.fromJson(jsonMap).host;
      _apikeyControl.text = Json.fromJson(jsonMap).apikey;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    return jsonDecode(barcodeScanRes);
  }
}

class Json {
  final String host;
  final String apikey;

  Json(this.host, this.apikey);

  Json.fromJson(Map<String, dynamic> json)
      : host = json['host'],
        apikey = json['apikey'];

  Map<String, dynamic> toJson() => {
        'host': host,
        'apikey': apikey,
      };
}
