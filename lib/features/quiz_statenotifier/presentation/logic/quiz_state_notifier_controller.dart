import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/features/quiz_statenotifier/data/model/provider_models.dart';

class QuizStateNotifier extends StateNotifier<ProviderModel> {
  QuizStateNotifier() : super(ProviderModel());

//reset all
  resetAll() {
    resetQuizIndex();
    resetClickedIndex();
    resetMarks();
    resetIsTapped();
    resetIsIgnored();
  }

//quiz Index
  void updateQuizIndex(int quizIndex) {
    final newState = state.copyWith(quizIndex: quizIndex);
    state = newState;
  }

  void resetQuizIndex() {
    final newState = state.copyWith(quizIndex: 0);
    state = newState;
  }

//clicked Index
  void updateClickedIndex(int clickedIndex) {
    final newState = state.copyWith(clickedIndex: clickedIndex);
    state = newState;
  }

  void resetClickedIndex() {
    final newState = state.copyWith(clickedIndex: 4);
    state = newState;
  }

//quiz Marks
  void updateMarks(int marks) {
    final newState = state.copyWith(marksCount: marks);
    state = newState;
  }

  void resetMarks() {
    final newState = state.copyWith(marksCount: 0);
    state = newState;
  }

  //is Tapped
  void updateIsTapped(bool isTapped) {
    final newState = state.copyWith(isTapped: isTapped);
    state = newState;
  }

  void resetIsTapped() {
    final newState = state.copyWith(isTapped: false);
    state = newState;
  }

  //is Ignored
  void updateIsIgnored(bool isIgnored) {
    final newState = state.copyWith(isIgnored: isIgnored);
    state = newState;
  }

  void resetIsIgnored() {
    final newState = state.copyWith(isIgnored: false);
    state = newState;
  }
}

final quizStateNotifierProvider =
    StateNotifierProvider<QuizStateNotifier, ProviderModel>((ref) {
  return QuizStateNotifier();
});
