import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/core/app_error.dart';
import 'package:quiz_app/features/quiz_stateprovider/domain/entities/quiz.dart';

import '../../domain/repository/quiz_repository.dart';
import '../data_source/quiz_data_source.dart';

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
