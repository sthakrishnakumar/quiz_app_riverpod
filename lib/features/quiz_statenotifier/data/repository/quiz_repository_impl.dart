import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/quiz_statenotifier/domain/entities/quiz.dart';

import '../../../../core/export.dart';

final quizStateRepoProvider = Provider<QuizStateRepository>((ref) {
  return QuizStateRepositoryImpl(
      dataSource: ref.watch(quizStateDataSourceProvider));
});

class QuizStateRepositoryImpl extends QuizStateRepository {
  QuizStateDataSource dataSource;
  QuizStateRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<AppError, List<QuizNew>>> getQuiz() async {
    try {
      final result = await dataSource.getQuiz();
      return Right(result);
    } on DioError catch (e) {
      return Left(
        AppError(message: e.message),
      );
    }
  }
}
