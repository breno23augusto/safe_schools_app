import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_schools/src/complaint/entities/complaint.dart';
import 'package:http/http.dart' as http;

class ComplaintRepository {
  static const String _apiBasePath =
      'http://56c1-2804-16c-646-6700-6807-546e-d7c2-ff31.ngrok.io';
  static const String _authTokenKey = 'auth_token';

  final _storage = const FlutterSecureStorage();

  Future<bool> store(Complaint complaint) async {
    final payload = {
      "school_Id": complaint.schoolId,
      "organization_id": complaint.organizationId,
      "description": complaint.description,
      "is_anonymous": complaint.isAnonymous,
    };

    final response = await http.post(
      Uri.parse(
        '$_apiBasePath/api/complaints',
      ),
      body: jsonEncode(payload),
      headers: await _header(),
    );

    return response.statusCode != 201;
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