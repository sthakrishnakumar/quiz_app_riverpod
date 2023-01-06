// ignore: must_be_immutable

import 'package:quiz_app/home.dart';

import '../../../../core/export.dart';

class QuizResultPage2 extends ConsumerWidget {
  QuizResultPage2(
      {super.key, required this.total, this.timeTaken = const Duration()});
  int total;
  Duration timeTaken;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(quizStateNotifierProvider).marksCount;

    var timertext = '${(timeTaken.inMinutes.remainder(60)).toString()} min : '
        '${(timeTaken.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')} sec';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result Page 2'),
        leading: IconButton(
          onPressed: () {
            pushReplacement(context, const HomePage());
            ref.watch(quizStateNotifierProvider.notifier).resetAll();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Time taken to complete Quiz is $timertext'),
            Text('Your Score is $score out of $total'),
            const SizedBox(
              height: 10,
            ),
            Text('Wrong answer count is ${(total - score)}'),
          ],
        ),
      ),
    );
  }
}
