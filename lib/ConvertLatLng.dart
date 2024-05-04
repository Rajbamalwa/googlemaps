import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLng extends StatefulWidget {
  const ConvertLatLng({Key? key}) : super(key: key);

  @override
  State<ConvertLatLng> createState() => _ConvertLatLngState();
}

class _ConvertLatLngState extends State<ConvertLatLng> {
  String displayLatLng = '';
  String displayAddress = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Address from LATLNG'),
        elevation: 0,
        actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(displayLatLng.toString()),
            Text(displayAddress.toString()),
            ElevatedButton(
                onPressed: () async {
                  List<Location> locations =
                      await locationFromAddress("Sequestration 710, Enschede");
                  List<Placemark> placemarks =
                      await placemarkFromCoordinates(52.2165157, 6.9437819);

                  setState(() {
                    displayLatLng =
                        "${locations.last.latitude} ${locations.last.longitude}";
                    displayAddress = placemarks.reversed.last.country.toString();
                  });
                },
                child: const Text('Get Address')),
          ],
        ),
      ),
    );
  }
}
