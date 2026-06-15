class AuthRepository {
  const AuthRepository();

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    // TODO: Replace this with your SQLite login logic from DbHelper.
    await Future.delayed(const Duration(milliseconds: 600));

    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<bool> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    // TODO: Replace with SQLite insert logic.
    await Future.delayed(const Duration(milliseconds: 700));
    return fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
  }
}