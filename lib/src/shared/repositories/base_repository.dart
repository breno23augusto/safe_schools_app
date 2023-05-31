import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_schools/src/shared/settings/const_configs.dart';

abstract class BaseRepository {
  static const String _authTokenKey = 'auth_token';
  static const String apiBasePath = ConstConfigs.apiUrl;

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
