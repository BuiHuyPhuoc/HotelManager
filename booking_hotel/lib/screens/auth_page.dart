// ignore_for_file: must_be_immutable

import 'package:booking_hotel/admin/booked_manager/manager_booked_room.dart';
import 'package:booking_hotel/class/user_preferences.dart';
import 'package:booking_hotel/screens/home_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:booking_hotel/model/user.dart' as models;

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  late models.User? user = null;
  void getUser() async {
    user = await UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && user != null) {
            if (user!.role == "Admin") {
              return ManagerBookedRoom();
            } else {
              return HomeLayout();
            }
          } else {
            return HomeLayout();
          }
        },
      ),
    );
  }
}
