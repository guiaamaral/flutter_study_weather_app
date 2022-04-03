import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_study_weather_app/providers/weather_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationPage> {
  Location location = Location();
  late LocationData _currentPosition;

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Clima'),
        ),
        body: const Center(child: Text('Aguarde, obtendo localização.')));
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();

    Future.delayed(
        const Duration(milliseconds: 750),
        () => {
              Navigator.pushReplacementNamed(context, "/weather", arguments: {
                "weatherData": fetchWeatherByLatLon(
                    _currentPosition.latitude, _currentPosition.longitude)
              })
            });
  }
}
