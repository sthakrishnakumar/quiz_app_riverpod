import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/core/commons.dart';
import 'package:quiz_app/core/providers.dart';
import 'package:quiz_app/features/quiz_stateprovider/presentation/logic/quiz_controller.dart';
import 'package:quiz_app/features/quiz_stateprovider/presentation/views/quiz_result_page.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  int quizLength = 2;
  // @override
  // void initState() {
  //   super.initState();

  //   Timer(const Duration(seconds: 5), () {
  //     startTimer();
  //   });
  // }

  // // late int seconds;
  // void startTimer() {
  //   CountdownTimer(Duration(seconds: ref.watch(quizDurationProvider)),
  //           const Duration(seconds: 1))
  //       .listen((data) {})
  //     ..onData((data) {
  //       ref.watch(quizDurationProvider.notifier).state--;
  //     })
  //     ..onDone(() {
  //       if (ref.watch(quizIndexProvider) < quizLength) {
  //         ref.watch(quizIndexProvider.notifier).state =
  //             ref.watch(quizIndexProvider.notifier).state + 1;
  //         ref.read(isIgnoredProvider.notifier).state = false;
  //         ref.read(isTappedProvider.notifier).state = false;

  //         ref.watch(quizDurationProvider.notifier).state = 5;
  //         startTimer();
  //       } else {
  //         Navigator.push(context,
  //             CupertinoPageRoute(builder: (context) => const QuizResultPage()));
  //       }
  //       if (!ref.read(isTappedProvider)) {
  //         ScaffoldMessenger.of(context).clearSnackBars();
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: const Text('You Skipped this Question'),
  //             backgroundColor: Colors.red.withOpacity(0.5),
  //             duration: const Duration(seconds: 1),
  //             behavior: SnackBarBehavior.floating,
  //             margin: const EdgeInsets.only(
  //               bottom: 40,
  //               left: 10,
  //               right: 10,
  //             ),
  //           ),
  //         );
  //       }
  //     });
  // }

  List<String> suff = [];

  @override
  Widget build(BuildContext context) {
    final quizIndex = ref.watch(quizIndexProvider);
    final isTapped = ref.watch(isTappedProvider);
    final clickedIndex = ref.watch(clickIndexProvider);
    final isIgnored = ref.watch(isIgnoredProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
      ),
      body: AsyncValueWidget(
        value: ref.watch(quizControllerProvider),
        data: (data) {
          // quizLength = data.length - 1;
          final quizes = data[quizIndex];
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 30),
                //   child: Center(
                //     child: CircleAvatar(
                //       radius: 25,
                //       child: Text(
                //         ref.watch(quizDurationProvider).toString(),
                //         style: const TextStyle(fontSize: 30),
                //       ),
                //     ),
                //   ),
                // ),
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
                                ref.watch(clickIndexProvider.notifier).state =
                                    suff.indexOf(e);
                                ref.read(isTappedProvider.notifier).state =
                                    true;
                                ref.read(isIgnoredProvider.notifier).state =
                                    true;

                                if (e == quizes.correctAnswer) {
                                  ref.read(marksCountProvider.notifier).state++;
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
                        if (quizIndex < data.length - 1) {
                          ref.watch(quizIndexProvider.notifier).state =
                              ref.watch(quizIndexProvider.notifier).state + 1;
                          ref.read(isIgnoredProvider.notifier).state = false;
                          ref.read(isTappedProvider.notifier).state = false;
                        } else {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  QuizResultPage(total: data.length),
                            ),
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
                    child:
                        Text(quizIndex == data.length - 1 ? 'Submit' : 'Next'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
