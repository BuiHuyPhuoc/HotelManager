import 'package:intl/intl.dart';

class DateFormater {
  static DateTime DateWithoutTime(DateTime dateConverted) {
    return DateTime(dateConverted.year, dateConverted.month, dateConverted.day);
  }

  static String? convertDateFormat(
      {required String dateString,
      required String inputFormat,
      required String outputFormat}) {
    try {
      DateFormat inputDateFormat = DateFormat(inputFormat);
      DateTime dateTime = inputDateFormat.parseStrict(dateString);

      DateFormat outputDateFormat = DateFormat(outputFormat);
      return outputDateFormat.format(dateTime);
    } catch (e) {
      return null; // Trả về null nếu phân tích không thành công
    }
  }
}
