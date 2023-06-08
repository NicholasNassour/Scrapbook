import 'package:flutter/material.dart';
import "package:google_nav_bar/google_nav_bar.dart";

class ReusableWidgets extends StatefulWidget {
  const ReusableWidgets({Key? key}) : super(key: key);
  @override
  ReusableWidgetsState createState() => ReusableWidgetsState();
}

class ReusableWidgetsState extends State {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SCRAP"),
      ),
      // body: Home1(),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.black,
        activeColor: Colors.white,
        color: Colors.white,
        tabBackgroundColor: Colors.grey.withOpacity(0.25),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        gap: 8,
        onTabChange: (index) {
          print(index);
        },
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.search, text: 'Search'),
          GButton(icon: Icons.person, text: 'Profile'),
        ],
      ),
    );
  }
}
