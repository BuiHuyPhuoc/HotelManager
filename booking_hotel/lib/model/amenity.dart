import 'dart:convert';

import 'package:booking_hotel/class/string_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Amenity {
  int roomId;
  String amenityName;

  Amenity({required this.roomId, required this.amenityName});

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(roomId: json['roomId'], amenityName: json['amenityName']);
  }

  // Tạo phương thức toJson
  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'amenityName': amenityName,
    };
  }
}

IconData fromStringAmenityToIcon(String icon) {
  switch (icon) {
    case "WIFI":
      return Icons.wifi;
    case "BEDROOM":
      return Icons.bedroom_parent;
    case "PARKING":
      return Icons.local_parking_rounded;
    case "RESTAURANT":
      return Icons.restaurant;
    case "POOL":
      return Icons.pool;
    default:
      return Icons.hide_image;
  }
}

String translateFromAmenity(String amenity, BuildContext context) {
  return StringFormat.capitalize(AppLocalizations.of(context)!.amenity(amenity));
}

Future<List<Amenity>> getAmenitiesByRoomId(String roomId) async {
  final url = Uri.parse(
      'https://10.0.2.2:7052/api/Room/GetAmenitiesByRoomId?roomId=$roomId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    List<Amenity> _listAmenities =
        jsonList.map((json) => Amenity.fromJson(json)).toList();
    return _listAmenities;
  } else {
    throw Exception('Failed to load amenities.');
  }
}
