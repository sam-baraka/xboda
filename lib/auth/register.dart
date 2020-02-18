import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xboda/uis/home.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //The controllers for the Email and Password
  var EmailController=TextEditingController();
  var PasswordController=TextEditingController();
  var FirstNameController=TextEditingController();
  var LastNameController=TextEditingController();
  var PhoneNumberController=TextEditingController();
  bool Loading=false;
  toggleLoadingState(){
    setState(() {
      Loading=!Loading;
    });
  }
  ///Register user
  ///This function returns a Firebase User
  Future<FirebaseUser> RegisterUser({String email, String password, String gender}) async{
    try{
      await toggleLoadingState();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      print("Registration successful");
      
      //Add the user to firestore
      await Firestore.instance.collection('users').add({
        'name': FirstNameController.text +" "+LastNameController.text,
        'gender' : gender,
        'phonenumber': PhoneNumberController.text
      });
      //Navigate then Change loading state to false
      Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context)=>Home()));
      await toggleLoadingState();
      Fluttertoast.showToast(
        msg: "Registration successful ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: CupertinoTheme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
      print("Add to users collection in firestore successful");
    }
    catch(e){
      await toggleLoadingState();
      Fluttertoast.showToast(
        msg: "Registration failed"+e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: CupertinoTheme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
      print("Registration failed:"+e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    bool male = false;
    bool female = false;
    void toggleGender() {
      setState(() {
        male = !male;
      });
    }

    return CupertinoPageScaffold(
      child: !Loading?CustomScrollView(slivers: <Widget>[
        CupertinoSliverNavigationBar(largeTitle: Text("Register")),
        SliverFillRemaining(
            child: ListView(
          children: <Widget>[
            Image.asset("assets/icon/icon.png",fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(
                  padding: const EdgeInsets.all(8.0),
                  textCapitalization: TextCapitalization.words,
                  placeholder: "First Name",
                  controller: FirstNameController,
                  prefix: Icon(CupertinoIcons.person),
                  suffix: CupertinoButton(
                    child: Icon(CupertinoIcons.info),
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                insetAnimationCurve: Curves.easeOutCirc,
                                title: Text("First Name"),
                                content:
                                    Text("Enter your first name in this field"),
                              ));
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(
                  textCapitalization: TextCapitalization.words,
                  padding: const EdgeInsets.all(8.0),
                  placeholder: "Last Name",
                  controller: LastNameController,
                  prefix: Icon(CupertinoIcons.person),
                  suffix: CupertinoButton(
                    child: Icon(CupertinoIcons.info),
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                insetAnimationCurve: Curves.easeOutCirc,
                                title: Text("Last Name"),
                                content:
                                    Text("Enter your first name in this field"),
                              ));
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(
                  keyboardType: TextInputType.emailAddress,
                  padding: const EdgeInsets.all(8.0),
                  placeholder: "Email",
                  controller: EmailController,
                  prefix: Icon(CupertinoIcons.mail),
                  suffix: CupertinoButton(
                    child: Icon(CupertinoIcons.info),
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                insetAnimationCurve: Curves.easeOutCirc,
                                title: Text("Email"),
                                content:
                                    Text("Enter your email in this field"),
                              ));
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(
                  keyboardType: TextInputType.visiblePassword,
                  padding: const EdgeInsets.all(8.0),
                  obscureText: true,
                  placeholder: "Password",
                  controller: PasswordController,
                  prefix: Icon(CupertinoIcons.padlock),
                  suffix: CupertinoButton(
                    child: Icon(CupertinoIcons.info),
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                insetAnimationCurve: Curves.easeOutCirc,
                                title: Text("Password"),
                                content:
                                    Text("Enter your password in this field"),
                              ));
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(
                  keyboardType: TextInputType.number,
                  padding: const EdgeInsets.all(8.0),
                  controller: PhoneNumberController,
                  placeholder: "Phone Number",
                  prefix: Icon(CupertinoIcons.phone),
                  suffix: CupertinoButton(
                    child: Icon(CupertinoIcons.info),
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                insetAnimationCurve: Curves.easeOutCirc,
                                title: Text("Phone Number"),
                                content: Text(
                                    "Enter your phone number in this field"),
                              ));
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[
                CupertinoSwitch(
                  value: male,
                  onChanged: (on) {
                    setState(() {
                      male = on;
                    });
                  },
                ),
                Expanded(child: Text("Male"))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[
                CupertinoSwitch(
                  value: female,
                  onChanged: (on) {
                    setState(() {
                      female = on;
                    });
                  },
                ),
                Expanded(child: Text("Female"))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(child: Text("Register"), onPressed: (){
                  RegisterUser(email:EmailController.text,password: PasswordController.text,gender:"Male");
                  //Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context)=>Home()));
              })
            ),
          ],
        ))
      ]):Center(child:CupertinoActivityIndicator(radius:20)),
    );
  }
}
