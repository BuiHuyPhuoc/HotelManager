class StringFormat {
  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static String capitalizeEachWord(String sentence) {
    return sentence.split(' ').map((word) => capitalize(word)).join(' ');
  }
}
