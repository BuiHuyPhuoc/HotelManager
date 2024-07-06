import 'package:booking_hotel/screens/BookingPage/widgets/item_payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _paymentPicked = -1;
  List<String> _listPaymentName = [
    "VNPay QR",
    "Thẻ nội địa và ngân hàng",
    "Ví điện tử VNPay"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          //backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Phương thức thanh toán",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _buildListPayment(context),
            ],
          ),
        ),
        bottomNavigationBar: ContinueButton(context),
      ),
    );
  }

  Widget _buildListPayment(BuildContext context) {
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
        return PaymentItemWidget(
          paymentName: _listPaymentName[index],
          isPicked: (_paymentPicked == index),
          onTap: () {
            setState(() {
              _paymentPicked = index;
            });
          },
        );
      },
    );
  }

  Widget ContinueButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {},
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.primary),
          child: Text(
            "Tiếp tục",
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
