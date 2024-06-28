import 'dart:convert';
import 'package:http/http.dart' as http;

class Hotel {
  final int hotelId;
  final String hotelName;
  final String hotelAddress;
  final String hotelCity;
  final String hotelPhone;

  Hotel({
    required this.hotelId,
    required this.hotelName,
    required this.hotelAddress,
    required this.hotelCity,
    required this.hotelPhone,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hotelId: json['hotelId'],
      hotelName: json['hotelName'],
      hotelAddress: json['hotelAddress'],
      hotelCity: json['hotelCity'],
      hotelPhone: json['hotelPhone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotelId': hotelId,
      'hotelName': hotelName,
      'hotelAddress': hotelAddress,
      'hotelCity': hotelCity,
      'hotelPhone': hotelPhone,
    };
  }
}

Future<Hotel> getHotelByID(String id) async {
  final url = Uri.parse('https://10.0.2.2:7052/api/Hotel/GetHotel/$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // Parse the JSON response into a Map
    final Map<String, dynamic> json = jsonDecode(response.body);

    // Convert the JSON Map into a Hotel object
    return Hotel.fromJson(json);
  } else {
    throw Exception('Failed to load hotel');
  }
}

Future<List<String>> getCities() async {
  final url = Uri.parse('https://10.0.2.2:7052/api/Hotel/GetCities');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    // Chuyển đổi phản hồi JSON thành danh sách các chuỗi
    List<String> cities = List<String>.from(jsonList);
    return cities;
  } else {
    throw Exception('Failed to load cities.');
  }
}
