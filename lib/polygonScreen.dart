import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({Key? key}) : super(key: key);

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.084565, 77.285814),
    zoom: 14,
  );
  final Set<Marker> _markers = {};
  Set<Polygon> _polygone = HashSet<Polygon>();

  List<LatLng> points = [
    LatLng(19.084565, 77.285814),
    LatLng(19.124021, 77.270113),
    LatLng(19.145116, 77.308237),
    LatLng(19.148065, 77.278194),
    LatLng(19.193179, 77.278500),
    LatLng(19.211451, 77.290101),
    LatLng(19.191997, 77.345719),
    LatLng(19.138164, 77.361856),
    LatLng(19.103780, 77.350526),
    LatLng(19.084565, 77.285814),
  ];

  void _setPolygone() {
    _polygone.add(Polygon(
        polygonId: PolygonId('1'),
        points: points,
        strokeColor: Colors.deepOrange,
        strokeWidth: 5,
        fillColor: Colors.deepOrange.withOpacity(0.1),
        geodesic: true));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setPolygone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: Set<Marker>.of(_markers),
        // myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        polygons: _polygone,
      ),
    );
  }
}
