import 'package:flutter_riverpod/flutter_riverpod.dart';

final quizIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final isTappedProvider = StateProvider<bool>((ref) {
  return false;
});

final clickIndexProvider = StateProvider<int>((ref) {
  return 4;
});

final isIgnoredProvider = StateProvider<bool>((ref) {
  return false;
});

final quizDurationProvider = StateProvider<int>((ref) {
  return 15;
});

final dataLengthProvider = StateProvider<int>((ref) {
  return 5;
});
