import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player1/screens/Parent/add_child.dart';
import 'package:video_player1/screens/Parent/profile.dart';
import 'package:video_player1/screens/setting.dart';

import '../../constants/color.dart';
import 'My_cilds.dart';

class Nav_Bar extends StatefulWidget {
  const Nav_Bar({Key? key}) : super(key: key);

  @override
  _Nav_BarState createState() => _Nav_BarState();
}

class _Nav_BarState extends State<Nav_Bar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Add_child(),
    const My_Childs(),
    const Parent_Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Ionicons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.add),
              label: "Add children",
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.settings),
              label: "Settings",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
