extension SentenceCaseStringExtension on String {
  String toSentenceCase() {
    if (isEmpty) {
      return this; // Return the original string if it's empty
    }
    return this[0].toUpperCase() + substring(1);
  }
}

extension StringToListOfChars on String {
  List<String> toListOfChars() {
    return this.split('');
  }
}

extension StringToListOfWords on String {
  List<String> toListOfWords() {
    return this.split(RegExp(r'\s+'));
  }
}
