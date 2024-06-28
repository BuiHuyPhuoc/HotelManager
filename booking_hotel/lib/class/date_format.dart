class DateFormater {
  static DateTime DateWithoutTime(DateTime dateConverted) {
    return DateTime(dateConverted.year, dateConverted.month, dateConverted.day);
  }
}