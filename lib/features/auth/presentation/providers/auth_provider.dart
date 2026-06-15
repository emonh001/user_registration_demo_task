import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  // -------------------------
  // FORM STATE
  // -------------------------
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordHidden = true;

  UserModel? _currentUser;

  bool get isLoading => _isLoading;
  bool get isPasswordHidden => _isPasswordHidden;
  UserModel? get currentUser => _currentUser;

  bool _initialized = false;
  bool get initialized => _initialized;

  // -------------------------
  // VALIDATION (FIXED)
  // -------------------------
  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) return "Email required";
    if (!email.contains("@")) return "Invalid email";

    return null;
  }

  String? validatePassword(String? value) {
    final pass = value?.trim() ?? '';

    if (pass.isEmpty) return "Password required";
    if (pass.length < 6) return "Min 6 characters";

    return null;
  }

  // -------------------------
  // UI STATE
  // -------------------------
  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  // -------------------------
  // SIGN IN LOGIC
  // -------------------------
  Future<bool> signIn() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return false;
    debugPrint("LOGIN STARTED");
    _setLoading(true);

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      debugPrint("LOGIN STARTED");
      debugPrint("EMAIL: $email");
      debugPrint("PASSWORD: $password");

      final user = await _repository.signIn(email, password);

      debugPrint("LOGIN RESULT: $user");

      _currentUser = user;

      return user != null;
    } catch (e) {
      debugPrint("LOGIN ERROR: $e");
      return false;
    } finally {
      _setLoading(false);
      debugPrint("LOADING STOPPED");
    }
  }

  // -------------------------
  // AUTO LOGIN SUPPORT
  // -------------------------
  Future<void> loadSessionUser() async {
    if (_initialized) return; // 🔥 prevent infinite loop

    _initialized = true;

    final userId = await _repository.getCurrentUserId();

    if (userId == null) {
      _currentUser = null;
      notifyListeners();
      return;
    }

    final user = await _repository.getUserById(userId);

    _currentUser = user;

    notifyListeners();
  }

  void logout() async {
    await _repository.logout();
    _currentUser = null;
    notifyListeners();
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}