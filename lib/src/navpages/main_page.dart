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
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

//hide text in navigation bar, keep icons still when changing index
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      appBar: AppBar(
        title: const Text("Scrapbook"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
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
