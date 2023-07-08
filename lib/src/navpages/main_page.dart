import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/navpages/global_page.dart';
import 'package:flutter_application_1/src/navpages/home_page.dart';
import 'package:flutter_application_1/src/navpages/profile_page.dart';
import 'package:flutter_application_1/src/navpages/search_page.dart';

class MainPage extends StatefulWidget {
  static String id = '3';
  const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const Home(),
    const SearchPage(),
    const GlobalPage(),
    ProfilePage(),
  ];
  //current page index, home = 0, scrapbook = 1, global = 2, profile = 3
  int currentIndex = 0;

  //Switch the index to a different page when an icon is pressed
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      appBar: AppBar(
        title: const Text("Scrapbook"),
      ),
      //Navigation bar of the main page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Scrapbook",
            icon: Icon(Icons.book_sharp),
          ),
          BottomNavigationBarItem(
            label: "Global",
            icon: Icon(Icons.public),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
