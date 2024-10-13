import 'package:http/http.dart' as http;

import '../features/signup/services/auth_service.dart';

class BackendService {
  const BackendService({required this.authService});
  final AuthService authService;

  String _getHost() {
    return const String.fromEnvironment('HOST_NAME',
        defaultValue: 'https://finnhub.io/api');
  }

  Future<Map<String, String>> _getHeaders({bool authenticated = true}) async {
    final headers = <String, String>{'Content-Type': 'application/json'};
    return headers;
  }

  Future<http.Response> get(String path,
      {bool authenticated = true, Map<String, String>? headers}) async {
    var headers0 = await _getHeaders(authenticated: authenticated);
    if (headers != null) {
      headers0 = {...headers0, ...headers};
    }

    final uri = Uri.parse('${_getHost()}$path');
    print(uri);
    return http.get(uri, headers: headers0);
  }
}

class NotAuthenticatedException extends http.ClientException {
  NotAuthenticatedException(super.message);
}
