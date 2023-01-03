/*[
  {
"category": "Film & TV",
"id": "622a1c347cc59eab6f94faac",
"correctAnswer": "Whoopi Goldberg",
"incorrectAnswers": [
"Annette Bening",
"Lorraine Bracco",
"Diane Ladd"
],
"question": "Who won the 1990 Academy Award for Best Supporting Actress for playing the role of Oda Mae Brown in Ghost?",
"tags": [
"academy_awards",
"film",
"acting",
"film_and_tv"
],
"type": "Multiple Choice",
"difficulty": "medium",
"regions": [],
"isNiche": false
},
{
"category": "Film & TV",
"id": "622a1c377cc59eab6f9506cd",
"correctAnswer": "Billy Bob Thornton",
"incorrectAnswers": [
"Russell Crowe",
"Seth Rogen",
"John Turturro"
],
"question": "Which actor has starred in films including Fargo and Armageddon?",
"tags": [
"acting",
"film",
"film_and_tv"
],
"type": "Multiple Choice",
"difficulty": "medium",
"regions": [],
"isNiche": false
}
]*/

import '../../../../core/export.dart';

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
