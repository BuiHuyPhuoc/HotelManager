import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          forceMaterialTransparency: true,
          flexibleSpace: Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tìm kiếm ...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            ),
          ),
        ),
        body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey, width: 1))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "6 nơi đã thích.",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      favoriteCard(),
                      favoriteCard(),
                      favoriteCard(),
                      favoriteCard(),
                      favoriteCard(),
                      favoriteCard(),
                    ],
                  ),
                ))
              ],
            )),
      ),
    );
  }

  Widget favoriteCard() {
    return Container(
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Color(0xff3F2E3E), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('images/hotel2.jpg')),
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Khách sạn ABC",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Vũng Tàu",
                style: TextStyle(
                    fontSize: 16, color: Colors.white.withOpacity(0.8)),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: <Widget>[
                    Text("250.000/đêm",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8)))
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
