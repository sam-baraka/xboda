import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:xboda/auth/login.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  // timer for the animations
  Timer _everySecond;
  double topPositioned;
  double leftButtonPositioned = 0;
  double textOpacity;
  //=-500;

  @override
  void initState() {
    try {
      topPositioned = -400;
      textOpacity = 0;
      _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          if (topPositioned != 20 && textOpacity != 1) {
            topPositioned = 30;
            textOpacity = 1;
          } else {
            topPositioned = 10;
            textOpacity = 0;
          }
        });
      });
    } catch (e) {
      return e[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Stack(children: <Widget>[
      AnimatedPositioned(
        curve: Curves.easeInOutSine,

        ///Left and right set to a similar value to center the widget
        left: 0,
        right: 0,
        top: topPositioned,
        //The duration in animation
        duration: Duration(seconds: 1),
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          child: Image.asset(
            "assets/icon/icon.png",
            height: MediaQuery.of(context).size.width,
            fit: BoxFit.contain,
          ),
        ),
      ),
      Positioned(
        right: 0,
        left: 0,
        bottom: 20,
        child: AnimatedOpacity(
            opacity: textOpacity,
            duration: Duration(seconds: 1),
            child: Text(
              "Welcome to X-Boda © 2019",
              textAlign: TextAlign.center,
            )),
      ),
      AnimatedPositioned(
        duration: Duration(seconds: 1),
        top: MediaQuery.of(context).size.width / 2 + 20,
        bottom: 0,
        left: 0,
        right: 0,
        child: CupertinoButton(
          pressedOpacity: 0,
          onPressed: () async {
            await setState(() {
              //topPositioned=-500;
            });
            await setState(() {
              leftButtonPositioned = -500;
            });
            await Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          },
          child: Text(
            "Proceed to use the app!!!",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      Positioned(
          top: 20,
          left: 10,
          child: CupertinoButton(
              child: Icon(CupertinoIcons.info),
              onPressed: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoPopupSurface(
                          isSurfacePainted: false,
                          child: ListView(
                            children: <Widget>[
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                              Text("About X-Boda"),
                            ],
                          ),
                        ));
              })),
    ]));
  }
}
