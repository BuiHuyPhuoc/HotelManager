import 'dart:async';
import 'package:booking_hotel/class/consts.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<bool> makePayment(int amount) async {
    try {
      String? paymentIntentClientSecret = await _createPayment(amount, "vnd");
      if (paymentIntentClientSecret == null) return false;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: "Huy Phuoc"),
      );
      await _processPayment();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> _createPayment(int amount, String currency) async {
    try {
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency
      };
      final Dio dio = new Dio();
      var response = await dio.post("https://api.stripe.com/v1/payment_intents",
          data: data,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $stripeSecretKey',
          }));
      if (response.data != null) {
        return response.data["client_secret"];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
      // await Stripe.instance.confirmPaymentSheetPayment();
      
    } catch (e) {
      print(e);
      return false;
    }
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount;
    return calculateAmount.toString();
  }
}
