import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourism/Home/Guide/guideHome.dart';
import 'package:tourism/Home/Guide/newBooking.dart';
import 'package:tourism/Home/Guide/profile.dart';
import 'package:tourism/const/const.dart';

class GuideNqavBar extends StatefulWidget {
  final String userType;

  const GuideNqavBar({super.key, required this.userType});

  @override
  State<GuideNqavBar> createState() => _GuideNqavBarState();
}

class _GuideNqavBarState extends State<GuideNqavBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    GuideHomePage(userType: "Guide"),
    NewBookings(userType: "Guide"),
    GuideProfile(userType: "Guide"),
  ];
// flutter build appbundle --release --no-sound-null-safety
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 55,
          //  color: Colors.white,
          child: SizedBox(
            height: 55,    width: MediaQuery.of(context).size.width,
            child: CupertinoTabBar(
              activeColor: bg2,
              currentIndex: _selectedIndex,
              backgroundColor: Colors.white,
              // selectedFontSize: 10,
              // selectedIconTheme: IconThemeData(
              //   color: kBlackColor,
              //   //size: 28,
              // ),
              iconSize: 40,
              //  showSelectedLabels: true,
              // showUnselectedLabels: true,
              // type: BottomNavigationBarType.fixed,
              // selectedItemColor: kDarkGreyColor,
              // selectedLabelStyle: TextStyle(fontSize: 10, color: kBlackColor,),
              onTap: _onItemTapped,
              items:  [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/unbooking.png', height: 25, width: 25, fit: BoxFit.scaleDown,),
                  activeIcon: Image.asset('assets/icons/booking.png', height: 25, width: 25, fit: BoxFit.scaleDown,),
                  label: 'My Bookings',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/unbooking.png',height: 25, width: 30, fit: BoxFit.scaleDown,),
                  activeIcon: Image.asset('assets/icons/booking.png',height: 25, width: 30, fit: BoxFit.scaleDown,),
                  label: 'New Bookings',
                ),
                // BottomNavigationBarItem(
                //   icon: Image.asset('assets/icons/unbooking.png',height: 25, width: 25, fit: BoxFit.scaleDown,),
                //   activeIcon: Image.asset('assets/icons/booking.png',height: 25, width: 25, fit: BoxFit.scaleDown,),
                //   label: 'News',
                // ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/unprofile.png', height: 25, width: 25, fit: BoxFit.scaleDown,),
                  activeIcon: Image.asset('assets/icons/profile.png', height: 25, width: 25, fit: BoxFit.scaleDown,),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
        //   ],
        // ),
      ),
    );
  }
}
