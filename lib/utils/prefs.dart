import 'package:shared_preferences/shared_preferences.dart';



/// Single wrapper for shared preferences.
class Prefs {

  static const THEME  = "preferences_app_theme";
  static const  AUTH_TOKEN= 'preferences_auth_token';

  static const int THEME_LIGHT = 0;
  static const int THEME_DARK = 1;
  static const int THEME_AUTO = 2;


  static Prefs _instance = new Prefs.internal();
  Prefs.internal();
  factory Prefs() => _instance;



  Future<String> getToken() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return  _sharedPreferences.getString(AUTH_TOKEN);
  }

  Future<bool> saveToken(String token) async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setString(AUTH_TOKEN, token);
  }

  Future<int> getTheme() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return  _sharedPreferences.getInt(THEME);
  }

  Future<void> setTheme(int theme) async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    if(theme == THEME_LIGHT || theme == THEME_DARK || theme == THEME_AUTO)
      return _sharedPreferences.setInt(THEME, theme);
    else return null;
  }

}