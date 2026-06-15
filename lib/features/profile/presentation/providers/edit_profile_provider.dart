import 'package:flutter/material.dart';
import 'package:user_signup/features/auth/data/repositories/auth_repository.dart';

import '../../../auth/data/models/user_model.dart';

class EditProfileProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthRepository _repository;
  EditProfileProvider({required AuthRepository repository})
      : _repository = repository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void initData({
    required String name,
    required String email,
    required String phone,
    required String password
  }) {
    nameController.text = name;
    emailController.text = email;
    phoneController.text = phone;
    passwordController.text = password;
    passwordController.clear();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> saveProfile(int userId) async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return false;

    setLoading(true);

    try {
      // 1. GET EXISTING USER
      final existingUser = await _repository.getUserById(userId);

      if (existingUser == null) return false;

      // 2. CHECK PASSWORD INPUT
      final newPassword = passwordController.text.trim();

      final finalPassword = newPassword.isNotEmpty
          ? newPassword
          : existingUser.password;

      // 3. BUILD UPDATED USER
      final updatedUser = UserModel(
        id: userId,
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),

        // 🔥 SMART PASSWORD HANDLING
        password: finalPassword,

        createdAt: existingUser.createdAt,
      );

      // 4. UPDATE DB
      final result = await _repository.updateProfile(updatedUser);

      return result;
    } finally {
      setLoading(false);
    }
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone is required";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}