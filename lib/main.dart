import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:xboda/auth/login.dart';
import 'package:xboda/theme/theme.dart';
import 'package:xboda/uis/home.dart';
import 'package:xboda/uis/launch_screen.dart';

import 'auth/utilities/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool dark = false;
  @override
  Widget build(BuildContext context) {
    return 
    // MultiProvider(

    //     ///This is the list of all the providers needed in the app
    //     providers: [
    //       // Make user stream available
    //       StreamProvider<FirebaseUser>.value(
    //           value: FirebaseAuth.instance.onAuthStateChanged),
    //       Provider.value(value: ThemeManager()),
    //       StreamProvider<CupertinoThemeData>.value(
    //           value: Provider.of<ThemeManager>(context, listen: false).theme)
    //     ],
    //     child: 
    //     Consumer<CupertinoThemeData>(
    //       builder: (context, theme, child) =>
           CupertinoApp(
              theme: CupertinoThemeData(
                brightness: Brightness.dark,
                primaryColor: CupertinoColors.activeBlue,
                primaryContrastingColor: CupertinoColors.opaqueSeparator,
              ),
              // theme: theme,
              title: 'X-Boda',
              home: Home());
        // ));
  }
}


