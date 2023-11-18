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
    String word = this.toLowerCase();
    // Use the regular expression to split the string with whitespace , or -
    List<String> words = word.toLowerCase().split(RegExp(r'(\s+|-+|,+|\.+|!+|\?+|_+)')).toSet().toList();

    words.removeWhere((element) => element.trim().isEmpty);
    return words;
  }
}
