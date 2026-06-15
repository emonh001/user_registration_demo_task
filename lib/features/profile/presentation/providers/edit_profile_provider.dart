import 'package:flutter/material.dart';
import 'package:user_signup/features/auth/data/repositories/auth_repository.dart';

import '../../../auth/data/models/user_model.dart';

class EditProfileProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final AuthRepository _repository;
  EditProfileProvider({required AuthRepository repository})
      : _repository = repository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void initData({
    required String name,
    required String email,
    required String phone,
  }) {
    nameController.text = name;
    emailController.text = email;
    phoneController.text = phone;
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
      final updatedUser = UserModel(
        id: userId,
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        password: "", // keep unchanged or fetch from DB later
        phone: phoneController.text.trim(),
        createdAt: DateTime.now().toIso8601String(),
      );

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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}