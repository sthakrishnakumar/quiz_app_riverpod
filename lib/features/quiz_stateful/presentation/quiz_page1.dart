import 'package:flutter/material.dart';
import 'package:quiz_app/features/quiz_stateful/data/api_services.dart';
import 'package:quiz_app/features/quiz_stateful/presentation/quiz_result_page1.dart';
import 'package:quiz_app/features/quiz_stateprovider/domain/entities/quiz.dart';

import '../../../core/commons.dart';

class QuizPage1 extends StatefulWidget {
  const QuizPage1({super.key});

  @override
  State<QuizPage1> createState() => _QuizPage1State();
}

class _QuizPage1State extends State<QuizPage1> {
  late int quizIndex;
  late bool isIgnored;
  late int clickedIndex;
  late bool isTapped;
  late int marksCount;

  @override
  void initState() {
    quizIndex = 0;
    isIgnored = false;
    isTapped = false;
    clickedIndex = 4;
    marksCount = 0;
    super.initState();
  }

  List<String> suff = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page 1'),
      ),
      body: FutureBuilder(
        future: ApiService().getData(),
        builder: (BuildContext ctx, AsyncSnapshot<List<Quiz>> snapshot) {
          if (snapshot.hasData) {
            final quizes = snapshot.requireData[quizIndex];
            if (!isTapped) {
              final List<String> answers = [
                ...quizes.incorrectAnswers,
                quizes.correctAnswer
              ];
              final suffle = (answers..shuffle());
              suff = suffle;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${quizIndex + 1}. ${quizes.question}'),
                  ...suff.map(
                    (e) => Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            child: IgnorePointer(
                              ignoring: isIgnored,
                              child: InkWell(
                                onTap: () {
                                  clickedIndex = suff.indexOf(e);
                                  isTapped = true;
                                  isIgnored = true;
                                  setState(() {});
                                  if (e == quizes.correctAnswer) {
                                    marksCount = marksCount + 1;
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                    color: isTapped
                                        ? suff.indexOf(e) == clickedIndex
                                            ? e == quizes.correctAnswer
                                                ? Colors.green
                                                : Colors.red
                                            : Colors.white
                                        : Colors.white,
                                  ),
                                  child: Text(
                                    e,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (isTapped) {
                          if (quizIndex < snapshot.requireData.length - 1) {
                            setState(() {});
                            quizIndex = quizIndex + 1;
                            isIgnored = false;
                            isTapped = false;
                          } else {
                            pushReplacement(
                              context,
                              QuizResultPage1(
                                  total: snapshot.requireData.length,
                                  score: marksCount),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Please Choose Option'),
                              backgroundColor: Colors.red.withOpacity(0.5),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.only(
                                bottom: 40,
                                left: 10,
                                right: 10,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(quizIndex == snapshot.requireData.length - 1
                          ? 'Submit'
                          : 'Next'),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
