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
      bool result = true;
      result = await _processPayment();
      if (result) {
        return true;
      }
      return false;
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
      //await Stripe.instance.confirmPaymentSheetPayment();

      // If the above lines do not throw an error, the payment was successful.
      print('Payment successful');
      return true;
    } catch (e) {
      if (e is StripeException) {
        print('Error from Stripe: ${e.error.localizedMessage}');
        return false;
      } else {
        print('Error: $e');
      }
      return false;
    }
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount;
    return calculateAmount.toString();
  }
}
