import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_schools/src/auth/user.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  static const String _authTokenKey = 'auth_token';
  static const String _apiBasePath =
      'http://387e-2804-16c-646-6700-e511-7790-9d58-6c41.ngrok.io';

  User? _user;
  final _storage = const FlutterSecureStorage();

  User? get user {
    return _user;
  }

  Future initUser() async {
    _user = await userData();
  }

  Future login(String email, String password) async {
    final payload = {
      'email': email,
      'password': password,
      'device_name': 'mobile',
    };
    final response = await http.post(
      Uri.parse(
        '$_apiBasePath/api/auth/login',
      ),
      body: jsonEncode(payload),
      headers: await _header(false),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);

      await _storage.write(
        key: _authTokenKey,
        value: responseJson['data']['token'],
      );

      _user = await userData();
      notifyListeners();

      return true;
    }

    return false;
  }

  Future<User?> userData() async {
    final response = await http.get(
      Uri.parse(
        '$_apiBasePath/api/auth/user',
      ),
      headers: await _header(true),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);

      return User(
        name: responseJson['name'],
        login: responseJson['email'],
        isAdmin: responseJson['is_admin'] == 1 ? true : false,
      );
    }

    return null;
  }

  Future<bool> hasToken() async {
    String? authToken = await _storage.read(key: _authTokenKey);

    if (authToken != null) {
      return true;
    }

    return false;
  }

  Future logout() async {
    final response = await http.post(
      Uri.parse(
        '$_apiBasePath/api/auth/logout',
      ),
      headers: await _header(true),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao fazer logout ${response.body}');
    }

    _user = null;
    await _storage.delete(key: _authTokenKey);
  }

  Future<Map<String, String>> _header(bool isAuth) async {
    if (!isAuth) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }

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
}
