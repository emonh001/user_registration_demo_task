import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/edit_profile_provider.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EditProfileProvider>();

    final imagePath = provider.imagePath;


    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundImage: (imagePath != null && imagePath.isNotEmpty)
                  ? FileImage(File(imagePath))
                  : const AssetImage("assets/images/profile.jpg")
              as ImageProvider,
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // ONLY EDIT ACTION (NO UI CHANGE HERE)
                  provider.pickFromGallery();
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Text(
          "Profile Photo",
          style: TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}