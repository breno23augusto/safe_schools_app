import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class BaseRepository {
  static const String _authTokenKey = 'auth_token';
  static const String apiBasePath = 'http://localhost:8088';

  final _storage = const FlutterSecureStorage();

  Future<Map<String, String>> header(bool isAuth) async {
    if (isAuth) {
      String? authToken = await _storage.read(key: _authTokenKey);

      if (authToken == null) {
        throw Exception('Not Logged.');
      }

      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      };
    }

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}
