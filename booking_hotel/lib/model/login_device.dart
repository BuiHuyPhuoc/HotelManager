import 'dart:convert';

import 'package:booking_hotel/class/api_respond.dart';
import 'package:http/http.dart' as http;

class LoginDevice {
  int userId;
  final String deviceToken;
  final bool loginStatus;

  LoginDevice(
      {required this.userId,
      required this.deviceToken,
      required this.loginStatus});

  factory LoginDevice.fromJson(Map<String, dynamic> json) {
    return LoginDevice(
      userId: json['userId'],
      deviceToken: json['deviceToken'],
      loginStatus: json['loginStatus'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'deviceToken': deviceToken,
      'loginStatus': loginStatus,
    };
  }
}

Future<ApiResponse> SaveDevice(LoginDevice device) async {
  final url = Uri.parse('https://10.0.2.2:7052/api/Device/SaveDevice');
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode({
    'userId': device.userId,
    'deviceToken': device.deviceToken,
    'loginStatus': device.loginStatus,
  });
  final response = await http.post(url, headers: headers, body: body);
  if (response.hashCode == 200) {
    return ApiResponse(status: true, message: response.body.toString());
  } else {
    return ApiResponse(status: false, message: response.body.toString());
  }
}

Future<List<LoginDevice>?> GetListUserDevice(String userId) async {
  final url = Uri.parse(
      'https://10.0.2.2:7052/api/Device/GetDeviceByUserId?userId=$userId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    List<LoginDevice> _loginDevice =
        jsonList.map((json) => LoginDevice.fromJson(json)).toList();
    return _loginDevice;
  } else {
    return null;
  }
}
