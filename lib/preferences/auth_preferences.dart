import 'package:shared_preferences/shared_preferences.dart';

class XbodaAuthPreferences {
  //Login preferences
  static String loggedInKey = "LoggedIn";

  Object get LoggedInKey => loggedInKey;
  //App state logged in

  static void setLoggedIn() async {
    //Declare the instance of shared preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Set the logged in state to be true
    preferences.setBool(loggedInKey, true);
    print("Set user logged in state to true");
  }

  //App state logged out
  static void setLoggedOut() async {
    //Declare the instance of shared preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Set the logged in state to be false
    await preferences.setBool(loggedInKey, false);
    print("Set user logged out state to true");
  }

  //Get the logged in state
  static Future<bool> getAppAuthState() async {
    try{
    //Declare the instance of shared preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //get the state
    var state=await preferences.getBool(loggedInKey);
    if(state!=null)
    return state;
    else
    return false;
    }
    catch(e){
      print(e);
      return false;
    }
  }
}
