import 'dart:convert';
import 'package:booking_hotel/class/api_respond.dart';
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
    'UserGmail': user.userGmail,
    'UserPhone': user.userPhone,
    'UserPassword': user.userPassword,
    'UserName': user.userName,
    'UserIdcard': user.userIdcard,
    'DateOfBirth': user.dateOfBirth,
  });

  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    return ApiResponse(status: true, message: 'Tạo tài khoản thành công.');
  } else {
    String message = json.decode(json.encode(response.body));

    if (response.statusCode == 400) {
      return ApiResponse(status: false, message: '$message');
    } else if (response.statusCode == 409) {
      return ApiResponse(status: false, message: '$message');
    } else {
      return ApiResponse(status: false, message: '$message');
    }
  }
}
