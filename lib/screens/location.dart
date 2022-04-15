import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_study_weather_app/providers/weather_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationPage> {
  bool showForm = false;
  Location location = Location();
  late LocationData _currentPosition;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    getLoc();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (showForm) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Clima'),
        ),
        body: Center(
          child: TextField(
            decoration: const InputDecoration(
              icon: Icon(Icons.pin_drop_rounded),
              labelText: 'Buscar uma cidade',
              hintText: 'Cidade, estado, país',
              border: OutlineInputBorder(),
            ),
            controller: _controller,
            onSubmitted: (String value) {
              String city = value.split(',')[0].trim().toLowerCase();
              String? state =
                  value.split(',').length > 1 ? value.split(',')[1].trim().toLowerCase() : null;
              String? country =
                  value.split(',').length > 2 ? value.split(',')[2].trim().toLowerCase() : null;

              Navigator.pushReplacementNamed(context, "/weather", arguments: {
                "weatherData": fetchWeatherByCity(city, state, country)
              });
            },
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Clima'),
          ),
          body: const Center(child: Text('Aguarde, obtendo localização.')));
    }
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
    if (_currentPosition.latitude != null &&
        _currentPosition.longitude != null) {
      Navigator.pushReplacementNamed(context, "/weather", arguments: {
        "weatherData": fetchWeatherByLatLon(
            _currentPosition.latitude, _currentPosition.longitude)
      });
    } else {
      setState(() {
        showForm = true;
      });
    }
  }
}
