class GetFirstLetterFromEachWordOfString {
  static String getFirstLetterFromEachWordOfString(String value) {
    List<String> words = value.split(' ');
    List<String> initials = [];

    for (String word in words) {
      if (word.length > 3) {
        String initial = word[0].toUpperCase();
        initials.add(initial);
        
        if (initials.length == 2) {
          break;
        }
      }
    }

    String result = initials.join('');

    return result;
  }
}
