import 'package:dartz/dartz.dart';

import '../../../../core/export.dart';

final quizRepoProvider = Provider<QuizRepository>((ref) {
  return QuizRepositoryImpl(dataSource: ref.watch(quizDataSourceProvider));
});

class QuizRepositoryImpl extends QuizRepository {
  QuizDataSource dataSource;
  QuizRepositoryImpl({
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
