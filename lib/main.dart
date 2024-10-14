import 'package:finance_digest/features/signup/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/routes/routes.dart';
import 'constants/theme/default_theme.dart';
import 'features/home/screens/home_screen.dart';
import 'features/signup/screens/signup_screen.dart';
import 'features/signup/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures initialization of plugins, such as SharedPreferences.

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isSignedUp =
      prefs.getBool(AuthenticationMetadata.isSignedUpKey) ?? false;

  runApp(FinanceDigest(isSignedUp: isSignedUp));
}

class FinanceDigest extends StatelessWidget {
  const FinanceDigest({super.key, required this.isSignedUp});

  final bool isSignedUp;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getThemeDefault(),
      initialRoute: isSignedUp ? Routes.home : Routes.signup,
      routes: {
        Routes.signup: (context) => const SignupScreen(),
        Routes.notification: (context) => const NotificationsScreen(),
        Routes.home: (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
