import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/features/quiz_stateprovider/domain/entities/quiz.dart';

import '../../../../core/app_error.dart';
import '../../data/repository/quiz_repository_impl.dart';
import '../../domain/repository/quiz_repository.dart';

class QuizStateController extends StateNotifier<AsyncValue<List<Quiz>>> {
  QuizStateController(this.quizRepository) : super(const AsyncValue.loading()) {
    getQuiz();
  }

  QuizStateRepository quizRepository;

  getQuiz() async {
    final result = await quizRepository.getQuiz();

    result.fold(
      (l) => state = AsyncValue.error(
        AppError(message: l.message),
        StackTrace.fromString(l.message),
      ),
      (r) {
        return state = AsyncValue.data(r);
      },
    );
  }
}

final quizStateControllerProvider =
    StateNotifierProvider<QuizStateController, AsyncValue<List<Quiz>>>((ref) {
  return QuizStateController(ref.watch(quizStateRepoProvider));
});
