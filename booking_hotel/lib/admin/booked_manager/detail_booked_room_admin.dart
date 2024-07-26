// ignore_for_file: must_be_immutable
import 'package:booking_hotel/class/api_respond.dart';
import 'package:booking_hotel/class/string_format.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:booking_hotel/model/booking.dart';
import 'package:booking_hotel/model/room.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailBookedRoomAdmin extends StatefulWidget {
  DetailBookedRoomAdmin({super.key, required this.booking});
  Booking booking;

  @override
  State<DetailBookedRoomAdmin> createState() => _DetailBookedRoomAdminState();
}

class _DetailBookedRoomAdminState extends State<DetailBookedRoomAdmin> {
  bool isLoading = true;
  late Room room;
  late User? user;
  late Booking booking;

  void GetData() async {
    setState(() {
      isLoading = true;
    });
    booking = await getBookingByBookingId(widget.booking.bookingId.toString());
    room = await getRoomById(booking.roomId.toString());
    user = await getUserById(booking.userId.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          title: Text("Chi tiết đơn đặt"),
        ),
        body: showBookingDetail(),
        bottomNavigationBar: bottomNavigation(),
      ),
    );
  }

  Widget bottomNavigation() {
    return Container(
      height: 60,
      padding: EdgeInsets.all(10),
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                final ApiResponse result = await updateBookingStatus(
                    booking,
                    (booking.bookingStatus! == "Cancelled")
                        ? "Unpaid"
                        : "Cancelled");
                Navigator.pop(context);
                if (result.status) {
                  SuccessToast(
                          context: context,
                          content: AppLocalizations.of(context)!
                              .updateRoomStatusSuccess)
                      .ShowToast();
                } else {
                  WarningToast(context: context, content: result.message)
                      .ShowToast();
                }
                GetData();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant),
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(
                    StringFormat.capitalize((booking.bookingStatus == "Cancelled") ? AppLocalizations.of(context)!.undoTicket : AppLocalizations.of(context)!.cancelTicket),
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: (booking.bookingStatus == "Cancelled") ? 0 : 10,
          ),
          (booking.bookingStatus == "Cancelled")
              ? Container()
              : Expanded(
                  child: InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      final ApiResponse result = await updateBookingStatus(
                          booking,
                          (booking.bookingStatus! == "Unpaid")
                              ? "Paid"
                              : "Unpaid");
                      Navigator.pop(context);
                      if (result.status) {
                        SuccessToast(
                                context: context,
                                content: AppLocalizations.of(context)!
                                    .updateRoomStatusSuccess)
                            .ShowToast();
                      } else {
                        WarningToast(context: context, content: result.message)
                            .ShowToast();
                      }
                      GetData();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          StringFormat.capitalize(AppLocalizations.of(context)!
                              .bookingStatus(booking.bookingStatus.toString())),
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget showBookingDetail() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('images/hotel.jpg')),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      room.hotelName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.location_pin,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 30.0,
                        ),
                        Text(
                          room.hotelCity,
                          style: GoogleFonts.montserrat(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    area_userInfo(),
                    SizedBox(
                      height: 10,
                    ),
                    area_bookingInfo(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget area_bookingInfo() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            StringFormat.capitalizeEachWord(
                AppLocalizations.of(context)!.bookingInfomation),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Checkin: " +
                DateFormat('dd-MM-yyyy').format(
                  DateTime.parse(booking.startDate),
                ),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Checkout: " +
                DateFormat('dd-MM-yyyy').format(
                  DateTime.parse(booking.endDate),
                ),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            StringFormat.capitalizeEachWord(
                    AppLocalizations.of(context)!.bookingDate) +
                ": " +
                DateFormat('dd-MM-yyyy').format(
                  DateTime.parse(booking.bookingDate),
                ),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget area_userInfo() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            StringFormat.capitalizeEachWord(
                AppLocalizations.of(context)!.cusInfomation),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.userInfo('fullName') +
                ": " +
                user!.userName,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.userInfo('email') +
                ": " +
                user!.userGmail,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.userInfo('phoneNumber') +
                ": " +
                user!.userPhone,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
