import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_schools/src/shared/settings/const_configs.dart';
import 'package:http/http.dart' as http;

class ReportsRepository {
  static const String _authTokenKey = 'auth_token';
  static const String _apiBasePath = ConstConfigs.apiUrl;
  final _storage = const FlutterSecureStorage();

  Future<List<AmountPerClassification>> amountPerClassification(
      int year) async {
    final response = await http.get(
      Uri.parse(
        '$_apiBasePath/api/reports/amountPerClassification/$year',
      ),
      headers: await _header(),
    );

    if (response.statusCode != 200) {
      throw Exception("Falha ao buscar o relatório.");
    }

    var mapedResponse = jsonDecode(response.body);

    List<AmountPerClassification> output = [];
    for (var i = 0; i < mapedResponse.length; i++) {
      output.add(
        AmountPerClassification(
          classification: mapedResponse[i]["classification"] ?? "default",
          total: mapedResponse[i]["total"],
        ),
      );
    }

    return output;
  }

  Future<List<AmountPerMonth>> amountPerMonth(int year) async {
    final response = await http.get(
      Uri.parse(
        '$_apiBasePath/api/reports/amountPerMonth/$year',
      ),
      headers: await _header(),
    );

    if (response.statusCode != 200) {
      throw Exception("Falha ao buscar o relatório.");
    }

    var mapedResponse = jsonDecode(response.body);

    List<AmountPerMonth> output = [];
    for (var i = 0; i < mapedResponse.length; i++) {
      output.add(
        AmountPerMonth(
          month: mapedResponse[i]["month"],
          total: mapedResponse[i]["total"],
        ),
      );
    }

    return output;
  }

  Future<List<AmountPerSchool>> amountPerSchool(int year) async {
    final response = await http.get(
      Uri.parse(
        '$_apiBasePath/api/reports/amountPerSchool/$year',
      ),
      headers: await _header(),
    );

    if (response.statusCode != 200) {
      throw Exception("Falha ao buscar o relatório.");
    }

    var mapedResponse = jsonDecode(response.body);

    List<AmountPerSchool> output = [];
    for (var i = 0; i < mapedResponse.length; i++) {
      output.add(
        AmountPerSchool(
          school: mapedResponse[i]["name"],
          total: mapedResponse[i]["total"],
        ),
      );
    }

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

class AmountPerClassification {
  final String classification;
  final int total;

  AmountPerClassification({required this.classification, required this.total});

  @override
  String toString() {
    return "Classificação: $classification; Total: $total";
  }
}

class AmountPerMonth {
  final String month;
  final int total;

  AmountPerMonth({required this.month, required this.total});

  @override
  String toString() {
    return "Mês: $month; Total: $total";
  }
}

class AmountPerSchool {
  final String school;
  final int total;

  AmountPerSchool({required this.school, required this.total});

  @override
  String toString() {
    return "Escola: $school; Total: $total";
  }
}
