import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safe_schools/src/schools/school.dart';
import '../shared/repositories/base_repository.dart';

class SchoolsRepository extends BaseRepository {
  static const _uri = BaseRepository.apiBasePath;

  Future<List<School>>? getSchools() async {
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
    for (var i = 0; i < responseJson["data"].length; i++) {
      output[i] = School.fromJson(responseJson["data"][i]);
    }

    return output;
  }

  static createSchool(School school) {}

  static updateSchool(School school) {}
}
