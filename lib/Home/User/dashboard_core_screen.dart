import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourism/Home/Admin/adminHome.dart';
import 'package:tourism/Home/Guide/guideHome.dart';
import 'package:tourism/Home/User/UserHomePage.dart';
import 'package:tourism/Home/User/bookedPlaces.dart';
import 'package:tourism/Home/User/profile.dart';
import 'package:tourism/const/const.dart';



class AppBottomNavigationBar extends StatefulWidget {
  final String userType;

  AppBottomNavigationBar({Key? key, required this.userType}) : super(key: key);

  @override
  _AppBottomNavigationBarState createState() =>
      _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState
    extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    UserHomePage(userType: "User"),
    BookedPlaces(userType: "User"),
    UserProfile(userType: "User"),
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
                  icon: Image.asset('assets/icons/unhome.png', height: 25, width: 25, fit: BoxFit.scaleDown,),
                  activeIcon: Image.asset('assets/icons/home.png', height: 25, width: 25, fit: BoxFit.scaleDown,),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/unbooking.png',height: 25, width: 30, fit: BoxFit.scaleDown,),
                  activeIcon: Image.asset('assets/icons/booking.png',height: 25, width: 30, fit: BoxFit.scaleDown,),
                  label: 'Booked Places',
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
