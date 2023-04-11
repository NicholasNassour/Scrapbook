// import 'package:flutter_application_1/constants.dart';
// import 'package:location/location.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// class LocationService {
//   static Future<LocationData?> getCurrentLocation() async {
//     Location location = Location();
//     return await location.getLocation();
//   }

//   static Future<List<LatLng>> getPolyPoints(
//       LatLng source, LatLng destination) async {
//     PolylinePoints polylinePoints = PolylinePoints();

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       google_api_key,
//       PointLatLng(source.latitude, source.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//     );

//     return result
//         .map((point) => LatLng(point.latitude, point.longitude))
//         .toList();
//   }
// }


// BottomNavigationBar: NavigationBar(
//   destinations: const [
//     NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
//     NavigationDestination(icon: Icon(Icons.person), label: 'Profile')
//   ],
//   onDestinationSelected: (int index){
//     setState((){
//       currentPage = index;
//     })
//   },
//   selectedIndex: currentPage,
// )