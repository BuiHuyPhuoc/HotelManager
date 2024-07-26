import 'package:diacritic/diacritic.dart';

enum Category { All, City, Hotel }

enum ImageType { svg, png, network, file, unknown }

enum Role { admin, staff }

extension CategoryTypeExtension on String {
  Category get categoryType {
    if (this == "Tất cả" || removeDiacritics(this).toLowerCase() == "all") {
      return Category.All;
    } else if (this.endsWith("thành phố") || removeDiacritics(this).toLowerCase().endsWith('city')) {
      return Category.City;
    } else {
      return Category.Hotel;
    }
  }
}

enum BookingDateType {Checkin, Checkout, Allday}
extension BookingDateTypeExtension on String {
  BookingDateType get bookingDateType {
    if (this.endsWith("Checkin") || this.endsWith("Check in")) {
      return BookingDateType.Checkin;
    } else if (this.endsWith("Checkout") || this.endsWith("Check out")) {
      return BookingDateType.Checkout;
    } else if (this.endsWith("Nguyên ngày")) {
      return BookingDateType.Allday;
    } else {
      throw Exception("Lỗi loại checkin hoặc checkout");
    }
  }
}

extension StringBookingDateTypeExtension on BookingDateType {
  String get description {
    switch (this) {
      case BookingDateType.Checkin:
        return 'Check-in';
      case BookingDateType.Checkout:
        return 'Check-out';
      case BookingDateType.Allday:
        return 'Nguyên ngày';
      default:
        return '';
    }
  }
}

enum RoomState { Checkedin, Checkedout, Allday }
