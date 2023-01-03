import '../../../../core/export.dart';

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
