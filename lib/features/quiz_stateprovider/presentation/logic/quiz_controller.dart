import '../../../../core/export.dart';

class QuizController extends StateNotifier<AsyncValue<List<Quiz>>> {
  QuizController(this.quizRepository) : super(const AsyncValue.loading()) {
    getQuiz();
  }

  QuizRepository quizRepository;

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

final quizControllerProvider =
    StateNotifierProvider<QuizController, AsyncValue<List<Quiz>>>((ref) {
  return QuizController(ref.watch(quizRepoProvider));
});
