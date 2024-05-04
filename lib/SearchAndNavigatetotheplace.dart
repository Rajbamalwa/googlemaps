import 'dart:async';
import 'dart:convert';
import 'package:googlemaps/ConvertLatLng.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import 'GooglePlaceApi.dart';

class SearchAndNavigateTo extends StatefulWidget {
  double lat;
  double lng;
  SearchAndNavigateTo({required this.lat, required this.lng});

  @override
  State<SearchAndNavigateTo> createState() => _SearchAndNavigateToState();
}

class _SearchAndNavigateToState extends State<SearchAndNavigateTo> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.141578, 77.314417),
    zoom: 14.4746,
  );
  double lat = 0.0;
  double lng = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lat = widget.lat.toDouble();
    lng = widget.lng.toDouble();
    _marker.add(Marker(
        markerId: MarkerId('4'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: 'Xyz')));
    _marker.addAll(_list);
  }

  late GoogleMapController _controller;
  final List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(52.2165157, 6.9437819),
        infoWindow: InfoWindow(title: "xyz")),
    const Marker(
        markerId: MarkerId('2'),
        position: LatLng(19.14557180869049, 77.32513769771387),
        infoWindow: InfoWindow(title: "My Shop")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const GooglePlaceApi()));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: Set<Marker>.of(_marker),
        // myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        myLocationButtonEnabled: false,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,

        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Material(
                color: Colors.orange.shade100, // button color
                child: InkWell(
                  splashColor: Colors.orange, // inkwell color
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.my_location),
                  ),
                  onTap: () {
                    // TODO: Add the operation to be performed
                    // Zoom In action
                    _controller.animateCamera(
                      CameraUpdate.zoomIn(),
                    );

// Zoom Out action
                    _controller.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                    // on button tap
                  },
                ),
              ),
            ),
            ClipOval(
              child: Material(
                color: Colors.orange.shade100, // button color
                child: InkWell(
                  splashColor: Colors.orange, // inkwell color
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.my_location),
                  ),
                  onTap: () {
                    // TODO: Add the operation to be performed
                    // Zoom In action
                    _controller.animateCamera(
                      CameraUpdate.zoomIn(),
                    );

// Zoom Out action
                    _controller.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                    // on button tap
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
