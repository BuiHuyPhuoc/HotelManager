import 'package:booking_hotel/class/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

void ClearLoggedUser() async {
  await UserPreferences.clearUser();
  await FirebaseAuth.instance.signOut();
}