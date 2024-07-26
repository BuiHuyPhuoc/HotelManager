import 'package:booking_hotel/class/auth_service.dart';
import 'package:booking_hotel/class/user_preferences.dart';
import 'package:booking_hotel/class/string_format.dart';
import 'package:booking_hotel/main.dart';
import 'package:booking_hotel/model/user.dart' as models;
import 'package:booking_hotel/screens/ProfilePage/booked_room.dart';
import 'package:booking_hotel/screens/ProfilePage/my_profile.dart';
import 'package:booking_hotel/screens/basic_login_screen.dart';
import 'package:booking_hotel/widgets/custom_image_view.dart';
import 'package:booking_hotel/widgets/language_item.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:booking_hotel/theme/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isDarkmode = false;
  models.User? user;
  List<LanguageItem> language_item = [
    LanguageItem(
      language: "English",
      countryFlag: CountryFlag.fromLanguageCode(
        'en',
        shape: Circle(),
        height: 20,
        width: 20,
      ),
    ),
    LanguageItem(
      language: "Tiếng việt",
      countryFlag: CountryFlag.fromCountryCode(
        'VN',
        height: 20,
        width: 20,
        shape: Circle(),
      ),
    ),
  ];
  late LanguageItem selectedItem;
  bool isLoading = true;
  void GetUser() async {
    user = await UserPreferences.getUser();
    setState(() {
      isLoading = false;
    });
  }

  void _initializeSelectedItem() {
    Locale currentLocale = MyApp.of(context).getLocale();
    selectedItem = (currentLocale.languageCode == 'vi')
        ? language_item[1]
        : language_item[0];
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
    _initializeSelectedItem();
  }

  void _updateLanguage(LanguageItem item) {
    if (item.language == "Tiếng việt") {
      MyApp.of(context).setLocale(Locale('vi'));
    } else if (item.language == "English") {
      MyApp.of(context).setLocale(Locale('en'));
    }
  }

  @override
  Widget build(BuildContext context) {
    isDarkmode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
        child: (isLoading)
            ? Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : Scaffold(
                appBar: AppBar(
                  actions: [
                    PopupMenuButton<LanguageItem>(
                      initialValue: selectedItem,
                      onSelected: (LanguageItem item) {
                        setState(() {
                          selectedItem = item;
                        });
                        _updateLanguage(item);
                        Get.forceAppUpdate();
                        Locale currentLocale = MyApp.of(context).getLocale();
                        print("Current locale: " + currentLocale.languageCode);
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<LanguageItem>>[
                        PopupMenuItem<LanguageItem>(
                          value: language_item[0],
                          child: language_item[0],
                        ),
                        PopupMenuItem<LanguageItem>(
                          value: language_item[1],
                          child: language_item[1],
                        ),
                      ],
                    )
                  ],
                ),
                body: (user == null)
                    ? BasicLoginScreen(context: context)
                    : buildAccountPage(context),
              ));
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
            profileSettingField(
                () => OpenMyProfilePage(context),
                Icons.person,
                StringFormat.capitalize(
                    AppLocalizations.of(context)!.updateProfile)),
            SizedBox(height: 5),
            profileSettingField(
                () => OpenBookedRoom(context),
                Icons.bed,
                StringFormat.capitalize(
                    AppLocalizations.of(context)!.bookedRoom)),
            SizedBox(height: 5),
            profileSettingField(
                () {},
                Icons.notifications,
                StringFormat.capitalize(
                    AppLocalizations.of(context)!.notification)),
            SizedBox(height: 5),
            profileSettingField(
                () {},
                Icons.shield,
                StringFormat.capitalize(
                    AppLocalizations.of(context)!.security)),
            SizedBox(height: 5),
            profileSettingField(() {}, Icons.info,
                StringFormat.capitalize(AppLocalizations.of(context)!.help)),
            SizedBox(height: 5),
            profileSettingField(
                () {},
                Icons.dark_mode,
                StringFormat.capitalize(
                    AppLocalizations.of(context)!.darkMode)),
            SizedBox(height: 5),
            profileSettingField(() => LogOut(context), Icons.logout,
                StringFormat.capitalize(AppLocalizations.of(context)!.logout))
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

  void OpenBookedRoom(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) =>  BookedRoom(),
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
