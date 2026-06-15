import 'package:flutter/material.dart';

class EditProfileProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

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

  Future<void> saveProfile() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    setLoading(true);

    // TODO: API / DB update here
    await Future.delayed(const Duration(milliseconds: 800));

    setLoading(false);
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