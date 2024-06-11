import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RoomDetail extends StatelessWidget {
  const RoomDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/hotel.jpg')),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Hotel Grand Park",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          RatingBar(
                              itemSize: 30,
                              minRating: 0,
                              maxRating: 3,
                              itemCount: 4,
                              ratingWidget: RatingWidget(
                                  full: Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  empty: Icon(
                                    Icons.star,
                                    color: const Color.fromRGBO(158, 158, 158, 1),
                                  ),
                                  half: Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  )),
                              onRatingUpdate: (rating) {
                                print(rating);
                              }),
                          Text(
                            "(123 lượt đánh giá)",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.location_pin,
                            color: Colors.grey,
                            size: 30.0,
                          ),
                          Text(
                            "Thành phố Vũng Tàu",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Chi tiết",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Bao đầy đủ nội thất, kể cả là hồ bơi và nhà bếp. Khách sạn có sẵn 3 phòng vệ sinh bao gồm cả bồn tắm và dầu gội.",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Dịch vụ tiện nghi",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              amenityIcon(
                                  icon: Icon(Icons.wifi),
                                  color: Colors.cyan,
                                  text: "Wifi"),
                              amenityIcon(
                                  icon: Icon(Icons.bed),
                                  color: Colors.orange,
                                  text: "Nệm"),
                              amenityIcon(
                                  icon: Icon(Icons.ac_unit),
                                  color: Colors.blue,
                                  text: "AC"),
                              amenityIcon(
                                  icon: Icon(Icons.pool),
                                  color:
                                      const Color.fromARGB(255, 255, 241, 115),
                                  text: "Bể bơi"),
                              amenityIcon(
                                  icon: Icon(Icons.local_parking),
                                  color: Color.fromARGB(255, 122, 195, 255),
                                  text: "Bãi xe"),
                              amenityIcon(
                                  icon: Icon(Icons.restaurant),
                                  color: Color.fromARGB(255, 255, 224, 98),
                                  text: "Nhà hàng"),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          )),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black, width: 1))),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: RichText(
                        text: TextSpan(children: [
                  TextSpan(
                      text: '250\$',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '\ / night',
                      style: TextStyle(color: Colors.grey, fontSize: 18))
                ]))),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(16, 74, 112, 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    "ĐẶT NGAY",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ))
              ],
            ),
          )
        ],
      ),
    )));
  }

  Widget amenityIcon(
      {required Color color, required Icon icon, required String text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 70,
          height: 70,
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Center(
            child: icon,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 15),
          child: Text(
            text,
            textAlign: TextAlign.center, // Căn giữa nội dung của Text nếu cần
          ),
        ),
      ],
    );
  }
}
