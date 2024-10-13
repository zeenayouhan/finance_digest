import 'package:flutter/material.dart';

import 'constants/theme/default_theme.dart';
import 'features/signup/screens/signup.dart';

void main() {
  runApp(const FinanceDigest());
}

class FinanceDigest extends StatelessWidget {
  const FinanceDigest({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getThemeDefault(),
      home: const SignupScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
