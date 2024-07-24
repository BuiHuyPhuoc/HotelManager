import 'package:booking_hotel/admin/booked_manager/detail_booked_room_admin.dart';
import 'package:booking_hotel/class/string_format.dart';
import 'package:booking_hotel/class/user_preferences.dart';
import 'package:booking_hotel/model/booking.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BookedRoom extends StatefulWidget {
  BookedRoom({super.key});

  @override
  State<BookedRoom> createState() => _BookedRoomState();
}

class _BookedRoomState extends State<BookedRoom> {
  late Future<List<Booking>> _bookingRoom;

  void GetData() async {
    User? getLoggedUser = await UserPreferences.getUser();
    _bookingRoom = getBookingByUserId(getLoggedUser!.userId.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            AppLocalizations.of(context)!.bookingRooms,
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: 20, left: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              //bookingRoomCard(null)
              Expanded(
                child: FutureBuilder<List<Booking>>(
                  future: _bookingRoom,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<Booking> bookingRoom = snapshot.data!;
                      return (bookingRoom.length == 0)
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .youDontHaveAnyBookedRoom,
                                style: GoogleFonts.manrope(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: bookingRoom.length,
                              itemBuilder: (BuildContext context, int index) {
                                return bookingRoomCard(bookingRoom[index]);
                              },
                            );
                    } else {
                      return Center(child: Text('Room not found'));
                    }
                  },
                ),
                //child: bookingRoomCard(null),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookingRoomCard(Booking room) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringFormat.capitalize(AppLocalizations.of(context)!.idRoom) +
                    ": " +
                    room.roomId.toString(),
                style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Checkin: " +
                    DateFormat('dd-MM-yyyy').format(
                      DateTime.parse(room.startDate),
                    ),
                style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.8)),
              ),
              SizedBox(height: 5),
              Text(
                "Checkout: " +
                    DateFormat('dd-MM-yyyy').format(
                      DateTime.parse(room.endDate),
                    ),
                style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.8)),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.outline, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  AppLocalizations.of(context)!
                      .bookingStatus(room.bookingStatus!),
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          StringFormat.capitalize(
                              AppLocalizations.of(context)!.cancelTicket),
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final bool? shouldRefresh = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (e) => DetailBookedRoomAdmin(booking: room),
                          ),
                        );
                        if (shouldRefresh != null && shouldRefresh) {
                          GetData();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            StringFormat.capitalize(
                                AppLocalizations.of(context)!.viewTicket),
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
              )
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: IntrinsicWidth(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 2),
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(
                    "ID: " + room.bookingId.toString(),
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
