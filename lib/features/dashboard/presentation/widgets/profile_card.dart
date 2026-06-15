import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../bottom_nav_holder/presentation/providers/bottom_nav_provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Alex Smith",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.tertiary,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            "alex.smith@example.com",
            style: TextStyle(
              fontSize: 13,
              color: AppColors.mutedText,
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: 120,
            height: 36,
            child: Consumer<BottomNavProvider>(
              builder: (context, nav, child) {
                return ElevatedButton(
                  onPressed: () {
                    nav.changeIndex(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 12),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}