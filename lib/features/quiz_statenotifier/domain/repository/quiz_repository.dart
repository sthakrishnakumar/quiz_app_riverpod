import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/quiz_stateprovider/domain/entities/quiz.dart';

import '../../../../core/app_error.dart';

abstract class QuizStateRepository {
  Future<Either<AppError, List<Quiz>>> getQuiz();
}
