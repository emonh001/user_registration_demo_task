import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_signup/features/bottom_nav_holder/presentation/providers/bottom_nav_provider.dart';

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

          Consumer<BottomNavProvider>(
            builder: (context, nav, child) {
              return GestureDetector(
                onTap: (){
                  nav.changeIndex(1);
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primary,
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}