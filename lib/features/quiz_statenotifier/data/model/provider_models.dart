// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProviderModel {
  int quizIndex;
  bool isTapped;
  int clickedIndex;
  bool isIgnored;
  int marksCount;
  ProviderModel({
    this.quizIndex = 0,
    this.isTapped = false,
    this.clickedIndex = 4,
    this.isIgnored = false,
    this.marksCount = 0,
  });

  ProviderModel copyWith({
    int? quizIndex,
    bool? isTapped,
    int? clickedIndex,
    bool? isIgnored,
    int? marksCount,
  }) {
    return ProviderModel(
      quizIndex: quizIndex ?? this.quizIndex,
      isTapped: isTapped ?? this.isTapped,
      clickedIndex: clickedIndex ?? this.clickedIndex,
      isIgnored: isIgnored ?? this.isIgnored,
      marksCount: marksCount ?? this.marksCount,
    );
  }
}
