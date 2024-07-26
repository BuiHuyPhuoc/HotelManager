// ignore_for_file: must_be_immutable

import 'package:booking_hotel/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentItemWidget extends StatelessWidget {
  PaymentItemWidget(
      {super.key,
      required this.imagePath,
      required this.paymentName,
      this.onTap});
      String imagePath;
  String paymentName;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary),
        child: Row(
          children: [
            CustomImageView(
              imagePath: imagePath,
              height: 40,
              width: 40,
              radius: BorderRadius.circular(50),
              border: Border.all(
                width: 2,
                color: Colors.white
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 7, left: 12, bottom: 2),
                child: Text(
                  paymentName,
                  style: GoogleFonts.montserrat(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
