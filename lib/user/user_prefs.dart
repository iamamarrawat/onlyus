import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  // GET username
  static Future<String?> getUsername() async {
    final prefs = await getInstance();
    return prefs.getString('username');
  }

  // SET username
  static Future<bool> setUsername(String username) async {
    final prefs = await getInstance();
    return prefs.setString('username', username);
  }

  // SET login status
  static Future<bool> setUserLoggedIn(bool value) async {
    final prefs = await getInstance();
    return prefs.setBool('isUserLoggedIn', value);
  }

  // GET login status
  static Future<bool> isUserLoggedIn() async {
    final prefs = await getInstance();
    return prefs.getBool('isUserLoggedIn') ?? false;
  }
}
