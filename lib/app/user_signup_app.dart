import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';

import 'package:provider/provider.dart';

import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/bottom_nav_holder/presentation/screens/dashboard_shell.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

class UserSignupApp extends StatefulWidget {
  const UserSignupApp({super.key});

  @override
  State<UserSignupApp> createState() => _UserSignupAppState();
}

class _UserSignupAppState extends State<UserSignupApp> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AuthProvider>().loadSessionUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: _buildRoot(auth),
        );
      },
    );
  }

  Widget _buildRoot(AuthProvider auth) {
    switch (auth.status) {
      case AuthStatus.unknown:
        return const SplashScreen();

      case AuthStatus.authenticated:
        return const DashboardShell();

      case AuthStatus.unauthenticated:
        return const SignInScreen();
    }
  }
}