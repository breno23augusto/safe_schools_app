import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_schools/src/shared/enums/states.dart';
import 'package:http/http.dart' as http;

class SchoolRepository {
  static const String _apiBasePath =
      'http://56c1-2804-16c-646-6700-6807-546e-d7c2-ff31.ngrok.io';
  static const String _authTokenKey = 'auth_token';

  final _storage = const FlutterSecureStorage();

  Future<Map<int, String>> index(States state) async {
    // final response = await http.get(
    //   Uri.parse(
    //     "$_apiBasePath/api/schools?state=$state",
    //   ),
    //   headers: await _header(),
    // );

    // if (response.statusCode != 200) {
    //   return {};
    // }

    // final responseJson = jsonDecode(response.body);
    Map<int, String> output = {};
    // for (var i = 0; i < responseJson["data"].length; i++) {
    //   output[responseJson["data"][i]["id"]] = responseJson["data"][i]["name"];
    // }
    output[1] = "Escola Maluca";

    return output;
  }

  Future<Map<String, String>> _header() async {
    String? authToken = await _storage.read(key: _authTokenKey);

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
  }
}