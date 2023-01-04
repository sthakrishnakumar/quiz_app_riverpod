import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/quiz_statenotifier/domain/entities/quiz.dart';

import '../../../../core/export.dart';

abstract class QuizStateRepository {
  Future<Either<AppError, List<QuizNew>>> getQuiz();
}
