import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/ConvertLatLng.dart';
import 'package:googlemaps/GooglePlaceApi.dart';
import 'package:googlemaps/polyLine.dart';
import 'package:googlemaps/polygonScreen.dart';
import 'package:googlemaps/styleGoogleMap.dart';

import 'CustomInfoWindowOnMap.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.141578, 77.314417),
    zoom: 14.4746,
  );
  final Completer<GoogleMapController> _controller = Completer();

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
  //getUserLocation() This function is used to get user Current Location
  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('Error$error');
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const styleGoogleMap()));
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),  IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PolyLineScreen()));
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PolygonScreen()));
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const CustomInfoWindowOnMap()));
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const GooglePlaceApi()));
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ConvertLatLng()));
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: GoogleMap(
                mapType: MapType.normal,
                markers: Set<Marker>.of(_marker),
                // myLocationButtonEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
              child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    getUserLocation().then((value) async {
                      print('User Current Location');
                      print("${value.latitude} ${value.longitude}");
                      // Adding Marker for current Location
                      _marker.add(Marker(
                          markerId: const MarkerId('3'),
                          position: LatLng(value.latitude, value.longitude),
                          infoWindow:
                              const InfoWindow(title: "Current Location")));
                      // After Clicking Current location this function used to navigate you to the current location marker
                      CameraPosition camera = CameraPosition(
                          target: LatLng(value.latitude, value.longitude),
                          zoom: 14);
                      GoogleMapController controller = await _controller.future;
                      controller.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(value.latitude, value.longitude),
                        zoom: 14.4746,
                      )));
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: const Card(
                          elevation: 0,
                          color: Colors.blue,
                          child: Center(child: Text('Get Location')))))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.location_searching_rounded),
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(const CameraPosition(
                  target: LatLng(19.141578, 77.314417),
                  zoom: 14.4746,
                )));
          }),
    );
  }
}
