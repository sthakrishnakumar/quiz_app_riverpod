import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_const.dart';

class ApiClient {
  Future request({
    required String path,
    String method = "get",
    bool isFormData = false,
    Map<String, dynamic> data = const {},
  }) async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.myUrl,
        headers: {
          'Content-Type': 'application/json',
          "Accept": 'application/json',
        },
      ),
    );

    try {
      final result = method == "get"
          ? await dio.get(path)
          : await dio.post(path,
              data: isFormData ? FormData.fromMap(data) : data);
      // log('api okay ${result.data}');

      return result.data;
    } on DioError catch (e) {
      log('api error ${e.message}');
      throw Exception(e);
    }
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
