import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:xboda/auth/register.dart';
import 'package:xboda/theme/theme.dart';
import 'package:xboda/uis/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// The controllers for the email and password
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  bool Loading = false;
  toggleLoadingState() {
    setState(() {
      Loading = !Loading;
    });
  }

  ///Login the user to the app
  ///This function returns a firebase User
  Future<FirebaseUser> LoginUser({String email, String password}) async {
    try {
      //Change loading state to true
      await toggleLoadingState();
      //Login the user
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //Navigate then Change loading state to false
      Navigator.push(context,
          CupertinoPageRoute(builder: (BuildContext context) => Home()));
      await toggleLoadingState();
      print("Login Successful");
      Fluttertoast.showToast(
          msg: "Login successful ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: CupertinoTheme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      await toggleLoadingState();
      Fluttertoast.showToast(
          msg: "Login failed:" + e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: CupertinoTheme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Login failed:" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: !Loading
          ? CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text("Login"),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                                title: Material(
                                  color: Colors.transparent,
                                      child: ListTile(
                                      leading:Image.asset(
                                          "assets/icon/icon.png",
                                          height: 50,
                                          fit: BoxFit.contain,
                                        ),
                                      title:Text("X-Boda",style: TextStyle(color: CupertinoTheme.of(context).primaryColor)),
                                      subtitle: Text("The Vercetti Corporation © 2019",style: TextStyle(color:CupertinoTheme.of(context).primaryContrastingColor),),
                                  ),
                                ),
                                message: Text("This app is property of the Vercetti Corporation. All terms and conditions apply"),
                              ));
                    },
                    child: Image.asset(
                      "assets/icon/icon.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverFillRemaining(
                    child: ListView(
                  children: <Widget>[
                    Image.asset(
                      "assets/icon/icon.png",
                      height: MediaQuery.of(context).size.width / 2,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoTextField(
                          controller: EmailController,
                          padding: const EdgeInsets.all(8.0),
                          placeholder: "Email",
                          prefix: Icon(CupertinoIcons.mail),
                          keyboardType: TextInputType.emailAddress,
                          suffix: CupertinoButton(
                            child: Icon(CupertinoIcons.info),
                            onPressed: () {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                        title: Text("Email"),
                                        content: Text(
                                            "Enter your email in this field"),
                                      ));
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoTextField(
                          controller: PasswordController,
                          obscureText: true,
                          padding: const EdgeInsets.all(8.0),
                          placeholder: "Password",
                          prefix: Icon(CupertinoIcons.padlock),
                          keyboardType: TextInputType.visiblePassword,
                          suffix: CupertinoButton(
                            child: Icon(CupertinoIcons.info),
                            onPressed: () {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                        title: Text("Password"),
                                        content: Text(
                                            "Enter your password in this field"),
                                      ));
                            },
                          )),
                    ),
                    CupertinoButton(
                        child: Text("Login to this app"),
                        onPressed: () {
                          LoginUser(
                              email: EmailController.text,
                              password: PasswordController.text);
                        }),
                    CupertinoButton(
                        child: Text("Don't have an account? Register here..."),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterPage()));
                        }),
                        CupertinoButton(
                        child: Icon(CupertinoIcons.heart, color:  Colors.red,),
                        onPressed: () {
                          Provider.of<ThemeManager>(context).changeTheme();
                          // Navigator.push(
                          //     context,
                          //     CupertinoPageRoute(
                          //         builder: (BuildContext context) =>
                          //             RegisterPage()));
                        })
                  ],
                ))
              ],
            )
          :
          //Loading indicator
          Center(
              child: CupertinoActivityIndicator(
              radius: 20,
            )),
    );
  }
}
