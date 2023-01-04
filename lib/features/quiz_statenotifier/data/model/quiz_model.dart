import 'package:quiz_app/features/quiz_statenotifier/domain/entities/quiz.dart';

class QuizNewModel extends QuizNew {
  QuizNewModel(
      {required super.question,
      required super.correctAnswer,
      required super.option1,
      required super.option2,
      required super.option3,
      required super.option4});

  factory QuizNewModel.fromJson(Map<String, dynamic> json) {
    return QuizNewModel(
      question: json['question'] ?? "",
      correctAnswer: json['correctAnswer'] ?? "",
      option1: json['option1'] ?? "",
      option2: json['option2'] ?? "",
      option3: json['option3'] ?? "",
      option4: json['option4'] ?? "",
    );
  }
}
