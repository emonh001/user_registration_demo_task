import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/presentation/providers/auth_provider.dart';

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

        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}