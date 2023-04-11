 //In home.dart
 
  // late String lat;
  // late String long;

  // String locationMessage = 'Current Location of the User';

  // void _liveLocation() {
  //   LocationSettings locationSettings = LocationSettings(
  //     accuracy: geo.LocationAccuracy.high,
  //     distanceFilter: 100,
  //   );

  //   Geolocator.getPositionStream(locationSettings: locationSettings)
  //       .listen((Position position) {
  //     lat = position.latitude.toString();
  //     long = position.longitude.toString();

  //     setState(() {
  //       locationMessage = 'Latitude: $lat, Longitude: $long';
  //     });
  //   });
  // }

  // Future<Position> _getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permission');
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }


  // Text(locationMessage, textAlign: TextAlign.center),
//             ElevatedButton(
//               onPressed: () {
//                 _getCurrentLocation().then((value) {
//                   lat = '${value.latitude}';
//                   long = '${value.longitude}';
//                   setState(() {
//                     locationMessage = 'Latitude: $lat, Longitude: $long';
//                   });
//                   _liveLocation();
//                 });
//               },
//               child: Text('Get Current Location'),
//             ),
