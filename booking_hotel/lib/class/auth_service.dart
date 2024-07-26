import 'package:booking_hotel/admin/booked_manager/manager_booked_room.dart';
import 'package:booking_hotel/class/login_status.dart';
import 'package:booking_hotel/class/user_preferences.dart';
import 'package:booking_hotel/class/string_format.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:booking_hotel/model/login_device.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:booking_hotel/model/user.dart' as models;
import 'package:booking_hotel/screens/auth_page.dart';
import 'package:booking_hotel/screens/home_layout.dart';
import 'package:booking_hotel/screens/register_google_account.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          builder: (e) => AuthPage(),
        ),
      );
    }
  }
}

void SignIn(BuildContext context, String email, String password) async {
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
  models.User? getAccount = await getUserByEmail(email);
  final getToken = await FirebaseMessaging.instance.getToken();
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (getAccount == null) {
      WarningToast(
              context: context,
              content: AppLocalizations.of(context)!.userNotFound)
          .ShowToast();
      await FirebaseAuth.instance.signOut();
      return;
    }
    UserPreferences.saveUser(getAccount);

    SaveDevice(LoginDevice(
        userId: getAccount.userId!, deviceToken: getToken!, loginStatus: true));
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (e) => AuthPage(),
      ),
    );
  } on FirebaseAuthException catch (e) {
    if (getAccount != null) {
      UserPreferences.saveUser(getAccount);
      SaveDevice(LoginDevice(
          userId: getAccount.userId!,
          deviceToken: getToken!,
          loginStatus: true));
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (e) =>
              (getAccount.role == "Admin") ? ManagerBookedRoom() : HomeLayout(),
        ),
      );
    } else {
      WarningToast(
        context: context,
        content: AppLocalizations.of(context)!.userNotFound,
      ).ShowToast();
      Navigator.pop(context);
    }
  }
}

void LogOut(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title:
          Text(StringFormat.capitalize(AppLocalizations.of(context)!.logout)),
      content: Text(
          StringFormat.capitalize(AppLocalizations.of(context)!.logoutWarning)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppLocalizations.of(context)!.choice('cancel'),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        TextButton(
          onPressed: () async {
            models.User? _loggedInUser = await UserPreferences.getUser();
            final getToken = await FirebaseMessaging.instance.getToken();
            SaveDevice(LoginDevice(
                userId: _loggedInUser!.userId!,
                deviceToken: getToken!,
                loginStatus: false));
            ClearLoggedUser();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AuthPage()),
                (Route<dynamic> route) => false);
          },
          child: Text(
            AppLocalizations.of(context)!.choice('accept'),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    ),
  );
}
