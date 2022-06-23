import 'package:ffmpeg_app/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'navigation_bar_controller.dart';
import 'package:after_layout/after_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'servers.dart';

void main() {
  const themeMode = ThemeMode.system;
  runApp(MyApp(theme: themeMode));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required ThemeMode theme})
      : _themeNotifier = ValueNotifier(theme),
        super(key: key);

  final ValueNotifier<ThemeMode> _themeNotifier;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    var routes = <String, WidgetBuilder>{
      AddServerMobile.routeName: (BuildContext context) =>
          const AddServerMobile(title: "AddServerMobile")
    };

    return MaterialApp(
      title: 'FFmmpeg App',
      home: const Splash(),
      theme: FlexThemeData.light(lightIsWhite: true, useMaterial3: true),
      darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.hippieBlue,
          darkIsTrueBlack: true,
          useMaterial3: true),
      routes: routes,
    );
  }

  void onThemeUpdate(ThemeMode themeMode) {
    _themeNotifier.value = themeMode;
    var brightness = SchedulerBinding.instance.window.platformBrightness;

    if (brightness == Brightness.dark) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomNavigationBarController()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(
          context,
          systemNavBarStyle: FlexSystemNavBarStyle.background,
          useDivider: false,
          opacity: 0,
        ),
        child: const Scaffold(
          body: Center(
            child: Text('Loading...'),
          ),
        ));
  }
}
