import 'package:shared_preferences/shared_preferences.dart';

class XbodaAuthPreferences {
  //Login preferences
  String loggedInKey = "LoggedIn";
  //App state logged in

  void setLoggedIn() async {
    //Declare the instance of shared preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Set the logged in state to be true
    await preferences.setBool(loggedInKey, true);
  }

  //App state logged oout
  void setLoggedOut() async {
    //Declare the instance of shared preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Set the logged in state to be false
    await preferences.setBool(loggedInKey, false);
  }

  //Get the logged in state
  Future<bool> getAppAuthState() async {
    //Declare the instance of shared preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //get the state
    var state=await preferences.getBool(loggedInKey);
    if(state!=null)
    return state;
    else
    return false;
  }
}
