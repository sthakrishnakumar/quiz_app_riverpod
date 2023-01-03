import '../../../core/export.dart';

class QuizResultPage1 extends StatelessWidget {
  QuizResultPage1({super.key, required this.total, required this.score});

  int total;
  int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result '),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            pushReplacement(context, const QuizPage1());
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
