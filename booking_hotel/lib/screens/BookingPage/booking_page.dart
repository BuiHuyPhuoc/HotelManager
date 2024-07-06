// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:collection';
import 'package:booking_hotel/class/api_respond.dart';
import 'package:booking_hotel/class/enum_variable.dart';
import 'package:booking_hotel/class/event.dart';
import 'package:booking_hotel/class/money_format.dart';
import 'package:booking_hotel/model/booking.dart';
import 'package:booking_hotel/model/room.dart';
import 'package:booking_hotel/class/shared_preferences.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:booking_hotel/screens/BookingPage/success_page.dart';
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
  //DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late Future<Room> room;
  late Room roominfo;
  late User? loggedInUser = null;
  late List<Booking> _bookedList = [];
  final events = LinkedHashMap<DateTime, List<BookingDate>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    room = getRoomById(widget.idRoom);
    room.then((data) {
      roominfo = data;
    });
    loggedInUser = await UserPreferences.getUser();
    _bookedList = await getBookingById(widget.idRoom);

    for (var item in _bookedList) {
      DateTime startDate = DateTime.parse(item.startDate);
      DateTime endDate = DateTime.parse(item.endDate);
      List<BookingDate> _listDayAdd =
          _listBookingDateFromRange(startDate, endDate);

      for (var date in _listDayAdd) {
        if (events.containsKey(date.dateTime)) {
          events[date.dateTime]!.add(date);
        } else {
          events[date.dateTime] = [date];
        }
      }
    }
    setState(() {});
  }

  List<BookingDate> _getBookingDate(DateTime day) {
    return events[day] ?? [];
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
    });
  }

  Widget _onRangeDecoration(DateTime date) {
    return Center(
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _defaultDecoration(DateTime date) {
    List<BookingDate> _getEvents = events[date] ?? [];
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black;
    for (var event in _getEvents) {
      if (event.type == BookingDateType.Allday || _getEvents.length == 2) {
        backgroundColor = Colors.grey.withOpacity(0.8);
        textColor = Colors.black;
        break;
      }
      if (event.type == BookingDateType.Checkin) {
        backgroundColor = Colors.yellowAccent;
      }
      if (event.type == BookingDateType.Checkout) {
        backgroundColor = Colors.cyan;
      }
    }
    return Center(
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(51, 66, 77, 1),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface,
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
                                color: Theme.of(context).colorScheme.onSurface,
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
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TableCalendar(
                            headerStyle: HeaderStyle(
                              titleTextStyle: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              formatButtonVisible: false,
                              leftChevronIcon: Icon(
                                Icons.chevron_left,
                                color: Colors.black,
                              ),
                              rightChevronIcon: Icon(
                                Icons.chevron_right,
                                color: Colors.black,
                              ),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              weekendStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            eventLoader: (date) => _getBookingDate(date),
                            rangeSelectionMode: RangeSelectionMode.toggledOn,
                            focusedDay: _focusedDay,
                            firstDay: DateTime.now(),
                            rangeStartDay: _rangeStart,
                            rangeEndDay: _rangeEnd,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            lastDay: DateTime.utc(2030, 3, 14),
                            calendarFormat: _calendarFormat,
                            daysOfWeekHeight: 20,
                            rowHeight: 36,
                            calendarStyle: CalendarStyle(
                              markerDecoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              defaultTextStyle: TextStyle(color: Colors.black),
                              todayDecoration: BoxDecoration(
                                color: Color.fromARGB(255, 76, 76, 76),
                                shape: BoxShape.circle,
                              ),
                              rangeStartDecoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              rangeHighlightColor:
                                  const Color.fromARGB(255, 118, 118, 118),
                              rangeEndDecoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                            onRangeSelected: _onRangeSelected,
                            onFormatChanged: (format) {
                              if (_calendarFormat != format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              }
                            },
                            onPageChanged: (focusedDay) {
                              _focusedDay = focusedDay;
                            },
                            calendarBuilders: CalendarBuilders(
                              defaultBuilder: (context, date, events) {
                                return _defaultDecoration(date);
                              },
                              rangeEndBuilder: (context, day, focusedDay) {
                                return _onRangeDecoration(day);
                              },
                              rangeStartBuilder: (context, day, events) {
                                return _onRangeDecoration(day);
                              },
                              todayBuilder: (context, date, events) {
                                return _defaultDecoration(date);
                              },
                            ),
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
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: content,
              style: GoogleFonts.montserrat(
                color: Theme.of(context).colorScheme.onPrimary,
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
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary),
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
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "ĐƠN ĐẶT",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      fieldInfo(
                          "Ngày checkin: ",
                          (_rangeStart != null)
                              ? DateFormat('dd/MM/yyyy').format(_rangeStart!)
                              : 'Trống.'),
                      SizedBox(
                        height: 5,
                      ),
                      fieldInfo(
                          "Ngày checkout: ",
                          (_rangeEnd != null)
                              ? DateFormat('dd/MM/yyyy').format(_rangeEnd!)
                              : 'Trống.'),
                      SizedBox(
                        height: 5,
                      ),
                      fieldInfo("Giờ checkin: ", "14:00 chiều"),
                      SizedBox(
                        height: 5,
                      ),
                      fieldInfo("Giờ checkout: ", "12:00 trưa"),
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
                      fieldInfo(
                          "Tiền phòng: ",
                          (_rangeStart != null && _rangeEnd != null)
                              ? formatMoney(room.discountPrice *
                                  _rangeEnd!.difference(_rangeStart!).inDays)
                              : ""),
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
                if (_rangeStart == null || _rangeEnd == null) {
                  WarningToast(
                          context: context, content: "Chưa chọn ngày đi và về.")
                      .ShowToast();
                  return;
                }

                if (!_checkSelectedDate()) {
                  WarningToast(
                          context: context,
                          content: "Lỗi vi phạm ngày đặt phòng.")
                      .ShowToast();
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
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SuccessPage()),
                      (Route<dynamic> route) => false);
                } else {
                  WarningToast(
                    context: context,
                    content: response.message,
                    duration: Duration(seconds: 1),
                  ).ShowToast();
                  return;
                }
              });
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  "XÁC NHẬN ĐẶT",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          );
  }

  bool _checkSelectedDate() {
    Map<DateTime, List<BookingDate>> _selectedBookingDate =
        _getListBookingDate(_rangeStart!, _rangeEnd!);
    for (var selectedDate in _selectedBookingDate[_rangeStart!]!) {
      if (events[selectedDate.dateTime] != null) {
        for (var event in events[selectedDate.dateTime]!) {
          if (event.type == BookingDateType.Allday) {
            return false;
          }
          if (selectedDate.type == BookingDateType.Allday) {
            return false;
          }
          if (selectedDate.type == event.type) {
            return false;
          }
          if (selectedDate.type == BookingDateType.Checkout &&
              event.type == BookingDateType.Checkin) {
            return false;
          }
          return true;
        }
      } else {
        return true;
      }
    }
    return true;
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

Map<DateTime, List<BookingDate>> _getListBookingDate(
    DateTime first, DateTime last) {
  LinkedHashMap<DateTime, List<BookingDate>> _listDate =
      LinkedHashMap<DateTime, List<BookingDate>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  _listDate[first] = [
    BookingDate(dateTime: first, type: BookingDateType.Checkin)
  ];

  for (var i = 1; i < last.difference(first).inDays; i++) {
    var date = first.add(Duration(days: i));
    _listDate[date] = [
      BookingDate(dateTime: date, type: BookingDateType.Allday)
    ];
  }

  _listDate[last] = [
    BookingDate(dateTime: last, type: BookingDateType.Checkout)
  ];

  return _listDate;
}

List<BookingDate> _listBookingDateFromRange(DateTime first, DateTime last) {
  List<BookingDate> _returnList = [];
  _returnList.add(BookingDate(dateTime: first, type: BookingDateType.Checkin));
  for (var i = 1; i < last.difference(first).inDays; i++) {
    var date = first.add(Duration(days: i));
    _returnList.add(BookingDate(dateTime: date, type: BookingDateType.Allday));
  }
  _returnList.add(BookingDate(dateTime: last, type: BookingDateType.Checkout));
  return _returnList;
}
