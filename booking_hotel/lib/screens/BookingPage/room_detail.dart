import 'package:booking_hotel/class/api_respond.dart';
import 'package:booking_hotel/class/shared_preferences.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:booking_hotel/model/room.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:booking_hotel/screens/home_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class RoomDetail extends StatefulWidget {
  final String idRoom;

  RoomDetail(this.idRoom);

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  Room? room;
  late bool isFavorite = false;
  late User? loggedInUser;
  void GetData() async {
    room = await getRoomById(widget.idRoom);
    await GetLoggedUser();
    if (loggedInUser != null) {
      isFavorite = await isFavoriteRoom(
          room!.roomId.toString(), loggedInUser!.userId.toString());
    }
    setState(() {});
  }

  Future<void> GetLoggedUser() async {
    loggedInUser = await UserPreferences.getUser();
  }

  @override
  void initState() {
    super.initState();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
    if (room == null) {
      // Hiển thị màn hình chờ khi room chưa được khởi tạo
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeLayout()),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "CHI TIẾT PHÒNG",
          style:
              GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: buildRoomDetail(room!),
      ),
    );
  }

  Widget buildRoomDetail(Room room) {
    return Container(
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
                          image: AssetImage('images/' + room.roomImage)),
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
                          room.hotelName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  color:
                                      (isFavorite) ? Colors.red : Colors.grey,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  (!isFavorite)
                                      ? "Chọn yêu thích"
                                      : "Đã yêu thích",
                                  style: GoogleFonts.montserrat(fontSize: 18),
                                )
                              ],
                            ),
                            onTap: () async {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                              ApiResponse response = await addLikeRoom(
                                  loggedInUser!.userId.toString(),
                                  room.roomId.toString());
                              if (response.status) {
                                SuccessToast(
                                  context: context,
                                  content: response.message,
                                  duration: Duration(seconds: 1),
                                ).ShowToast();
                              } else {
                                WarningToast(
                                  context: context,
                                  content: response.message,
                                  duration: Duration(seconds: 1),
                                ).ShowToast();
                              }
                              GetData();
                              Navigator.of(context).pop();
                            },
                          ),
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
                              room.hotelCity,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Chi tiết",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          room.roomDescription,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Dịch vụ tiện nghi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
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
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (!(room.price == room.discountPrice)
                          ? Text(
                              room.price.toString() + "đ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            )
                          : Container()),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: NumberFormat("###.#")
                                      .format(room.discountPrice) +
                                  'đ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ),
                            TextSpan(
                              text: '\ / ngày',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(16, 74, 112, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "ĐẶT NGAY",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      onTap: () async {}),
                )
              ],
            ),
          )
        ],
      ),
    );
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
