import 'package:booking_hotel/class/api_respond.dart';
import 'package:booking_hotel/class/shared_preferences.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:booking_hotel/model/room.dart';
import 'package:booking_hotel/model/user.dart';
import 'package:booking_hotel/screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<List<Room>> _favoriteRoom;
  late User? loggedInUser = null;
  void initializeData() async {
    await GetLoggedUser(); // Đợi GetLoggedUser hoàn thành
    GetData(); // Sau đó gọi GetData
  }

  Future<void> GetLoggedUser() async {
    loggedInUser = await UserPreferences.getUser();
    setState(() {});
  }

  void GetData() {
    if (loggedInUser != null) {
      _favoriteRoom = getFavoriteRoomsByIdUser(loggedInUser!.userId.toString());
      setState(() {});
    }
  }

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          forceMaterialTransparency: true,
          flexibleSpace: Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tìm kiếm ...',
                  prefixIcon: Icon(
                    Icons.search,
                  )),
            ),
          ),
        ),
        body: (loggedInUser == null)
            ? userIsNull()
            : showListFavoriteRooms(context),
      ),
    );
  }

  Widget userIsNull() {
    return Container(
      child: Center(
        child: Column(
          children: [
            InkWell(
              child: Text(
                "ĐĂNG NHẬP TẠI ĐÂY",
                style: GoogleFonts.montserrat(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SignInScreen(),
                  ),
                );
              },
            ),
            Text("Để hiển thị danh sách yêu thích!",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16))
          ],
        ),
      ),
    );
  }

  Widget showListFavoriteRooms(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 500,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            //width: double.infinity,
            //height: 500,
            child: FutureBuilder<List<Room>>(
              future: _favoriteRoom,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<Room> room = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: room.length,
                    itemBuilder: (BuildContext context, int index) {
                      return favoriteCard(room[index]);
                    },
                  );
                } else {
                  return Center(child: Text('Room not found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget favoriteCard(Room room) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
          color: Color(0xff3F2E3E), borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 110,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/' + room.roomImage)),
                    borderRadius: BorderRadius.circular(12)),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    room.hotelName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    room.hotelCity,
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
                        Text(
                          room.discountPrice.toString() + "đ/ngày",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
          Align(
            child: InkWell(
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
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
                    loggedInUser!.userId.toString(), room.roomId.toString());
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
            alignment: Alignment.topRight,
          )
        ],
      ),
    );
  }
}
