import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  // Constructor now accepts an optional SharedPreferences instance or Future.
  AuthService({Future<SharedPreferences>? sharedPreferences})
      : _sharedPreferences =
            sharedPreferences ?? SharedPreferences.getInstance();

  final Future<SharedPreferences> _sharedPreferences;
  static const String preferenceKey = 'financeDigest';

  Future<AuthenticationMetadata> getMetadata() async {
    final sharedPreferences = await _sharedPreferences;
    final isSignedUp =
        sharedPreferences.getBool(AuthenticationMetadata.isSignedUpKey) ??
            false;
    final firstName =
        sharedPreferences.getString(AuthenticationMetadata.firstNameKey) ?? '';
    final lastName =
        sharedPreferences.getString(AuthenticationMetadata.lastNameKey) ?? '';

    return AuthenticationMetadata(
      isSignedUp: isSignedUp,
      firstName: firstName,
      lastName: lastName,
    );
  }

  Future<void> signUp(String firstName, String lastName) async {
    try {
      final sharedPreferences = await _sharedPreferences;
      if (sharedPreferences.containsKey(preferenceKey)) {
        await sharedPreferences.clear();
      }
      await Future.wait([
        sharedPreferences.setBool(AuthenticationMetadata.isSignedUpKey, true),
        sharedPreferences.setString(
            AuthenticationMetadata.firstNameKey, firstName),
        sharedPreferences.setString(
            AuthenticationMetadata.lastNameKey, lastName),
      ]);

      notifyListeners(); // Notify listeners after sign-up
    } catch (e) {
      debugPrint("Failed to store the firstName and lastNAme");
    }
  }
}

class AuthenticationMetadata {
  AuthenticationMetadata({
    required this.isSignedUp,
    required this.firstName,
    required this.lastName,
  });

  final bool isSignedUp;
  final String firstName;
  final String lastName;

  static const String isSignedUpKey = 'auth.metadata.isSignedUp';
  static const String firstNameKey = 'auth.metadata.firstName';
  static const String lastNameKey = 'auth.metadata.lastName';
}
