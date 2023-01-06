import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:quiz_app/core/app_const.dart';

import '../../../../core/export.dart';

class QuizPageSchool extends ConsumerStatefulWidget {
  const QuizPageSchool({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizPageSchoolState();
}

class _QuizPageSchoolState extends ConsumerState<QuizPageSchool>
    with TickerProviderStateMixin {
  Duration elapshed = Duration.zero;
  late final Ticker ticker;
  late AnimationController controller;

  late final AnimationController slideController = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.0, 0.0),
  ).animate(CurvedAnimation(
    parent: slideController,
    curve: Curves.linear,
  ));

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    ticker = createTicker((elapsh) {
      setState(() {
        elapshed = elapsh;
      });
    });
    ticker.start();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    ticker.dispose();
    super.dispose();
  }

  int quizLength = 2;
  // int previousNumber = 0;
  // final number = ValueNotifier(1);
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final quizIndex = ref.watch(quizStateNotifierProvider).quizIndex;
    final isTapped = ref.watch(quizStateNotifierProvider).isTapped;
    final clickedIndex = ref.watch(quizStateNotifierProvider).clickedIndex;
    final isIgnored = ref.watch(quizStateNotifierProvider).isIgnored;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppConst.primaryBlue,
        title: const Text('Test'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: w * 0.04),
                child: const Text(
                  'Report',
                ),
              ),
            ),
          ),
        ],
      ),
      body: AsyncValueWidget(
          value: ref.watch(quizStateControllerProvider),
          data: (data) {
            quizLength = data.length - 1;
            final quizes = data[quizIndex];

            final options = quizes.options();
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          // color: Colors.green,
                          height: h * 0.43,
                        ),
                        Container(
                          height: h * 0.25,
                          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                          color: AppConst.primaryBlue,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   children: [
                              //     ValueListenableBuilder(
                              //         valueListenable: number,
                              //         builder: (context, value, _) {
                              //           return AnimatedSwitcher(
                              //             duration:
                              //                 const Duration(milliseconds: 300),
                              //             transitionBuilder:
                              //                 (child, animation) {
                              //               final position = Tween<Offset>(
                              //                 begin: (previousNumber <
                              //                         quizIndex + 1)
                              //                     ? const Offset(0, -1)
                              //                     : const Offset(0, 1),
                              //                 end: Offset.zero,
                              //               ).animate(animation);

                              //               return FadeTransition(
                              //                 opacity: animation,
                              //                 child: SlideTransition(
                              //                   position: position,
                              //                   child: child,
                              //                 ),
                              //               );
                              //             },
                              //             child: Text(
                              //               '${quizIndex + 1}',
                              //               key: UniqueKey(),
                              //               style: const TextStyle(
                              //                 fontWeight: FontWeight.bold,
                              //                 color: Colors.white,
                              //                 fontSize: 23,
                              //               ),
                              //             ),
                              //           );
                              //         }),
                              //   ],
                              // ),
                              Text(
                                '${quizIndex + 1}/${data.length}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 23,
                                ),
                              ),
                              Text(
                                elapshed.toString().substring(0, 7),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 23,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            RotationTransition(
                              turns: Tween(begin: 0.0, end: 1.0)
                                  .animate(controller),
                              child: Container(
                                // constraints: const BoxConstraints(),
                                height: h * 0.35,
                                margin: EdgeInsets.only(
                                  left: w * 0.05,
                                  right: w * 0.05,
                                  top: h * 0.05,
                                  bottom: h * 0.02,
                                ),
                                padding:
                                    EdgeInsets.symmetric(horizontal: w * 0.06),
                                decoration: BoxDecoration(
                                  color: AppConst.primaryBlue,
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.07),
                              child: Text(
                                quizes.question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SlideTransition(
                      position: _offsetAnimation,
                      child: SizedBox(
                        height: isTapped
                            ? options[clickedIndex] == quizes.correctAnswer
                                ? h * 0.35
                                : h * 0.31
                            : h * 0.35,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return IgnorePointer(
                              ignoring: isIgnored,
                              child: InkWell(
                                onTap: () {
                                  ref
                                      .read(quizStateNotifierProvider.notifier)
                                      .updateClickedIndex(index);
                                  ref
                                      .read(quizStateNotifierProvider.notifier)
                                      .updateIsTapped(true);
                                  ref
                                      .read(quizStateNotifierProvider.notifier)
                                      .updateIsIgnored(true);

                                  if (options[index] == quizes.correctAnswer) {
                                    ref
                                        .read(
                                            quizStateNotifierProvider.notifier)
                                        .updateMarks(ref
                                                .read(quizStateNotifierProvider)
                                                .marksCount +
                                            1);
                                  }
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: w * 0.1),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: h * 0.015),
                                          decoration: BoxDecoration(
                                            color: isTapped
                                                ? index == clickedIndex
                                                    ? options[index] ==
                                                            quizes.correctAnswer
                                                        ? Colors.green
                                                        : Colors.red
                                                    : AppConst.primaryBlue
                                                : AppConst.primaryBlue,
                                            border: Border.all(
                                              color: isTapped
                                                  ? index == clickedIndex
                                                      ? options[index] ==
                                                              quizes
                                                                  .correctAnswer
                                                          ? Colors.green
                                                          : Colors.red
                                                      : AppConst.primaryBlue
                                                  : AppConst.primaryBlue,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              topLeft: Radius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            index == 0
                                                ? 'a'
                                                : index == 1
                                                    ? 'b'
                                                    : index == 2
                                                        ? 'c'
                                                        : 'd',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: h * 0.025,
                                          horizontal: w * 0.002,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isTapped
                                              ? clickedIndex == index
                                                  ? Colors.white
                                                  : AppConst.primaryBlue
                                              : AppConst.primaryBlue,
                                          border: Border(
                                            top: BorderSide(
                                                width: 1.5,
                                                color: isTapped
                                                    ? clickedIndex == index
                                                        ? Colors.white
                                                        : AppConst.primaryBlue
                                                    : AppConst.primaryBlue),
                                            bottom: BorderSide(
                                                width: 1.5,
                                                color: isTapped
                                                    ? clickedIndex == index
                                                        ? Colors.white
                                                        : AppConst.primaryBlue
                                                    : AppConst.primaryBlue),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: h * 0.015),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: isTapped
                                                  ? clickedIndex == index
                                                      ? quizes.correctAnswer ==
                                                              options[index]
                                                          ? AppConst
                                                              .primaryGreen
                                                          : AppConst.primaryRed
                                                      : AppConst.primaryBlue
                                                  : AppConst.primaryBlue,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            ),
                                            color: isTapped
                                                ? clickedIndex == index
                                                    ? quizes.correctAnswer ==
                                                            options[index]
                                                        ? AppConst.primaryGreen
                                                        : AppConst.primaryRed
                                                    : Colors.white
                                                : Colors.white,
                                          ),
                                          child: Text(
                                            options[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: isTapped
                                                    ? clickedIndex == index
                                                        ? Colors.white
                                                        : Colors.black
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: isTapped
                                  ? options[clickedIndex] ==
                                          quizes.correctAnswer
                                      ? h * 0.035
                                      : h * 0.02
                                  : h * 0.035,
                            );
                          },
                          itemCount: options.length,
                        ),
                      ),
                    ),
                    isTapped
                        ? options[clickedIndex] == quizes.correctAnswer
                            ? const Text('')
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: h * 0.007, horizontal: w * 0.02),
                                margin:
                                    EdgeInsets.symmetric(horizontal: w * 0.31),
                                decoration: const ShapeDecoration(
                                  shape: StadiumBorder(
                                    side:
                                        BorderSide(color: AppConst.primaryBlue),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 12,
                                      child: Icon(
                                        Icons.ondemand_video_outlined,
                                        size: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * 0.02,
                                    ),
                                    const Text('Watch Video'),
                                  ],
                                ),
                              )
                        : const Text(''),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: h * 0.01),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isTapped) {
                        if (quizIndex < data.length - 1) {
                          controller.forward();
                          slideController.forward();
                          Timer(const Duration(milliseconds: 600), () {
                            controller.reset();
                            slideController.reset();
                          });

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
                        } else {
                          pushReplacement(
                            context,
                            QuizResultPage2(
                              total: data.length,
                              timeTaken: elapshed,
                            ),
                          );
                        }
                      } else {
                        floatingSnackbar(context, 'Please Choose Option',
                            color: Colors.red.withOpacity(0.5));
                      }
                    },
                    // navigation(context, const PerformanceDetailPage()),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppConst.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                      child: Text(
                          quizIndex == data.length - 1 ? 'Submit' : 'Next'),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
