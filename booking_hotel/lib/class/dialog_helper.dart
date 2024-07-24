// ignore_for_file: deprecated_member_use

import 'package:booking_hotel/class/string_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogHelper {
  static void showNoInternetDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(StringFormat.capitalize(AppLocalizations.of(Get.context!)!.lostInternetConnection)),
          content: Text(StringFormat.capitalize(AppLocalizations.of(Get.context!)!.checkInternetConnection)),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Get.back();
                // Kiểm tra lại kết nối internet và hiển thị lại dialog nếu vẫn chưa có kết nối
                bool isConnected = await InternetConnectionChecker().hasConnection;
                if (!isConnected) {
                  showNoInternetDialog();
                }
              },
              child: Text("OK"),
            )
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
