// ignore_for_file: unused_import

import 'dart:async';
import 'dart:io';
import 'package:booking_hotel/admin/booked_manager/manager_booked_room.dart';
import 'package:booking_hotel/class/consts.dart';
import 'package:booking_hotel/class/firebase_notification.dart';
import 'package:booking_hotel/class/language_preferences.dart';
import 'package:booking_hotel/class/string_format.dart';
import 'package:booking_hotel/class/user_preferences.dart';
import 'package:booking_hotel/controller/network_controller.dart';
import 'package:booking_hotel/model/login_device.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:booking_hotel/screens/BookingPage/room_detail.dart';
import 'package:booking_hotel/screens/signup_screen.dart';
import 'package:booking_hotel/widgets/test_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:booking_hotel/screens/auth_page.dart';
import 'package:booking_hotel/screens/home_layout.dart';
import 'package:booking_hotel/theme/theme_provider.dart';
import 'package:booking_hotel/screens/signin_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:booking_hotel/screens/BookingPage/payment_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _setUp() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = stripePublishableKey;
}

void main() async {
  await _setUp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  void setLocale(Locale value) {
    setState(() {
      Get.locale = value;
      LanguagePreferences.saveLanguage(value); // Save language preference
    });
  }

  Locale getLocale() {
    return Get.locale!;
  }

  Future<void> _loadLocale() async {
    final Locale locale = await LanguagePreferences.getLanguage();
    setState(() {
      Get.locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadLocale();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(NetworkController());
    return Consumer<ThemeProvider>(builder: (context, ThemeProvider, child) {
      return GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Get.locale, 
        fallbackLocale: Locale(
            'en'), 
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
        theme: ThemeProvider.themeData,
      );
    });
  }
}
