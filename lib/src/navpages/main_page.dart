import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/navpages/global_page.dart';
import 'package:flutter_application_1/src/navpages/home_page.dart';
import 'package:flutter_application_1/src/navpages/profile_page.dart';
import 'package:flutter_application_1/src/navpages/search_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [Home(), SearchPage(), ProfilePage(), GlobalPage()];
  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

//hide text in navigation bar, keep icons still when changing index
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      appBar: AppBar(
        title: Text("SCRAP"),
      ),
      bottomNavigationBar: Container(
        child: GNav(
          onTabChange: onTap,
          backgroundColor: Colors.black,
          activeColor: Colors.white,
          color: Colors.white,
          tabBackgroundColor: Colors.grey.withOpacity(0.25),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          gap: 8,
          selectedIndex: selectedIndex,
          tabs: [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.search, text: 'Search'),
            GButton(icon: Icons.person, text: 'Profile'),
            GButton(icon: Icons.public, text: 'Global')
          ],
        ),
      ),
    );
  }
}
