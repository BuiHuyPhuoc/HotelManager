import 'package:booking_hotel/class/shared_preferences.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:booking_hotel/screens/home_layout.dart';
import 'package:booking_hotel/screens/register_google_account.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Lấy thông tin tài khoản Google
    final firebase_auth.User? user = userCredential.user;

    // Lấy thông tin trong csdl
    final userFromDb = await getUserByEmail(user!.email!);
    if (userFromDb == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (e) => RegisterGoogleAcocunt(user: user),
        ),
      );
    } else {
      await UserPreferences.saveUser(userFromDb);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (e) => HomeLayout(),
        ),
      );
    }
  }
}
