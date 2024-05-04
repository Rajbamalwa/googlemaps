import 'package:flutter/material.dart';
import 'package:googlemaps/GooglePlaceApi.dart';

import 'HomePage.dart';
import 'SearchAndNavigatetotheplace.dart';
import 'navigateToPlaces.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: NavigateToPlaces(),
    );
  }
}
//AIzaSyDMl9apJLo68hKK9qews_Wu-kIDkz4UW-A
