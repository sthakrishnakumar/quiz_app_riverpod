// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/export.dart';

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

final quizDataSourceProvider = Provider<QuizDataSource>((ref) {
  return QuizDataSourceImpl(apiClient: ref.watch(apiClientProvider));
});
