import 'package:booking_hotel/screens/HomePage/home_page.dart';
import 'package:booking_hotel/screens/ProfilePage/account_page.dart';
import 'package:booking_hotel/components/CustomToast.dart';
import 'package:booking_hotel/screens/FavoritePage/favorite_page.dart';
import 'package:booking_hotel/screens/AllRoomPage/all_room_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  double sizeIcon = 30;
  int _currentIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  List<Widget> body = const [
    HomePage(),
    AllRoomPage(),
    FavoritePage(),
    AccountPage()
  ];
  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    // ignore: deprecated_member_use
    return WillPopScope(
      child: Scaffold(
        body: body[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            unselectedItemColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            selectedItemColor: Theme.of(context).colorScheme.onSurface,
            selectedFontSize: 14.0,
            unselectedFontSize: 12.0,
            type: BottomNavigationBarType.fixed,
            onTap: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _currentIndex == 0
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.3),
                ),
                label: "Trang chủ",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apartment,
                  color: _currentIndex == 1
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.3),
                ),
                label: 'Tất cả',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: _currentIndex == 2
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.3),
                ),
                label: 'Yêu thích',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: _currentIndex == 3
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.3),
                ),
                label: 'Cài đặt',
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        final differenece = DateTime.now().difference(timeBackPressed);
        final isExitWarning = differenece >= Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          final message = "Ấn quay về một lần nữa để thoát";
          NotifyToast(
                  context: context,
                  content: message,
                  duration: Duration(seconds: 2))
              .ShowToast();
          return false;
        } else {
          SystemNavigator.pop();
          return true;
        }
      },
    );
  }
}
