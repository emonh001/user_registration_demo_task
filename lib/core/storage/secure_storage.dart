import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static const String _keyUserId = "user_id";
  static const String _keyIsLoggedIn = "is_logged_in";

  Future<void> saveLoginSession(int userId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(_keyUserId, userId);
    await prefs.setBool(_keyIsLoggedIn, true);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}