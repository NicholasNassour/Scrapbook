import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    Key? key,
    required this.currentLocation,
    required this.polylineCoordinates,
  }) : super(key: key);

  final LatLng? currentLocation;
  final List<LatLng> polylineCoordinates;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width * 0.98;
    final height = screenSize.height * 0.25;

    return SizedBox(
      width: width,
      height: height,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
          zoom: 14.5,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinates,
            color: Colors.lightBlue,
            width: 5,
          ),
        },
        markers: {
          const Marker(
            markerId: MarkerId("source"),
            position: LatLng(37.4221, -122.0841),
          ),
          Marker(
            markerId: const MarkerId("current"),
            position:
                LatLng(currentLocation!.latitude, currentLocation!.longitude),
          ),
          const Marker(
            markerId: MarkerId("destination"),
            position: LatLng(37.4116, -122.0713),
          ),
        },
      ),
    );
  }
}
