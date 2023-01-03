import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/core/providers.dart';

class QuizResultPage extends ConsumerWidget {
  QuizResultPage({super.key, required this.total});

  int total;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(marksCountProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result '),
        centerTitle: true,
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
