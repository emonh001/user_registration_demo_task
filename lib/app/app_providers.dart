import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/providers/sign_up_provider.dart';
import '../features/bottom_nav_holder/presentation/providers/bottom_nav_provider.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            repository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider<SignUpProvider>(
          create: (context) => SignUpProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}