import 'package:shared_preferences/shared_preferences.dart';
class HelperFunction{
  static String sharedPreferenceUserLoggedInKey='ISLOGGEDIN';
  static String sharedPreferenceUserNameKey='USERNAMEKEY';
  static String sharedPreferenceUserEmailKey='USEREMAILKEY';

  static Future<bool> saveuserLoggedInSharedPreference(
      bool isUserLoggedIn)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey
    ,isUserLoggedIn);
  }

  static Future<bool> saveuserNameSharedPreference(
     String userName)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey
        ,userName);
  }

  static Future<bool> saveuserEmailSharedPreference(
      String userEmail)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey
        ,userEmail);
  }

  ////getting data from sharedPreference
  static Future<bool> getuserLoggedInSharedPreference()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return  prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getuserNameSharedPreference()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getuserEmailInSharedPreference()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserEmailKey);
  }

}