import 'package:dartz/dartz.dart';
import 'package:quiz_app/quiz/domain/entities/quiz.dart';

import '../../../core/app_error.dart';

abstract class QuizRepository {
  Future<Either<AppError, List<Quiz>>> getQuiz();
}
