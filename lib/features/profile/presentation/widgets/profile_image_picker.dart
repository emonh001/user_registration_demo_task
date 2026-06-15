import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Text(
          "Change Profile Photo",
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}