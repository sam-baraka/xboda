import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:xboda/preferences/auth_preferences.dart';
import 'package:xboda/uis/home.dart';
import 'package:xboda/uis/launch_screen.dart';


Future<void> main() async {
  ///Get the instance of App preferences
  XbodaAuthPreferences xbodaAuthPreferences;
  var loggedIn = await xbodaAuthPreferences.getAppAuthState();
  runApp(MyApp(
    loggedIn: loggedIn,
  ));
}

class MyApp extends StatefulWidget {
  final bool loggedIn;

  const MyApp({Key key, this.loggedIn}) : super(key: key);
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool dark = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.teal,
        ),
        // theme: theme,
        title: 'X-Boda',
        home: !widget.loggedIn ? LaunchScreen() : Home());
  }
}
