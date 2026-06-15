import 'package:flutter/material.dart';

import 'app_providers.dart';
import 'user_signup_app.dart';

void bootstrap() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const AppProviders(
      child: UserSignupApp(),
    ),
  );
}