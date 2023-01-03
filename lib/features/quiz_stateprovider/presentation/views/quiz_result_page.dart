import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/core/providers.dart';
import 'package:quiz_app/features/quiz_stateprovider/presentation/views/quiz_page.dart';

import '../../../../core/commons.dart';

class QuizResultPage extends ConsumerWidget {
  QuizResultPage({super.key, required this.total});

  int total;

  refreshProviders(WidgetRef ref) {
    ref.refresh(quizIndexProvider);
    ref.refresh(isTappedProvider);
    ref.refresh(clickIndexProvider);
    ref.refresh(isIgnoredProvider);
    ref.refresh(marksCountProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(marksCountProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result '),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            pushReplacement(context, const QuizPage());
            refreshProviders(ref);
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
