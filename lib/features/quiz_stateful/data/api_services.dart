import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/export.dart';

class ApiService {
  Future<List<Quiz>> getData() async {
    List result = await ApiClient().request(path: ApiConst.myQuestions);
    return result.map((e) => QuizModel.fromJson(e)).toList();
  }

//using HTTP
  String endpoint = 'https://mocki.io/v1/2f69b481-04dd-44b6-93ff-dc95cdb969ef';
  Future<List<QuizModel>> getDataHttp() async {
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => QuizModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
