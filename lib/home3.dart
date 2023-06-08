import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'constants.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);
  @override
  _HomeState1 createState() => _HomeState1();
}

// If creating lat and long as outside variables can be an issue
// Use sharedprefences to keep the data stored

String lat = "0";
String long = "0";

class _HomeState1 extends State<Home1> {
  Future<void> getCurrentLocation() async {
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

  void liveLocation() async {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 20);

    GoogleMapController googleMapController = await _controller.future;

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      CameraPosition newPosition = CameraPosition(
        target: LatLng(double.parse(lat), double.parse(long)),
        zoom: 16,
      );

      // Animate the camera to the new position
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(newPosition));

      setState(() {});
    });
  }

  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.4221, -122.0841);
  static const LatLng destination = LatLng(37.4116, -122.0713);

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    liveLocation();
    getPolyPoints();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width * 0.98;
    final height = screenSize.height * .25;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              height: height,
              child: lat != "" && long != ""
                  ? GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(lat), double.parse(long)),
                          zoom: 14.5),
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId("route"),
                          points: polylineCoordinates,
                          color: Colors.lightBlue,
                          width: 5,
                        ),
                      },
                      markers: {
                        const Marker(
                          markerId: MarkerId("source"),
                          position: sourceLocation,
                        ),
                        Marker(
                          markerId: const MarkerId("current"),
                          position:
                              LatLng(double.parse(lat), double.parse(long)),
                        ),
                        const Marker(
                          markerId: MarkerId("destination"),
                          position: destination,
                        ),
                      },
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                    )
                  : const SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator()),
            ),
            SizedBox(height: 16),
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
