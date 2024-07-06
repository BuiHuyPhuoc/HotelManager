import 'package:intl/intl.dart';

String formatMoney(double number) {
  return NumberFormat('#').format(number) + "đ";
}