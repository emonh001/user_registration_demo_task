import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_signup/features/profile/presentation/screens/edit_profile_screen.dart';

import '../../../dashboard/presentation/screens/home_dashboard_screen.dart';
import '../providers/bottom_nav_provider.dart';

class DashboardShell extends StatelessWidget {
  const DashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, nav, _) {
        return Scaffold(
          body: IndexedStack(
            index: nav.currentIndex,
            children: const [
              HomeDashboardScreen(),
              EditProfileScreen(), // Profile screen later
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: nav.currentIndex,

            onTap: (index) {
              nav.changeIndex(index);
            },

            selectedItemColor: const Color(0xFF1E3A5F),
            unselectedItemColor: const Color(0xFF64748B),

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}