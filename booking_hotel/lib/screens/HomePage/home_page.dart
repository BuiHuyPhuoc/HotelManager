import 'package:booking_hotel/class/tuple.dart';
import 'package:booking_hotel/model/room.dart';
import 'package:booking_hotel/widgets/promo_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Tuple<Room, int>>> _defaultRooms;
  late Future<List<Tuple<Room, int>>> _saleRooms;
  void getData() async {
    _defaultRooms = getRoomsDefault();
    _saleRooms = getSaleRooms();
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  //padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.homePageLogan1,
                        style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      SizedBox(height: 5),
                      Text(
                        AppLocalizations.of(context)!.homePageLogan2,
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.bestHotelLabel,
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  //padding: EdgeInsets.all(10),
                  height: 300,
                  child: Row(
                    children: [
                      Expanded(
                        child: FutureBuilder<List<Tuple<Room, int>>>(
                          future: _defaultRooms,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              List<Tuple<Room, int>> room = snapshot.data!;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: false,
                                itemCount: room.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return PromoCard(room[index]);
                                },
                              );
                            } else {
                              return Center(child: Text('Room not found'));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.currentSale,
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  //padding: EdgeInsets.all(10),
                  height: 300,
                  child: Row(
                    children: [
                      Expanded(
                        child: FutureBuilder<List<Tuple<Room, int>>>(
                          future: _saleRooms,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              List<Tuple<Room, int>> room = snapshot.data!;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: false,
                                itemCount: room.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return PromoCard(room[index]);
                                },
                              );
                            } else {
                              return Center(child: Text('Room not found'));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget placeButton(String place, bool isPicked) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: !isPicked ? Colors.grey : Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
      child: Center(
          child: Text(
        place,
        style: TextStyle(color: Colors.white, fontSize: 16),
      )),
    );
  }

  Widget placeButton_picked(String place) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
      child: Center(
          child: Text(
        place,
        style: TextStyle(color: Colors.white, fontSize: 16),
      )),
    );
  }
}
