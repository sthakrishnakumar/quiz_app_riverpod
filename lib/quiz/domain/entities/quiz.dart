// ignore_for_file: public_member_api_docs, sort_constructors_first
class Quiz {
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;
  Quiz({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });
}
