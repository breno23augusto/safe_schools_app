import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:safe_schools/src/schools/school.dart';

import '../shared/repositories/base_repository.dart';

class SchoolsRepository extends BaseRepository {
  static const _uri = BaseRepository.apiBasePath;

  Future<List<School>> getSchools() async {
    final response = await http.get(
      Uri.parse(
        "$_uri/api/schools",
      ),
      headers: await header(true),
    );

    if (response.statusCode != 200) {
      return [];
    }

    final responseJson = jsonDecode(response.body);

    List<School> output = [];
    for (var data in responseJson["data"]) {
      output.add(School.fromJson(data));
    }

    return output;
  }

  Future createSchool(School school) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$_uri/api/schools',
        ),
        body: school.toJson(),
        headers: await header(true),
      );
      if (response.statusCode >= 300) {
        throw Exception(
            'Algo incesperado aconteceu! :${response.reasonPhrase}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateSchool(School school) async {
    try {
      int? id = school.id;
      final response = await http.put(
        Uri.parse(
          '$_uri/api/schools/$id',
        ),
        body: school.toJson(),
        headers: await header(true),
      );
      if (response.statusCode >= 300) {
        throw Exception(
            'Algo incesperado aconteceu! :${response.reasonPhrase}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future deleteSchool(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_uri/api/schools/$id'),
          headers: await header(true));

      if (response.statusCode != 200) {
        throw Exception(
            'Algo incesperado aconteceu! : ${response.reasonPhrase}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
