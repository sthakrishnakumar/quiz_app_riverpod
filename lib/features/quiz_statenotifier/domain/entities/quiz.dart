// ignore_for_file: public_member_api_docs, sort_constructors_first

class QuizNew {
  String question;
  String correctAnswer;
  int time;
  String option1;
  String option2;
  String option3;
  String option4;
  QuizNew({
    required this.question,
    required this.correctAnswer,
    required this.time,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
  });

  // List<String> opt() {
  //   final List<String> answers = [option1, option2, option3, option4];
  //   final suffle = (answers..shuffle());

  //   return suffle;
  // }

  List<String> options() {
    return [option1, option2, option3, option4];
  }
}
