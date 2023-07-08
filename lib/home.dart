import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class Home1 extends StatefulWidget {
  static String id = '2';
  const Home1({Key? key}) : super(key: key);
  @override
  _HomeState1 createState() => _HomeState1();
}

//Latitude and longitude values
String lat = "0";
String long = "0";

class _HomeState1 extends State<Home1> {
  //Get current location of a user
  Future<void> getCurrentLocation() async {
    //Permission variables to enable location tracking
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue accessing the position and request users of the App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try requesting permissions again.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied.');
    }

    // When we reach here, permissions are granted, and we can continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
  }

  //Get a user's current location
  void liveLocation() async {
    // Configure location settings for high accuracy and a distance filter of 20 meters
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 20,
    );

    // Wait for the Google Map controller to be available
    GoogleMapController googleMapController = await _controller.future;

    // Start listening to the position stream provided by Geolocator
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      // Retrieve latitude and longitude from the received position
      lat = position.latitude.toString();
      long = position.longitude.toString();

      // Create a new camera position based on the updated latitude and longitude
      CameraPosition newPosition = CameraPosition(
        target: LatLng(double.parse(lat), double.parse(long)),
        zoom: 8,
      );

      // Animate the camera to the new latitude and longitude of the user
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(newPosition));

      // Update the UI to reflect the new location
      setState(() {});
    });
  }

  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    liveLocation();
  }

  @override
  @override
  Widget build(BuildContext context) {
    //Calculating height and width for a given device
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width * 0.98;
    final height = screenSize.height * 0.25;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              height: height,
              child: lat != "" && long != ""
                  //Creates a Google Map Widget with the users initial camera position
                  ? GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(lat), double.parse(long)),
                          zoom: 14.5),
                      markers: {
                        Marker(
                          markerId: const MarkerId("current"),
                          position:
                              LatLng(double.parse(lat), double.parse(long)),
                        ),
                      },
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                    )
                  // If the map doesn't load replace with a loading indicator
                  : const SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator()),
            ),
            const SizedBox(height: 16),
            Text(
              'Latitude: ${double.parse(lat)}\nLongitude: ${double.parse(long)}',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
