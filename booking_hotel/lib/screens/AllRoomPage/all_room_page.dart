import 'package:booking_hotel/class/enum_variable.dart';
import 'package:booking_hotel/model/hotel.dart';
import 'package:booking_hotel/model/room.dart';
import 'package:booking_hotel/widgets/withoutlike_promo_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllRoomPage extends StatefulWidget {
  const AllRoomPage({super.key});

  @override
  State<AllRoomPage> createState() => _AllRoomPageState();
}

class _AllRoomPageState extends State<AllRoomPage> {
  List<String> categories = ["Tất cả", "Theo khách sạn", "Theo thành phố"];

  List<Room> _rooms = [];
  List<Hotel> _hotels = [];
  int _value = 0;
  String cateType = "Tất cả";
  void getData() async {
    _rooms = await getAllRooms();
    _hotels = await getHotels();
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
    List<String> categoriesTranslate = [AppLocalizations.of(context)!.all, AppLocalizations.of(context)!.byHotel, AppLocalizations.of(context)!.byCity];

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              // Các Choice Chip
              Container(
                height: 60,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    shrinkWrap: false,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          ChoiceChip(
                            labelStyle: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary),
                            label: Text(categoriesTranslate[index]),
                            selected: _value == index,
                            onSelected: (bool selected) {
                              setState(() {
                                _value = selected ? index : 0;
                                cateType = categories[_value];
                              });
                            },
                            selectedColor:
                                Theme.of(context).colorScheme.primary,
                            shadowColor: Theme.of(context).colorScheme.shadow,
                            backgroundColor: (_value == index)
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.3),
                            checkmarkColor:
                                Theme.of(context).colorScheme.onPrimary,
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              _devidedByCategory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _devidedByCategory() {
    switch (cateType.categoryType) {
      case (Category.All):
        return _showGridByCategory();
      case (Category.City || Category.Hotel):
        return _showListByCategory();
    }
  }

  Widget _showListByCategory() {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.vertical,
                itemCount: _hotels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _rooms.any((room) {
                      if (cateType.categoryType == Category.Hotel) {
                        if (room.hotelName == _hotels[index].hotelName)
                          return true;
                      } else if (cateType.categoryType == Category.City) {
                        if (room.hotelCity == _hotels[index].hotelCity)
                          return true;
                      }
                      return false;
                    })
                        ? [
                            Text(
                              (cateType.categoryType == Category.Hotel)
                                  ? AppLocalizations.of(context)!.hotel + " " + _hotels[index].hotelName
                                  : AppLocalizations.of(context)!.city + " " + _hotels[index].hotelCity,
                              style: GoogleFonts.montserrat(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _showRoomsByCate(
                                (cateType.categoryType == Category.Hotel)
                                    ? _hotels[index].hotelName
                                    : _hotels[index].hotelCity),
                            SizedBox(
                              height: 20,
                            ),
                          ]
                        : [],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showGridByCategory() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Số cột
          crossAxisSpacing: 10.0, // Khoảng cách ngang giữa các ô
          mainAxisSpacing: 10.0, // Khoảng cách dọc giữa các ô
          childAspectRatio: 3 / 4,
        ),
        itemCount: _rooms.length,
        itemBuilder: (context, index) {
          return PromoCardWithoutLike(_rooms[index]);
        },
      ),
    );
  }

  bool isHasRoom(String condition) {
    bool result = _rooms.any((room) {
      return (room.hotelName == condition &&
              cateType.categoryType == Category.Hotel) ||
          (cateType.categoryType == Category.City &&
              room.hotelCity == condition);
    });
    return result;
  }

  Widget _showRoomsByCate(String condition) {
    List<Room> listToShow = [];
    _rooms.forEach((room) {
      if ((room.hotelName == condition &&
              cateType.categoryType == Category.Hotel) ||
          (cateType.categoryType == Category.City &&
              room.hotelCity == condition)) {
        listToShow.add(room);
      }
    });
    return Container(
      height: 300,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              itemCount: listToShow.length,
              itemBuilder: (BuildContext context, int index) {
                return PromoCardWithoutLike(
                  listToShow[index],
                  marginLeft: 15,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
