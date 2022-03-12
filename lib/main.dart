import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navigation_bar_controller.dart';

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
  
  
    return const MaterialApp(
      title: 'FFmmpeg App',
      home: BottomNavigationBarController(),
      
    );
  }
}