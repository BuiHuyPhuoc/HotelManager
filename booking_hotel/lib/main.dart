//import 'package:booking_hotel/booking_page.dart';
import 'package:booking_hotel/class/tuple.dart';
import 'package:booking_hotel/model/hotel.dart';
import 'package:booking_hotel/model/room.dart';
import 'package:booking_hotel/screens/ProfilePage/account_page.dart';
import 'package:booking_hotel/theme/theme_provider.dart';
//import 'package:booking_hotel/room_detail.dart';
import 'package:booking_hotel/widgets/promo_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  late Future<List<Tuple<Room, int>>> _defaultRooms;
  late Future<List<Tuple<Room, int>>> _saleRooms;
  List<String> _cities = [];
  void getData() async {
    _defaultRooms = getRoomsDefault();
    _saleRooms = getSaleRooms();
    _cities = await getCities();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Xử lý sự kiện khi nhấn vào icon menu
          },
        ),
      ),
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
                      "Ở Mọi Nơi",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Mà Bạn Tới!",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                // padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          border: Border.all(color: Theme.of(context).colorScheme.outline, width: 2.0),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tìm kiếm địa điểm',
                              prefixIcon: Icon(
                                Icons.search,
                                //color: Colors.black,
                              )),
                          onSubmitted: (String value) {
                            // Thực hiện tìm kiếm khi nhấn "Enter"
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: _cities.length,
                        itemBuilder: (BuildContext context, int index) {
                          return placeButton(_cities[index], false);
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
                "Các phòng hiện có",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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
                "Các phòng đang giảm giá",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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
              // SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   "Đánh giá tốt",
              //   style: GoogleFonts.montserrat(
              //       color: Colors.black,
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   //padding: EdgeInsets.all(10),
              //   height: 300,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: roomIsSellingCards,
              //   ),
              // ),
            ],
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

  // List<Widget> ShowSaleRooms() {
  //   return (_saleRooms != null) ? [
  //     Text(
  //       "Các phòng đang giảm giá",
  //       style: GoogleFonts.montserrat(
  //           color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  //     ),
  //     SizedBox(
  //       height: 10,
  //     ),
  //     Container(
  //       //padding: EdgeInsets.all(10),
  //       height: 300,
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: FutureBuilder<List<Room>>(
  //               future: _saleRooms,
  //               builder: (context, snapshot) {
  //                 if (snapshot.connectionState == ConnectionState.waiting) {
  //                   return Center(child: CircularProgressIndicator());
  //                 } else if (snapshot.hasError) {
  //                   return Center(child: Text('Error: ${snapshot.error}'));
  //                 } else if (snapshot.hasData) {
  //                   List<Room> room = snapshot.data!;
  //                   return ListView.builder(
  //                     scrollDirection: Axis.horizontal,
  //                     shrinkWrap: false,
  //                     itemCount: room.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return PromoCard(room[index]);
  //                     },
  //                   );
  //                 } else {
  //                   return Center(child: Text('Room not found'));
  //                 }
  //               },
  //             ),
  //           )
  //         ],
  //       ),
  //     )
  //   ] : [];
  // }

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
