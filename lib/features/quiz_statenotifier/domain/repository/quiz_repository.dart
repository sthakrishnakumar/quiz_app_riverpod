import 'package:dartz/dartz.dart';

import '../../../../core/export.dart';

abstract class QuizStateRepository {
  Future<Either<AppError, List<Quiz>>> getQuiz();
}
