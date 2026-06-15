import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_signup/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:user_signup/shared/widgets/show_snack_bar_message.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_page_scaffold.dart';
import '../widgets/auth_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  Future<void> _handleSignIn(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();

    final isSuccess = await authProvider.signIn();

    if (!context.mounted) return;

    if (isSuccess) {

      showSnackBarMessage(context, 'Sign in successful');
      // TODO: Navigate to dashboard screen.
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (_) => const DashboardScreen(),
      //   ),
      // );
    } else {
      showSnackBarMessage(context, 'Invalid email or password');
    }
  }

  void _goToSignUp(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageScaffold(
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
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
                  key: authProvider.formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Sign In to continue',
                        style: TextStyle(
                          color: AppColors.mutedText,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 26),

                      AuthTextField(
                        label: 'Email Address',
                        hintText: 'name@company.com',
                        controller: authProvider.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: authProvider.validateEmail,
                        prefixIcon: Icon(Icons.email_outlined),
                      ),

                      const SizedBox(height: 18),

                      AuthTextField(
                        label: 'Password',
                        hintText: '••••••••',
                        controller: authProvider.passwordController,
                        obscureText: authProvider.isPasswordHidden,
                        textInputAction: TextInputAction.done,
                        validator: authProvider.validatePassword,
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: Icon(
                          authProvider.isPasswordHidden
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 18,
                        ),
                        suffixIconOnTap: authProvider.togglePasswordVisibility,
                      ),



                      const SizedBox(height: 15),

                      PrimaryButton(
                        text: 'Sign In',
                        icon: Icons.arrow_forward_rounded,
                        isLoading: authProvider.isLoading,
                        onPressed: () => _handleSignIn(context),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 13,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _goToSignUp(context),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.only(left: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}