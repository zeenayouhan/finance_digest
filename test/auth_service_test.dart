import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finance_digest/features/signup/services/auth_service.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late AuthService authService;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    authService =
        AuthService(sharedPreferences: Future.value(mockSharedPreferences));
  });

  group('AuthService - getMetadata', () {
    test(
        'should return correct AuthenticationMetadata when preferences are set',
        () async {
      // Arrange
      when(mockSharedPreferences.getBool(AuthenticationMetadata.isSignedUpKey))
          .thenReturn(true);
      when(mockSharedPreferences.getString(AuthenticationMetadata.firstNameKey))
          .thenReturn('Blott');
      when(mockSharedPreferences.getString(AuthenticationMetadata.lastNameKey))
          .thenReturn('Studio');

      // Act
      final metadata = await authService.getMetadata();

      // Assert
      expect(metadata.isSignedUp, true);
      expect(metadata.firstName, 'Blott');
      expect(metadata.lastName, 'Studio');
    });

    test('should return default values when preferences are not set', () async {
      // Arrange
      when(mockSharedPreferences.getBool('metadata.isSignedUp'))
          .thenReturn(null);
      when(mockSharedPreferences.getString('metadata.firstName'))
          .thenReturn(null);

      // Act
      final metadata = await authService.getMetadata();

      // Assert
      expect(metadata.isSignedUp, false);
      expect(metadata.firstName, '');
      expect(metadata.lastName, '');
    });
  });
}
