import 'dart:async';

import '../../../../core/export.dart';

class QuizPage2 extends ConsumerStatefulWidget {
  const QuizPage2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizPage2State();
}

class _QuizPage2State extends ConsumerState<QuizPage2> {
  static int maxSeconds = 12;
  int seconds = maxSeconds;
  Timer? timer;

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      startTimer();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        if (ref.read(quizStateNotifierProvider).quizIndex < quizLength) {
          ref.read(quizStateNotifierProvider.notifier).updateQuizIndex(
              ref.read(quizStateNotifierProvider).quizIndex + 1);
          ref.read(quizStateNotifierProvider.notifier).updateIsIgnored(false);
          ref.read(quizStateNotifierProvider.notifier).updateIsTapped(false);
          resetTimer();
        } else {
          pushReplacement(
            context,
            QuizResultPage2(
              total: quizLength + 1,
            ),
          );
        }
        if (!ref.read(quizStateNotifierProvider).isTapped) {
          ScaffoldMessenger.of(context).clearSnackBars();

          floatingSnackbar(context, 'You Skipped this Question',
              color: Colors.red.withOpacity(0.5));
        }
      }
    });
  }

  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
    });
  }

  int quizLength = 2;

  @override
  Widget build(BuildContext context) {
    final quizIndex = ref.watch(quizStateNotifierProvider).quizIndex;
    final isTapped = ref.watch(quizStateNotifierProvider).isTapped;
    final clickedIndex = ref.watch(quizStateNotifierProvider).clickedIndex;
    final isIgnored = ref.watch(quizStateNotifierProvider).isIgnored;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page 2'),
      ),
      body: AsyncValueWidget(
        value: ref.watch(quizStateControllerProvider),
        data: (data) {
          quizLength = data.length - 1;
          final quizes = data[quizIndex];
          maxSeconds = quizes.time;

          final options = quizes.options();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: CircleAvatar(
                      radius: 25,
                      child: Text(
                        seconds.toString(),
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                Text('${quizIndex + 1}. ${quizes.question}'),
                ...options.map(
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
                                ref
                                    .read(quizStateNotifierProvider.notifier)
                                    .updateClickedIndex(options.indexOf(e));
                                ref
                                    .read(quizStateNotifierProvider.notifier)
                                    .updateIsTapped(true);
                                ref
                                    .read(quizStateNotifierProvider.notifier)
                                    .updateIsIgnored(true);

                                if (e == quizes.correctAnswer) {
                                  ref
                                      .read(quizStateNotifierProvider.notifier)
                                      .updateMarks(ref
                                              .read(quizStateNotifierProvider)
                                              .marksCount +
                                          1);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                  color: isTapped
                                      ? options.indexOf(e) == clickedIndex
                                          ? e == quizes.correctAnswer
                                              ? Colors.green
                                              : Colors.red
                                          // : e == quizes.correctAnswer
                                          //     ? Colors.green
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
                          ref
                              .read(quizStateNotifierProvider.notifier)
                              .updateQuizIndex(ref
                                      .read(quizStateNotifierProvider)
                                      .quizIndex +
                                  1);
                          ref
                              .read(quizStateNotifierProvider.notifier)
                              .updateIsIgnored(false);

                          ref
                              .read(quizStateNotifierProvider.notifier)
                              .updateIsTapped(false);
                          resetTimer();
                        } else {
                          pushReplacement(
                            context,
                            QuizResultPage2(
                              total: data.length,
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
