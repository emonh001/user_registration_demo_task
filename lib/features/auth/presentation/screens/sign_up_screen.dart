import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/sign_up_provider.dart';
import '../widgets/auth_shell_scaffold.dart';
import '../widgets/auth_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  Future<void> _handleSignUp(BuildContext context) async {
    final provider = context.read<SignUpProvider>();
    final success = await provider.signUp();

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully')),
      );

      // TODO: Navigate to dashboard screen or sign-in screen.
      Navigator.of(context).maybePop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the form errors')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthShellScaffold(
      child: Consumer<SignUpProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 14),
                const Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Join our professional community',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mutedText, fontSize: 13),
                ),
                const SizedBox(height: 22),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 22,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.04),
                        blurRadius: 14,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Form(
                    key: provider.formKey,
                    child: Column(
                      children: [
                        AuthTextField(
                          label: 'Full Name',
                          hintText: 'John Doe',
                          controller: provider.fullNameController,
                          textInputAction: TextInputAction.next,
                          validator: provider.validateFullName,
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            size: 20,
                            color: AppColors.mutedText,
                          ),
                        ),
                        const SizedBox(height: 16),

                        AuthTextField(
                          label: 'Email',
                          hintText: 'john@company.com',
                          controller: provider.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: provider.validateEmail,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 20,
                            color: AppColors.mutedText,
                          ),
                        ),
                        const SizedBox(height: 16),

                        AuthTextField(
                          label: 'Password',
                          hintText: '••••••••',
                          controller: provider.passwordController,
                          obscureText: provider.isPasswordHidden,
                          textInputAction: TextInputAction.next,
                          validator: provider.validatePassword,
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            size: 20,
                            color: AppColors.mutedText,
                          ),
                          suffixIcon: Icon(
                            provider.isPasswordHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 18,
                            color: AppColors.mutedText,
                          ),
                          suffixIconOnTap: provider.togglePasswordVisibility,
                        ),
                        const SizedBox(height: 16),

                        AuthTextField(
                          label: 'Confirm Password',
                          hintText: '••••••••',
                          controller: provider.confirmPasswordController,
                          obscureText: provider.isConfirmPasswordHidden,
                          textInputAction: TextInputAction.done,
                          validator: provider.validateConfirmPassword,
                          prefixIcon: const Icon(
                            Icons.verified_user_outlined,
                            size: 20,
                            color: AppColors.mutedText,
                          ),

                          suffixIcon: Icon(
                            provider.isConfirmPasswordHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 18,
                            color: AppColors.mutedText,
                          ),
                          suffixIconOnTap: provider.toggleConfirmPasswordVisibility,
                        ),
                        const SizedBox(height: 18),

                        PrimaryButton(
                          text: 'Sign Up',
                          icon: Icons.arrow_forward_rounded,
                          isLoading: provider.isLoading,
                          onPressed: () => _handleSignUp(context),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 13,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.only(left: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
