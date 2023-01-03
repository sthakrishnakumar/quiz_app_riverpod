import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/core/commons.dart';
import 'package:quiz_app/features/quiz_statenotifier/presentation/logic/quiz_state_notifier_controller.dart';
import 'package:quiz_app/features/quiz_statenotifier/presentation/views/quiz_page2.dart';

// ignore: must_be_immutable
class QuizResultPage2 extends ConsumerWidget {
  QuizResultPage2({super.key, required this.total});
  int total;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(quizStateNotifierProvider).marksCount;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result Page 2'),
        leading: IconButton(
          onPressed: () {
            pushReplacement(context, const QuizPage2());
            ref.watch(quizStateNotifierProvider.notifier).resetAll();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
