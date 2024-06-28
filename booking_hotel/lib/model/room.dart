import 'dart:convert';
import 'package:booking_hotel/class/api_respond.dart';
import 'package:booking_hotel/class/tuple.dart';
import 'package:http/http.dart' as http;

class Room {
  int roomId;
  final String roomDescription;
  int numberPeople;
  double price;
  double discountPrice;
  final String roomImage;
  int hotelId;
  bool roomValid;
  // Hotel info
  // Hoitel info
  final String hotelName;
  final String hotelAddress;
  final String hotelCity;
  final String hotelPhone;

  Room(
      {this.roomId = 0,
      required this.roomDescription,
      required this.numberPeople,
      required this.price,
      required this.discountPrice,
      required this.roomImage,
      required this.hotelId,
      required this.roomValid,
      this.hotelName = "",
      this.hotelAddress = "",
      this.hotelCity = "",
      this.hotelPhone = ""});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['roomId'],
      roomDescription: json['roomDescription'],
      numberPeople: json['numberPeople'],
      price: json['price'].toDouble(),
      discountPrice: json['discountPrice'].toDouble(),
      roomImage: json['roomImage'],
      hotelId: json['hotelId'],
      roomValid: json['roomValid'],
      hotelName: json['hotelName'],
      hotelAddress: json['hotelAddress'],
      hotelCity: json['hotelCity'],
      hotelPhone: json['hotelPhone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'roomDescription': roomDescription,
      'numberPeople': numberPeople,
      'price': price,
      'discountPrice': discountPrice,
      'roomImage': roomImage,
      'hotelId': hotelId,
      'roomValid': roomValid,
      'hotelName': hotelName,
      'hotelAddress': hotelAddress,
      'hotelCity': hotelCity,
      'hotelPhone': hotelPhone,
    };
  }
}

Future<List<Tuple<Room, int>>> getRoomsDefault() async {
  final url = Uri.parse('https://10.0.2.2:7052/api/Room/GetRoomsDefault');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    // Convert JSON list to a List of Room objects
    List<Tuple<Room, int>> rooms = [];
    for (int i = 0; i < jsonList.length; i++) {
      Room room = Room.fromJson(jsonList[i]);
      int likeCount = int.parse(jsonList[i]['likeCount'].toString());
      Tuple<Room, int> value = new Tuple(room, likeCount);
      rooms.add(value);
    }
    //List<Room> rooms = jsonList.map((json) => Room.fromJson(json)).toList();
    return rooms;
  } else {
    throw Exception('Failed to load rooms');
  }
}

Future<List<Tuple<Room, int>>> getSaleRooms() async {
  final url = Uri.parse('https://10.0.2.2:7052/api/Room/SaleRooms');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    // Convert JSON list to a List of Room objects
    List<Tuple<Room, int>> rooms = [];
    for (int i = 0; i < jsonList.length; i++) {
      Room room = Room.fromJson(jsonList[i]);
      int likeCount = int.parse(jsonList[i]['likeCount'].toString());
      Tuple<Room, int> value = new Tuple(room, likeCount);
      rooms.add(value);
    }
    return rooms;
  } else {
    throw Exception('Failed to load rooms');
  }
}

Future<Room> getRoomById(String id) async {
  final url = Uri.parse('https://10.0.2.2:7052/api/Room/GetRoomById?id=$id');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonList = jsonDecode(response.body)[0];
    Room room = Room.fromJson(jsonList);
    return room;
  } else {
    throw Exception('Failed to load room detail.');
  }
}

Future<List<Room>> getFavoriteRoomsByIdUser(String id) async {
  final url = Uri.parse(
      'https://10.0.2.2:7052/api/Room/GetFavoriteRoomsByIdUser?id=$id');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    List<Room> rooms = jsonList.map((json) => Room.fromJson(json)).toList();
    return rooms;
  } else {
    throw Exception('Failed to load favorite rooms.');
  }
}

Future<ApiResponse> addLikeRoom(
  String userId, String roomId) async {
  final url = Uri.parse('https://10.0.2.2:7052/api/Room/AddFavoriteRoom');
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode({
    'userId': userId.toString(),
    'roomId': roomId.toString(),
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool responseStatus = bool.parse(responseData['status'].toString());
    String responseMessage = responseData['message'].toString();
    return ApiResponse(status: responseStatus, message: responseMessage);
  } else {
    return ApiResponse(status: false, message: "Xử lý thất bại");
  }
}

Future<bool> isFavoriteRoom(String roomId, String userId) async {
  final url = Uri.parse('https://10.0.2.2:7052/api/Room/IsFavoriteRoom?roomId=$roomId&userId=$userId');
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode({
    'roomId': userId,
    'userId': roomId,
  });

  final response = await http.post(url, headers: headers, body: body);
  String res = response.body.replaceAll("\"", "");
  bool check = bool.parse(res);
  return check;
}
