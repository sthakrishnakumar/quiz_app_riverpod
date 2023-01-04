// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:quiz_app/features/quiz_statenotifier/data/model/quiz_model.dart';
import 'package:quiz_app/features/quiz_statenotifier/domain/entities/quiz.dart';

import '../../../../core/export.dart';

abstract class QuizStateDataSource {
  Future<List<QuizNew>> getQuiz();
}

class QuizStateDataSourceImpl extends QuizStateDataSource {
  ApiClient apiClient;
  QuizStateDataSourceImpl({
    required this.apiClient,
  });
  @override
  Future<List<QuizNew>> getQuiz() async {
    List data = await apiClient.request(path: ApiConst.newQuestions);
    return data.map((e) => QuizNewModel.fromJson(e)).toList();
  }
}

final quizStateDataSourceProvider = Provider<QuizStateDataSource>((ref) {
  return QuizStateDataSourceImpl(apiClient: ref.watch(apiClientProvider));
});
