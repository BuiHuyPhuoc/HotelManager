import 'dart:convert';
import 'package:booking_hotel/class/api_respond.dart';
import 'package:booking_hotel/class/date_format.dart';
import 'package:http/http.dart' as http;

class User {
  final int? userId;
  final String userGmail;
  final String userPassword;
  final String userName;
  final String dateOfBirth;
  final String userPhone;
  final String userIdcard;

  User({
    this.userId = null,
    required this.userGmail,
    required this.userPassword,
    required this.userName,
    required this.dateOfBirth,
    required this.userPhone,
    required this.userIdcard,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userGmail: json['userGmail'],
      userPassword: json['userPassword'],
      userName: json['userName'],
      dateOfBirth: json['dateOfBirth'],
      userPhone: json['userPhone'],
      userIdcard: json['userIdcard'],
    );
  }
  factory User.fromJsonString(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userGmail: json['userGmail'],
      userPassword: json['userPassword'],
      userName: json['userName'],
      dateOfBirth: json['dateOfBirth'],
      userPhone: json['userPhone'],
      userIdcard: json['userIdcard'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userGmail': userGmail,
      'userPassword': userPassword,
      'userName': userName,
      'dateOfBirth': dateOfBirth,
      'userPhone': userPhone,
      'userIdcard': userIdcard,
    };
  }

  String toJson() => json.encode(toMap());
}

Future<User?> loginUser(String userGmail, String userPassword) async {
  final url = Uri.parse('https://10.0.2.2:7052/api/User/UserLogin');
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode({
    "UserGmail": userGmail,
    "UserPassword": userPassword,
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool loginStatus = bool.parse(responseData['status'].toString());
    return (!loginStatus) ? null : User.fromJson(responseData['user']);
  } else {
    return null;
  }
}

Future<ApiResponse> createUser(User? user) async {
  if (user == null) {
    return ApiResponse(status: false, message: "Người dùng trống.");
  }

  final url = Uri.parse('https://10.0.2.2:7052/api/User/UserRegister');
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode({
    'userGmail': user.userGmail,
    'userPhone': user.userPhone,
    'userPassword': user.userPassword,
    'userName': user.userName,
    'userIdcard': user.userIdcard,
    'dateOfBirth': DateFormater.convertDateFormat(
        dateString: user.dateOfBirth,
        inputFormat: "dd/MM/yyyy",
        outputFormat: "yyyy-MM-dd")
  });

  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    return ApiResponse(status: true, message: 'Tạo tài khoản thành công.');
  } else {
    String message = json.decode(json.encode(response.body));

    return ApiResponse(status: false, message: '$message');
  }
}

Future<User?> getUserByEmail(String email) async {
  final url =
      Uri.parse('https://10.0.2.2:7052/api/User/GetUserByEmail?email=$email');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    dynamic toJson = jsonDecode(response.body);
    // Chuyển đổi phản hồi JSON thành danh sách các chuỗi
    User user = User.fromJson(toJson);
    return user;
  } else if ( response.statusCode == 204) {
    return null;
  } else {
    throw Exception('Failed to load User.');
  }
}
