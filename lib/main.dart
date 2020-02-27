import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:xboda/preferences/auth_preferences.dart';
import 'package:xboda/uis/home.dart';
import 'package:xboda/uis/launch_screen.dart';

Future<void> main() async {
  ///Run the app according to logged in preferences
  try {
    var loggedIn = await XbodaAuthPreferences.getAppAuthState();
    print("App launch success");
    //If the user is logged in
    if (loggedIn) {
      print("User logged in");
      runApp(CupertinoApp(
          theme: CupertinoThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.teal,
          ),
          // theme: theme,
          title: 'X-Boda',
          home: Home()));
    }
    //If the app is not logged in
    else {
      print("App not logged in");
      runApp(CupertinoApp(
          theme: CupertinoThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.teal,
          ),
          // theme: theme,
          title: 'X-Boda',
          home: LaunchScreen()));
    }
  } catch (e) {
    print("App launch failed");

    runApp(CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.teal,
        ),
        // theme: theme,
        title: 'X-Boda',
        home: LaunchScreen()));
  }
}
