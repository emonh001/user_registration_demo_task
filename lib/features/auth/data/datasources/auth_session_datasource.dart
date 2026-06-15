import '../../../../core/storage/secure_storage.dart';

class AuthSessionDataSource {
  final SecureStorage _storage = SecureStorage();

  Future<void> saveSession(int userId) {
    return _storage.saveLoginSession(userId);
  }

  Future<bool> isLoggedIn() {
    return _storage.isLoggedIn();
  }

  Future<int?> getUserId() {
    return _storage.getUserId();
  }

  Future<void> logout() {
    return _storage.clearSession();
  }
}