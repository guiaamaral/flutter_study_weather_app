import 'package:flutter/material.dart';
import 'package:flutter_study_weather_app/screens/location.dart';
import 'package:flutter_study_weather_app/screens/weather.dart';
import 'package:flutter_study_weather_app/util/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clima',
        theme: ThemeData(
          primarySwatch: primaryBlack,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/location',
        routes: {
          '/location': (context) => const LocationPage(),
          '/weather': (context) => const WeatherPage(),
        });
  }
}
