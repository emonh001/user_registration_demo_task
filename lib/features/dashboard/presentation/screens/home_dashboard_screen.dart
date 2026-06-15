import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/greeting_app_bar.dart';
import '../widgets/profile_card.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            GreetingAppBar(),

            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ProfileCard(),
            ),
          ],
        ),
      ),
    );
  }
}