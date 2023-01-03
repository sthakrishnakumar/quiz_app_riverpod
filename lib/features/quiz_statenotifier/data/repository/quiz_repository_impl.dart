import 'package:dartz/dartz.dart';

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
  Future<Either<AppError, List<Quiz>>> getQuiz() async {
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
