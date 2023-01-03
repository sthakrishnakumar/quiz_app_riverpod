// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/export.dart';

abstract class QuizStateDataSource {
  Future<List<Quiz>> getQuiz();
}

class QuizStateDataSourceImpl extends QuizStateDataSource {
  ApiClient apiClient;
  QuizStateDataSourceImpl({
    required this.apiClient,
  });
  @override
  Future<List<Quiz>> getQuiz() async {
    List data = await apiClient.request(path: ApiConst.myQuestions);
    return data.map((e) => QuizModel.fromJson(e)).toList();
  }
}

final quizStateDataSourceProvider = Provider<QuizStateDataSource>((ref) {
  return QuizStateDataSourceImpl(apiClient: ref.watch(apiClientProvider));
});
