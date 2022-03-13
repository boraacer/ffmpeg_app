import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navigation_bar_controller.dart';
import 'servers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white10,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    var routes = <String, WidgetBuilder>{
      AddServerMobile.routeName: (BuildContext context) =>
          const AddServerMobile(title: "AddServerMobile")
    };

    return MaterialApp(
      title: 'FFmmpeg App',
      home: const BottomNavigationBarController(),
      routes: routes,
    );
  }
}
