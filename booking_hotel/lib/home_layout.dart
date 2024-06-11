import 'package:booking_hotel/account_page.dart';
import 'package:booking_hotel/favorite_page.dart';
import 'package:booking_hotel/main.dart';
import 'package:booking_hotel/trip_page.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  double sizeIcon = 30;
  int _currentIndex = 0;
  List<Widget> body = const [
    HomePage(),
    FavoritePage(),
    TripPage(),
    AccountPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: body[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            unselectedItemColor: Colors.black,
            selectedFontSize: 14.0,
            unselectedFontSize: 12.0,
            type: BottomNavigationBarType.fixed,
            onTap: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _currentIndex == 0 ? Colors.black : Colors.grey,
                ),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: _currentIndex == 1 ? Colors.black : Colors.grey,
                ),
                label: 'Yêu thích',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.trip_origin,
                  color: _currentIndex == 2 ? Colors.black : Colors.grey,
                ),
                label: 'Trip',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: _currentIndex == 3 ? Colors.black : Colors.grey,
                ),
                label: 'Tài khoản',
              ),
            ],
          ),
        ));
  }

  
}
