// ignore_for_file: must_be_immutable

import 'package:booking_hotel/class/stripe_service.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:booking_hotel/model/booking.dart';
import 'package:booking_hotel/screens/BookingPage/success_page.dart';
import 'package:booking_hotel/screens/BookingPage/widgets/item_payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({super.key, required this.booking});
  Booking booking;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    List<PaymentItemWidget> _listPaymentName = [
      PaymentItemWidget(
        imagePath: "images/vnpay_logo.png",
        paymentName: "VNPay",
        onTap: () {
          NotifyToast(
            context: context,
            content: AppLocalizations.of(context)!.featureIsUpdating,
          ).ShowToast();
          return;
        },
      ),
      PaymentItemWidget(
        imagePath: "images/paypal_logo.png",
        paymentName: "Paypal",
        onTap: () {
          NotifyToast(
            context: context,
            content: AppLocalizations.of(context)!.featureIsUpdating,
          ).ShowToast();
          return;
        },
      ),
      PaymentItemWidget(
        imagePath: "images/stripe_logo.png",
        paymentName: "Stripe",
        onTap: () async {
          try {
            bool result = await StripeService.instance
                .makePayment(widget.booking.bookingPrice.toInt());
            if (result) {
              createBooking(widget.booking);
              
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SuccessPage()),
                  (Route<dynamic> route) => false);
            } else {
              WarningToast(
                    context: context,
                    content: AppLocalizations.of(context)!.errorWarning)
                .ShowToast();
            }
          } catch (e) {
            print(e);
            WarningToast(
                    context: context,
                    content: AppLocalizations.of(context)!.errorWarning)
                .ShowToast();
          }
        },
      ),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          //backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.choosePaymentMethod,
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _buildListPayment(context, _listPaymentName),
            ],
          ),
        ),
        bottomNavigationBar: BackButton(context),
      ),
    );
  }

  Widget _buildListPayment(
      BuildContext context, List<PaymentItemWidget> _listPaymentName) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 20,
        );
      },
      itemCount: 3,
      itemBuilder: (context, index) {
        return _listPaymentName[index];
      },
    );
  }

  Widget BackButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Xác nhận thoát?"),
              content: Text(
                  "Nếu thoát bây giờ, đơn đặt phòng của bạn sẽ không được ghi nhận lại."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)!.choice('cancel'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context); // Pop dialog
                    Navigator.pop(context); // Pop current widget
                    WarningToast(
                      context: context,
                      content: "Đơn đặt của bạn đã bị huỷ.",
                    ).ShowToast();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.choice('accept'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.primary),
          child: Text(
            AppLocalizations.of(context)!.backButton.toUpperCase(),
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }

  void Stripe_Payment() async {}
}
