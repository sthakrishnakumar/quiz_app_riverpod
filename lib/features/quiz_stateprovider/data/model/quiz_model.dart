import 'package:quiz_app/features/quiz_stateprovider/domain/entities/quiz.dart';

class QuizModel extends Quiz {
  QuizModel({
    required super.question,
    required super.correctAnswer,
    required super.incorrectAnswers,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      question: json['question'] ?? "",
      correctAnswer: json['correctAnswer'] ?? "",
      incorrectAnswers: List.from(json['incorrectAnswers'] ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
