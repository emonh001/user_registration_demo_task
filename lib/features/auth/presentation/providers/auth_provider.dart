import 'package:flutter/material.dart';

import '../../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordHidden = true;

  bool get isLoading => _isLoading;
  bool get isPasswordHidden => _isPasswordHidden;

  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  Future<bool> signIn() async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) return false;

    _setLoading(true);

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final result = await _authRepository.signIn(
        email: email,
        password: password,
      );

      return result;
    } finally {
      _setLoading(false);
    }
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Email is required';
    }

    if (!email.contains('@')) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    final password = value?.trim() ?? '';

    if (password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}