import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  AuthService();
  final _sharedPreferences = SharedPreferences.getInstance();
  static const String preferenceKey = 'financeDigest';

  Future<AuthenticationMetadata> getMetadata() async {
    final sharedPreferences = await _sharedPreferences;
    final isSignedUp = sharedPreferences.getBool(
      AuthenticationMetadata.isSignedUpKey,
    );
    final firstName = sharedPreferences.getString(
      AuthenticationMetadata.firstNameKey,
    );
    final lastName = sharedPreferences.getString(
      AuthenticationMetadata.lastNameKey,
    );
    print({isSignedUp, lastName, firstName});

    return AuthenticationMetadata(
      isSignedUp: isSignedUp,
      firstName: firstName,
      lastName: lastName,
    );
  }

  Future signUp(
    String firstName,
    String lastName,
  ) async {
    final sharedPreferences = await _sharedPreferences;
    if (sharedPreferences.containsKey(preferenceKey)) {
      sharedPreferences.clear();
    }
    await Future.wait([
      sharedPreferences.setBool(
        AuthenticationMetadata.isSignedUpKey,
        true,
      ),
      sharedPreferences.setString(
        AuthenticationMetadata.firstNameKey,
        firstName,
      ),
      sharedPreferences.setString(
        AuthenticationMetadata.lastNameKey,
        lastName,
      ),
    ]);
  }
}

class AuthenticationMetadata {
  AuthenticationMetadata({
    this.isSignedUp,
    this.firstName,
    this.lastName,
  });

  final bool? isSignedUp;
  final String? firstName;
  final String? lastName;

  static String isSignedUpKey = 'auth.metadata.isSignedUp';
  static String firstNameKey = 'auth.metadata.firstName';
  static String lastNameKey = 'auth.metadata.lastName';
}
