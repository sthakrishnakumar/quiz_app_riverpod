import 'package:flutter/scheduler.dart';
import 'package:quiz_app/features/quiz_statenotifier/presentation/views/quiz_page_mero_school.dart';

import 'core/export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Duration elapshed = Duration.zero;
  late final Ticker ticker;

  @override
  void initState() {
    ticker = createTicker((elapsed) {
      setState(() {
        elapshed = elapsed;
      });
    });
    ticker.start();
    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(elapshed.toString().substring(0, 7)),
            ElevatedButton(
              onPressed: () {
                navigation(context, const QuizPage1());
              },
              child: const Text('Quiz StateFul'),
            ),
            ElevatedButton(
              onPressed: () {
                navigation(context, const QuizPage2());
              },
              child: const Text('Quiz State Notifier'),
            ),
            ElevatedButton(
              onPressed: () {
                navigation(context, const QuizPage());
              },
              child: const Text('Quiz State Provider'),
            ),
            ElevatedButton(
              onPressed: () {
                navigation(context, const QuizPageSchool());
              },
              child: const Text('Mero School Quiz Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
