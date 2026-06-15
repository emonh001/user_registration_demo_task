import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AuthShellScaffold extends StatelessWidget {
  const AuthShellScaffold({
    super.key,
    required this.child,
    this.onBackPressed,
  });

  final Widget child;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: onBackPressed ?? () => Navigator.of(context).maybePop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
