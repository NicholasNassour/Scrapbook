import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'authentication.dart';
import 'constants.dart';

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

  //Displays a dialog alerting the user of a new badge they collected
  void newUnlock(BuildContext context, String country) {
    String? flag = countryFlagMap[country];

    //Alert dialog pop up for when a badge is unlocked
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              const Text('New Badge Unlocked! ', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Display the badge of the country that was visited, if a badge exists
              if (flag != null)
                Image.asset(
                  flag,
                  width: 50, // Adjust the width to your preference
                  height: 50, // Adjust the height to your preference
                )
              else
                const CircularProgressIndicator(), // Loading symbol
              const SizedBox(height: 16),
              Text('You\'ve unlocked: $country'),
            ],
          ),
        );
      },
    );
  }

  //Check if a Country has been visited and add to badge list if new
  visitedCountry() async {
    String uid = AuthenticationHelper().user.uid;

    // Reference the collection 'Scrapbook' in Firebase for a given uid
    CollectionReference scrapbookCollection =
        FirebaseFirestore.instance.collection('Scrapbook');
    DocumentReference scrapbookDocRef = scrapbookCollection.doc(uid);

    // Extract the address from the given lat/long values
    List<Placemark> placemarks = await placemarkFromCoordinates(
      double.parse(lat),
      double.parse(long),
    );

    // Retrieve the current country the user is located in
    String country = placemarks.first.country ?? '';

    // Take a snapshot of the user's scrapbook from Firebase
    scrapbookDocRef.get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> badges = data['badges'] ?? [];

        // Check if a badge has been collected for the country already
        if (!badges.contains(country)) {
          // Add country to the badges list
          badges.add(country);

          // Update the badges and countries in the scrapbook document
          scrapbookDocRef.update({'badges': badges}).then((_) {
            newUnlock(context, country);
          }).catchError((error) {
            print('Failed to add badge to the scrapbook: $error');
          });
        } else {
          print('Badge already exists in the scrapbook');
        }
      } else {
        print('Scrapbook not found for user with UID: $uid');
      }
    }).catchError((error) {
      print('Failed to fetch scrapbook: $error');
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

      visitedCountry();

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
                          zoom: 8),
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
