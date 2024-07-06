import 'package:booking_hotel/class/shared_preferences.dart';
import 'package:booking_hotel/model/user.dart' as models;
import 'package:booking_hotel/screens/ProfilePage/my_profile.dart';
import 'package:booking_hotel/screens/auth_page.dart';
import 'package:booking_hotel/screens/basic_login_screen.dart';
import 'package:booking_hotel/widgets/custom_image_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:booking_hotel/theme/theme_provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isDarkmode = false;
  models.User? user;

  bool isLoading = true;
  void GetUser() async {
    user = await UserPreferences.getUser();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    GetUser();
  }

  @override
  Widget build(BuildContext context) {
    isDarkmode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
        child: (isLoading)
            ? Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : (user == null)
                ? BasicLoginScreen(context: context)
                : buildAccountPage(context));
  }

  Widget buildAccountPage(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomImageView(
                      imagePath: 'images/avatar.png',
                      height: 120,
                      width: 120,
                      radius: BorderRadius.circular(60),
                      alignment: Alignment.center,
                    ),
                    CustomImageView(
                      imagePath: 'images/avatar.png',
                      height: 30,
                      width: 30,
                      radius: BorderRadius.circular(60),
                      alignment: Alignment.bottomRight,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                user!.userName,
                style: GoogleFonts.montserrat(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                user!.userGmail,
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
            profileSettingField(() {
              OpenMyProfilePage(context);
            }, Icons.person, "Sửa thông tin"),
            SizedBox(height: 5),
            profileSettingField(() {}, Icons.notifications, "Thông báo"),
            SizedBox(height: 5),
            profileSettingField(() {}, Icons.shield, "Bảo mật"),
            SizedBox(height: 5),
            profileSettingField(() {}, Icons.info, "Trợ giúp"),
            SizedBox(height: 5),
            profileSettingField(() {}, Icons.dark_mode, "Chế độ nền tối"),
            SizedBox(height: 5),
            profileSettingField(() {
              UserPreferences.clearUser();
              setState(() {
                GetUser();
              });
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (e) => AuthPage(),
                  ),
                  (route) => false);
            }, Icons.logout, "Đăng xuất")
          ],
        ));
  }

  void OpenMyProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => const MyProfile(),
      ),
    );
  }

  Widget profileSettingField(VoidCallback onTap, IconData icon, String text) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          )),
          (icon == Icons.dark_mode)
              ? Switch(
                  value: isDarkmode,
                  activeColor: Theme.of(context).colorScheme.onPrimary,
                  trackOutlineColor: WidgetStatePropertyAll<Color>(
                      Theme.of(context).colorScheme.shadow),
                  onChanged: (bool value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                    setState(() {
                      isDarkmode =
                          Theme.of(context).brightness == Brightness.dark;
                    });
                  })
              : SizedBox()
        ],
      ),
    );
  }
}
