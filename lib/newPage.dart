import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:async';
// import 'constants.dart';
import 'home3.dart';

class New_Page extends StatefulWidget {
  const New_Page({Key? key}) : super(key: key);
  @override
  NewPageState createState() => NewPageState();
}

class NewPageState extends State<New_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
      ),
      body: const Home1(),
    );
  }
}
