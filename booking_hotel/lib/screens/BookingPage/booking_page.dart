// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:booking_hotel/class/api_respond.dart';
import 'package:booking_hotel/model/booking.dart';
import 'package:booking_hotel/model/room.dart';
import 'package:booking_hotel/class/shared_preferences.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:booking_hotel/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingPage extends StatefulWidget {
  BookingPage({super.key, required this.idRoom});

  String idRoom;
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late Future<Room> room;
  late Room roominfo;
  late User? loggedInUser = null;
  void getData() async {
    room = getRoomById(widget.idRoom);
    room.then((data) {
      roominfo = data;
    });
    loggedInUser = await UserPreferences.getUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(51, 66, 77, 1),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            //color: Colors.white,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        color: Theme.of(context).colorScheme.surface,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Thông Tin Đặt Phòng",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                //color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        height: 250,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ],
                  ),
                  Container(
                    height: 350,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          //width: MediaQuery.of(context).size.width - 70,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TableCalendar(
                            headerStyle: HeaderStyle(
                              titleTextStyle: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              weekendStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            rangeSelectionMode: RangeSelectionMode.toggledOn,
                            focusedDay: _focusedDay,
                            firstDay: DateTime.now(),
                            rangeStartDay: _rangeStart,
                            rangeEndDay: _rangeEnd,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            lastDay: DateTime.utc(2030, 3, 14),
                            calendarFormat: _calendarFormat,
                            daysOfWeekHeight: 20,
                            rowHeight: 35,
                            calendarStyle: CalendarStyle(
                              defaultTextStyle: TextStyle(color: Colors.black),
                              todayDecoration: BoxDecoration(
                                color: Color.fromARGB(255, 109, 109, 109),
                                shape: BoxShape.circle,
                              ),
                              rangeStartDecoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              rangeHighlightColor: Colors.grey,
                              rangeEndDecoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                            onRangeSelected: (start, end, focusedDay) {
                              setState(() {
                                _selectedDay = null;
                                _focusedDay = focusedDay;
                                _rangeStart = start;
                                _rangeEnd = end;
                              });
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              // decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  BookingInfoCard(),
                  SizedBox(
                    height: 10,
                  ),
                  SubmitBookingButton(),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget BookingInfoCard() {
    Widget fieldInfo(String title, String content) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: GoogleFonts.montserrat(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: content,
              style: GoogleFonts.montserrat(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 16,
              ),
            )
          ],
        ),
      );
    }

    return FutureBuilder<Room>(
      future: room,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          Room room = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onSurface),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (loggedInUser == null)
                  ? [
                      Center(
                        child: Text(
                          "VUI LÒNG ĐĂNG NHẬP TRƯỚC KHI THỰC HIỆN ĐẶT PHÒNG",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface),
                        ),
                      ),
                      Center(
                          child: InkWell(
                        child: Text(
                          "Nhấn vào đây để đăng nhập",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context).colorScheme.surface),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (e) => const SignInScreen(),
                            ),
                          );
                        },
                      ))
                    ]
                  : [
                      Text(
                        "Thông tin người đặt.",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      fieldInfo(
                          "Ngày đặt: ",
                          (_rangeStart != null && _rangeEnd != null)
                              ? DateFormat('dd/MM/yyyy').format(_rangeStart!) +
                                  ' - ' +
                                  DateFormat('dd/MM/yyyy').format(_rangeEnd!)
                              : 'Chưa chọn ngày.'),
                      SizedBox(
                        height: 5,
                      ),
                      fieldInfo("Địa chỉ khách sạn: ", room.hotelAddress),
                      SizedBox(
                        height: 5,
                      ),
                      fieldInfo("Mã phòng: ", room.roomId.toString()),
                      SizedBox(
                        height: 5,
                      ),
                      fieldInfo("Họ tên người đặt: ", loggedInUser!.userName),
                      SizedBox(
                        height: 5,
                      ),
                      fieldInfo("Tiền phòng: ", NumberFormat('#').format(room.discountPrice) + 'đ'),
                    ],
            ),
          );
        } else {
          return Center(child: Text('Room not found'));
        }
      },
    );
  }

  Widget SubmitBookingButton() {
    return (loggedInUser == null)
        ? Container()
        : InkWell(
            onTap: () async {
              room.then((data) async {
                if (_rangeStart == null || _rangeEnd == null){
                  WarningToast(context: context, content: "Chưa chọn ngày đi và về.").ShowToast();
                  return;
                }
                Booking booking = new Booking(
                  startDate: _rangeStart!.toIso8601String(),
                  endDate: _rangeEnd!.toIso8601String(),
                  bookingStatus: "Đã đặt",
                  bookingPaid: 0,
                  bookingPrice: data.price,
                  userId: loggedInUser!.userId!,
                  bookingDiscount: data.discountPrice,
                  roomId: data.roomId,
                );
                ApiResponse response = await createBooking(booking);
                if (response.status) {
                  SuccessToast(
                    context: context,
                    content: response.message,
                    duration: Duration(seconds: 1),
                  ).ShowToast();
                  return;
                } else {
                  WarningToast(context: context, content: response.message, duration: Duration(seconds: 1),).ShowToast();
                  return;
                }
              });
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              child: Center(
                child: Text(
                  "XÁC NHẬN ĐẶT",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.surface),
                ),
              ),
            ),
          );
  }
}
