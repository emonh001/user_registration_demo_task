import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class GreetingAppBar extends StatelessWidget {
  const GreetingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Hello, Alex 👋",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.tertiary,
              ),
            ),
          ),

          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Icon(
              Icons.person,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}