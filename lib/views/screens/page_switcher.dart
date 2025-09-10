import 'package:flutter/material.dart';
import 'package:hr/views/screens/profile_page.dart';
import 'package:hr/views/screens/services_page.dart';

import 'home_checkIn_page.dart';


class PageSwitcher extends StatefulWidget {
  @override
  _PageSwitcherState createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeCheckInPage(),
        ServicesPage()
        ,ProfilePage()
      ][_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFEDEDED))),),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: const Color(0xFF151515),
          unselectedItemColor: const Color(0xFFBDBDBD),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          onTap: _onItemTapped,
          items:  [

            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services_outlined),
              label: 'الخدمات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'الحساب الشخصي',
            ),
          ],
        ),
      ),
    );
  }
}
