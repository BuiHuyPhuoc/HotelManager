import 'package:booking_hotel/screens/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingSuccess extends StatelessWidget {
  const BookingSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bg1.jpg"), fit: BoxFit.fill),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "ĐẶT PHÒNG THÀNH CÔNG",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Chúng tôi đã ghi nhận đơn đặt của bạn.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Trở về trang chủ",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                  ),
                  onTap: () {
                    
                     Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (e) => const HomeLayout(),
                            ),
                          );
                  },
                )
              ],
            )),
      ),
    );
  }
}
