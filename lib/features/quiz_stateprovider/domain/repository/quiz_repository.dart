import 'package:dartz/dartz.dart';

import '../../../../core/export.dart';

abstract class QuizRepository {
  Future<Either<AppError, List<Quiz>>> getQuiz();
}
