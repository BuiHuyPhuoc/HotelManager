import 'package:booking_hotel/class/hotel.dart';
import 'package:booking_hotel/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Room> rooms = [];
    rooms.add(Room(
        name: "ABC",
        place: "Vũng Tàu",
        address: "Thành phố Vũng Tàu",
        description: "Thoáng mát sạch sẽ",
        numBed: 4,
        price: 500,
        image: 'hotel.jpg'));
    rooms.add(Room(
        name: "Helto",
        place: "Sapa",
        address: "Sapa",
        description: "Thoáng mát sạch sẽ",
        numBed: 4,
        price: 500,
        image: 'hotel2.jpg'));
    rooms.add(Room(
        name: "Alto",
        place: "Đà Nẵng",
        address: "Thành phố Đà Nẵng",
        description: "Thoáng mát sạch sẽ",
        numBed: 4,
        price: 500,
        image: 'hotel.jpg'));
    rooms.add(Room(
        name: "Nota",
        place: "Huế",
        address: "Thành phố Huế",
        description: "Thoáng mát sạch sẽ",
        numBed: 4,
        price: 500,
        image: 'hotel2.jpg'));
    rooms.add(Room(
        name: "YYY",
        place: "Phú Quốc",
        address: "Thành phố Phú Quốc",
        description: "Thoáng mát sạch sẽ",
        numBed: 4,
        price: 500,
        image: 'hotel.jpg'));
    List<Widget> roomCards = [];
    for (int i = 0; i < rooms.length; i++) {
      roomCards.add(promoCard(rooms[i]));
    }

    rooms = [];
    rooms.add(Room(
        name: "Alto",
        place: "Đà Nẵng",
        address: "Thành phố Đà Nẵng",
        description: "Thoáng mát sạch sẽ",
        numBed: 4,
        price: 500,
        image: 'hotel2.jpg'));
    rooms.add(Room(
        name: "Nota",
        place: "Huế",
        address: "Thành phố Huế",
        description: "Thoáng mát sạch sẽ",
        numBed: 4,
        price: 500,
        image: 'hotel.jpg'));
    rooms.add(Room(
        name: "YYY",
        place: "Phú Quốc",
        address: "Thành phố Phú Quốc",
        description: "Thoáng mát sạch sẽ",
        numBed: 4,
        price: 500,
        image: 'hotel2.jpg'));
    List<Widget> roomIsSellingCards = [];
    for (int i = 0; i < rooms.length; i++) {
      roomIsSellingCards.add(promoCard(rooms[i]));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Mà Bạn Tới!",
                      style: TextStyle(
                          color: Colors.black,
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
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tìm kiếm địa điểm',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
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
                height: 50,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      placeButton("Tất cả", true),
                      placeButton("Đà Nẵng", false),
                      placeButton("Sapa", false),
                      placeButton("Huế", false),
                      placeButton("Phú Quốc", false),
                      placeButton("Vũng Tàu", false)
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Sales",
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //padding: EdgeInsets.all(10),
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: roomCards,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Đánh giá tốt",
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //padding: EdgeInsets.all(10),
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: roomIsSellingCards,
                ),
              ),
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

  Widget promoCard(Room room) {
    return AspectRatio(
      aspectRatio: 2.6 / 3,
      child: Container(
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/' + room.image))),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                  0.1,
                  0.9
                ], colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.1)
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        room.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        room.place,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ))
              ],
            ),
          )),
    );
  }
}
