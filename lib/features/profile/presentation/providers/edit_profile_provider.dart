import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:user_signup/features/auth/data/repositories/auth_repository.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/profile_image_service.dart';

class EditProfileProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final Function(UserModel user) onUserUpdated;

  final AuthRepository _repository;


  EditProfileProvider({
    required AuthRepository repository,
    required this.onUserUpdated,
  }) : _repository = repository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final ProfileImageService _imageService = ProfileImageService();

  String? _imagePath;
  String? get imagePath => _imagePath;

  void initData({
    required String name,
    required String email,
    required String phone,
    required String password,
    String? imagePath
  }) {
    nameController.text = name;
    emailController.text = email;
    phoneController.text = phone;
    passwordController.text = password;
    _imagePath = imagePath;
    passwordController.clear();
  }

  Future<void> pickFromGallery() async {
    final file = await _imageService.pickFromGallery();
    if (file == null) return;

    final path = await _imageService.saveToLocalDirectory(file);

    setImagePath(path);
  }

  Future<void> captureFromCamera() async {
    final file = await _imageService.captureFromCamera();
    if (file == null) return;

    final path = await _imageService.saveToLocalDirectory(file);

    setImagePath(path);
  }

  void setImagePath(String path) {
    _imagePath = path;
    notifyListeners();
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
      final existingUser = await _repository.getUserById(userId);
      if (existingUser == null) return false;

      final newPassword = passwordController.text.trim();

      final finalPassword = newPassword.isNotEmpty
          ? newPassword
          : existingUser.password;

      final finalImagePath = _imagePath ?? existingUser.imagePath;

      final updatedUser = UserModel(
        id: userId,
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: finalPassword,
        imagePath: finalImagePath,
        createdAt: existingUser.createdAt,
      );

      await _repository.updateProfile(updatedUser);
      final refreshedUser = await _repository.getUserById(userId);
      if (refreshedUser != null) {
        onUserUpdated(refreshedUser);
      }


      return true;
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