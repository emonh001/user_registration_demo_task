import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_session_datasource.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthLocalDataSource _local = AuthLocalDataSource();
  final AuthSessionDataSource _session = AuthSessionDataSource();

  Future<bool> signUp(UserModel user) async {
    final id = await _local.registerUser(user);
    return id > 0;
  }

  Future<UserModel?> signIn(String email, String password) async {
    final data = await _local.loginUser(email, password);

    if (data == null) return null;

    final user = UserModel.fromMap(data);

    await _session.saveSession(user.id!);

    return user;
  }

  Future<UserModel?> getUserById(int id) async {
    final data = await _local.getUserById(id);
    if (data == null) return null;

    return UserModel.fromMap(data);
  }

  Future<bool> updateProfile(UserModel user) async {
    final result = await _local.updateUser(user);
    return result > 0;
  }

  Future<int?> getCurrentUserId() {
    return _session.getUserId();
  }

  Future<void> logout() {
    return _session.logout();
  }
}