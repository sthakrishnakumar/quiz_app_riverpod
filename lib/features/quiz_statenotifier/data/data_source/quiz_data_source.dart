// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/core/api_client.dart';
import 'package:quiz_app/core/api_const.dart';
import 'package:quiz_app/features/quiz_stateprovider/data/model/quiz_model.dart';
import 'package:quiz_app/features/quiz_stateprovider/domain/entities/quiz.dart';

abstract class QuizDataSource {
  Future<List<Quiz>> getQuiz();
}

class QuizDataSourceImpl extends QuizDataSource {
  ApiClient apiClient;
  QuizDataSourceImpl({
    required this.apiClient,
  });
  @override
  Future<List<Quiz>> getQuiz() async {
    List data = await apiClient.request(path: ApiConst.myQuestions);
    return data.map((e) => QuizModel.fromJson(e)).toList();
  }
}

final quizStateDataSourceProvider = Provider<QuizDataSource>((ref) {
  return QuizDataSourceImpl(apiClient: ref.watch(apiClientProvider));
});
