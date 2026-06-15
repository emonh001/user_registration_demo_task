import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_session_datasource.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthLocalDataSource _local = AuthLocalDataSource();
  final AuthSessionDataSource _session = AuthSessionDataSource();

  // SIGN UP
  Future<bool> signUp(UserModel user) async {
    final id = await _local.registerUser(user);
    return id > 0;
  }

  // SIGN IN
  Future<UserModel?> signIn(String email, String password) async {
    final data = await _local.loginUser(email, password);

    if (data == null) return null;

    final user = UserModel.fromMap(data);

    // SAVE SESSION
    await _session.saveSession(user.id!);

    return user;
  }

  // GET CURRENT USER ID
  Future<int?> getCurrentUserId() {
    return _session.getUserId();
  }

  // GET USER FROM DB
  Future<UserModel?> getUserById(int id) async {
    final data = await _local.getUserById(id);
    if (data == null) return null;

    return UserModel.fromMap(data);
  }

  Future<bool> updateProfile(UserModel user) async {
    final result = await _local.updateUser(user);
    return result > 0;
  }

  // LOGOUT
  Future<void> logout() {
    return _session.logout();
  }
}