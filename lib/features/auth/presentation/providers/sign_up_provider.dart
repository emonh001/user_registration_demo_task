import 'package:flutter/material.dart';

import '../../data/repositories/auth_repository.dart';

class SignUpProvider extends ChangeNotifier {
  SignUpProvider({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  bool get isLoading => _isLoading;
  bool get isPasswordHidden => _isPasswordHidden;
  bool get isConfirmPasswordHidden => _isConfirmPasswordHidden;

  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
    notifyListeners();
  }

  Future<bool> signUp() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return false;

    _setLoading(true);

    try {
      return await _authRepository.signUp(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } finally {
      _setLoading(false);
    }
  }

  String? validateFullName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Full name is required';
    }

    if (name.length < 3) {
      return 'Enter a valid full name';
    }

    return null;
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

  String? validateConfirmPassword(String? value) {
    final confirmPassword = value?.trim() ?? '';
    final password = passwordController.text.trim();

    if (confirmPassword.isEmpty) {
      return 'Confirm your password';
    }

    if (confirmPassword != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  void clearFields() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}