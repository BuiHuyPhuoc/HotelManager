import 'dart:convert';
import 'package:booking_hotel/class/api_respond.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Booking {
  int? bookingId;
  final String startDate;
  final String endDate;
  final String bookingDate;
  final double bookingDiscount;
  final String? bookingStatus;
  final double bookingPaid;
  final double bookingPrice;
  final int userId;
  final int roomId;

  Booking({
    this.bookingId,
    required this.startDate,
    required this.endDate,
    String? bookingDate,
    required this.bookingDiscount,
    this.bookingStatus,
    required this.bookingPaid,
    required this.bookingPrice,
    required this.userId,
    required this.roomId,
  }) : bookingDate = bookingDate ?? DateFormat('dd/MM/yyyy').format(DateTime.now());

  // Tạo constructor fromJson
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingId: json['bookingId'],
      startDate: json['startDate'] ,
      endDate: json['endDate'] ,
      bookingDate: json['bookingDate'],
      bookingDiscount: (json['bookingDiscount'] as num).toDouble(),
      bookingStatus: json['bookingStatus'],
      bookingPaid: (json['bookingPaid'] as num).toDouble(),
      bookingPrice: (json['bookingPrice'] as num).toDouble(),
      userId: json['userId'],
      roomId: json['roomId'],
    );
  }

  // Tạo phương thức toJson
  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'startDate': startDate,
      'endDate': endDate,
      'bookingDate': bookingDate,
      'bookingDiscount': bookingDiscount,
      'bookingStatus': bookingStatus,
      'bookingPaid': bookingPaid,
      'bookingPrice': bookingPrice,
      'userId': userId,
      'roomId': roomId,
    };
  }
}

Future<ApiResponse> createBooking(Booking? booking) async {
  if (booking == null) {
    return ApiResponse(status: false, message: "Đơn đặt trống.");
  }
  final url = Uri.parse('https://10.0.2.2:7052/api/Booking/CreateBookingOrder');
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode({
      'startDate': booking.startDate,
      'endDate': booking.endDate,
      'bookingDate': DateTime.now().toIso8601String(),
      'bookingDiscount': booking.bookingDiscount,
      'bookingStatus': booking.bookingStatus,
      'bookingPaid': booking.bookingPaid,
      'bookingPrice': booking.bookingPrice,
      'userId': booking.userId,
      'roomId': booking.roomId,
  });

  final response = await http.post(url, headers: headers, body: body);
  String message = json.decode(json.encode(response.body));
  if (response.statusCode == 200) {
    return ApiResponse(status: true, message: '$message');
  } else {
    return ApiResponse(status: false, message: '$message');
  }
}

Future<List<Booking>> getBookingById(String id) async {
  int _parseValue = int.parse(id);
  final url = Uri.parse('https://10.0.2.2:7052/api/Room/GetBookingDateOfRoom?idRoom=${_parseValue}');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    List<Booking> _bookingList = jsonList.map((json) => Booking.fromJson(json)).toList();
    return _bookingList;
  } else {
    throw Exception('Failed to load cities.');
  }
}
