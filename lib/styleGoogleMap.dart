import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class styleGoogleMap extends StatefulWidget {
  const styleGoogleMap({Key? key}) : super(key: key);

  @override
  State<styleGoogleMap> createState() => _styleGoogleMapState();
}

class _styleGoogleMapState extends State<styleGoogleMap> {
  String mapStyle = '';

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6941, 72.9734),
    zoom: 15,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DefaultAssetBundle.of(context)
        .loadString('assets/mapTheme/retroTheme.json')
        .then((string) {
      mapStyle = string;
    }).catchError((error) {
      print("error" + error.toString());
    });
  }

// https://mapstyle.withgoogle.com/ used this website to get Themes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Style Map'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('assets/mapTheme/retroTheme.json')
                              .then((string) {
                            setState(() {});
                            value.setMapStyle(string);
                          });
                        }).catchError((error) {
                          print("error" + error.toString());
                        });
                      },
                      child: Text("Retro"),
                      value: 1,
                    ),
                    PopupMenuItem(
                      onTap: () async {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('assets/mapTheme/darkTheme.json')
                              .then((string) {
                            setState(() {});
                            value.setMapStyle(string);
                          });
                        }).catchError((error) {
                          print("error" + error.toString());
                        });
                      },
                      child: Text("Night"),
                      value: 2,
                    )
                  ])
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(mapStyle);
          _controller.complete(controller);
        },
      ),
    );
  }
}
