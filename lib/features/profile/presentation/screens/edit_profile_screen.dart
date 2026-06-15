import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_signup/features/bottom_nav_holder/presentation/providers/bottom_nav_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/edit_profile_provider.dart';
import '../widgets/profile_image_picker.dart';
import '../widgets/profile_text_field.dart';
import '../widgets/save_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = EditProfileProvider(
          repository: context.read<AuthRepository>(),
        );

        final auth = context.read<AuthProvider>();
        final user = auth.currentUser;

        if (user != null) {
          provider.initData(
            name: user.fullName,
            email: user.email,
            phone: user.phone ?? "+8801",
            password: user.password
          );
        }

        return provider;
      },
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatelessWidget {
  const _EditProfileView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EditProfileProvider>();

    return Scaffold(
      backgroundColor: AppColors.neutral,

      appBar: AppBar(
        title: const Text("Edit Profile"),
        leading: Consumer<BottomNavProvider>(
          builder: (context, nav, child) {
            return IconButton(onPressed: (){
              nav.changeIndex(0);
            }, icon: Icon(Icons.arrow_back));
          }
        ),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.tertiary,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: provider.formKey,
            child: Column(
              children: [
                const ProfileImagePicker(),

                const SizedBox(height: 24),

                ProfileTextField(
                  label: "Full Name",
                  controller: provider.nameController,
                  validator: provider.validateName,
                ),

                const SizedBox(height: 14),

                ProfileTextField(
                  label: "Email Address",
                  controller: provider.emailController,
                  enabled: false,
                  suffix: const Icon(Icons.lock, size: 18),
                ),

                const SizedBox(height: 14),

                ProfileTextField(
                  label: "Phone Number",
                  controller: provider.phoneController,
                  validator: provider.validatePhone,
                ),
                const SizedBox(height: 14),
                ProfileTextField(
                  label: "Password",
                  controller: provider.passwordController,
                  hintText: "****",
                ),

                const SizedBox(height: 30),

                SaveButton(
                  isLoading: provider.isLoading,
                  onPressed: () {
                    final auth = context.read<AuthProvider>();

                    final userId = auth.currentUser?.id;

                    if (userId == null) return;

                    provider.saveProfile(userId);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}