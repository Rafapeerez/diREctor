class GetFirstLetterFromEachWordOfString {
  static String getFirstLetterFromEachWordOfString(String value) {
    List<String> words = value.split(' ');
    List<String> initials = [];

    for (String word in words) {
      if (word.length > 3) {
        String initial = word[0].toUpperCase();
        initials.add(initial);
      }
    }
    String result = initials.join('');

    return result;
  }
}
