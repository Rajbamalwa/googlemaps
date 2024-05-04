import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:googlemaps/SearchAndNavigatetotheplace.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlaceApi extends StatefulWidget {
  const GooglePlaceApi({Key? key}) : super(key: key);

  @override
  State<GooglePlaceApi> createState() => _GooglePlaceApiState();
}

class _GooglePlaceApiState extends State<GooglePlaceApi> {
  TextEditingController controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '12345';
  List<dynamic> list = [];
  String getLatLng = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      onChanged();
    });
  }

  void onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(controller.text);
  }

  void getSuggestion(String input) async {
    String placeApi = "AIzaSyDMl9apJLo68hKK9qews_Wu-kIDkz4UW-A";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$placeApi&sessiontoken=$_sessionToken';
    var responce = await http.get(Uri.parse(request));
    if (responce.statusCode == 200) {
      setState(() {
        list = jsonDecode(responce.body.toString())['predictions'];
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Address from API'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                icon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Colors.grey, style: BorderStyle.solid)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Colors.grey, style: BorderStyle.none)),
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
                label: const Text('Places'),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list[index]['description'].toString()),
                  subtitle: Text(getLatLng.toString()),
                  onTap: () async {
                    List<Location> locations = await locationFromAddress(
                        list[index]['description'].toString());
                    setState(() {
                      //    Navigator.of(context).push(MaterialPageRoute(
                      //      builder: (_) => SearchAndNavigateTo(
                      //          lat: locations.last.latitude.toDouble(),
                      //            lng: locations.last.longitude.toDouble(),
                      //          )));
                      getLatLng =
                          "${locations.last.latitude} ${locations.last.longitude}";
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
