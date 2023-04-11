import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
// import 'package:logger/logger.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.4221, -122.0841);
  static const LatLng destination = LatLng(37.4116, -122.0713);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    if (currentLocation != null) {
      currentLocation = currentLocation;
    }

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(newLoc.latitude!, newLoc.longitude!),
            ),
          ),
        );

        setState(() {});
      },
    );
  }

  // void setCustomMarkerIcon() {
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration.empty, "assets/destination.jpg")
  //       .then((icon) {
  //     destinationIcon = icon;
  //   });
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration.empty, "assets/currentLocation.png")
  //       .then((icon) {
  //     currentLocationIcon = icon;
  //   });
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration.empty, "assets/source.png")
  //       .then((icon) {
  //     sourceIcon = icon;
  //   });
  // }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBmCk9TpzYqMbgRc98Ss1o8q8PHRANo6sw",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    // setCustomMarkerIcon();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 250,
              child: currentLocation == null
                  ? const Center(child: Text("Loading"))
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                          zoom: 14.5),
                      polylines: {
                        Polyline(
                          polylineId: PolylineId("route"),
                          points: polylineCoordinates,
                          color: Colors.lightBlue,
                          width: 5,
                        ),
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId("source"),
                          // icon: sourceIcon,
                          position: sourceLocation,
                        ),
                        Marker(
                          markerId: const MarkerId("current"),
                          // icon: currentLocationIcon,
                          position: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                        ),
                        Marker(
                          markerId: MarkerId("destination"),
                          // icon: destinationIcon,
                          position: destination,
                        ),
                      },
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                    ),
            ),
            SizedBox(height: 16),
            Text(
              'Latitude: ${currentLocation?.latitude}\nLongitude: ${currentLocation?.longitude}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'dart:async';
// // import 'package:logger/logger.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final Completer<GoogleMapController> _controller = Completer();

//   static const LatLng sourceLocation = LatLng(37.4221, -122.0841);
//   static const LatLng destination = LatLng(37.4116, -122.0713);

//   List<LatLng> polylineCoordinates = [];
//   LocationData? currentLocation;

//   void getCurrentLocation() async {
//     Location location = Location();

//     location.getLocation().then(
//       (location) {
//         currentLocation = location;
//       },
//     );

//     if (currentLocation != null) {
//       currentLocation = currentLocation;
//     }

//     GoogleMapController googleMapController = await _controller.future;

//     location.onLocationChanged.listen(
//       (newLoc) {
//         currentLocation = newLoc;

//         googleMapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               zoom: 13.5,
//               target: LatLng(newLoc.latitude!, newLoc.longitude!),
//             ),
//           ),
//         );

//         setState(() {});
//       },
//     );
//   }

//   void getPolyPoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       "AIzaSyBmCk9TpzYqMbgRc98Ss1o8q8PHRANo6sw",
//       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach(
//         (PointLatLng point) => polylineCoordinates.add(
//           LatLng(point.latitude, point.longitude),
//         ),
//       );
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     getCurrentLocation();
//     getPolyPoints();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final width = screenSize.width * 0.98;
//     final height = screenSize.height * 0.25;

//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: width,
//               height: height,
//               child: currentLocation == null
//                   ? const Center(child: Text("Loading"))
//                   : GoogleMap(
//                       initialCameraPosition: CameraPosition(
//                           target: LatLng(currentLocation!.latitude!,
//                               currentLocation!.longitude!),
//                           zoom: 14.5),
//                       polylines: {
//                         Polyline(
//                           polylineId: PolylineId("route"),
//                           points: polylineCoordinates,
//                           color: Colors.lightBlue,
//                           width: 5,
//                         ),
//                       },
//                       markers: {
//                         const Marker(
//                           markerId: MarkerId("source"),
//                           position: sourceLocation,
//                         ),
//                         Marker(
//                           markerId: const MarkerId("current"),
//                           position: LatLng(currentLocation!.latitude!,
//                               currentLocation!.longitude!),
//                         ),
//                         const Marker(
//                           markerId: MarkerId("destination"),
//                           position: destination,
//                         ),
//                       },
//                       onMapCreated: (mapController) {
//                         _controller.complete(mapController);
//                       },
//                     ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Latitude: ${currentLocation?.latitude}\nLongitude: ${currentLocation?.longitude}',
//               style: TextStyle(fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }