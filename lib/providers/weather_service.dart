import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_study_weather_app/models/weather.dart';

const String apiKey = String.fromEnvironment('OPENWEATHERMAP_API_KEY');

Future<WeatherData> fetchWeatherByCity(
    String city, String? state, String? country) async {
  String location = city;
  if (state != null) location += ',$state';
  if (country != null) location += ',$country';
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lang=pt_br&units=metric&q=$location&appid=$apiKey'));

  if (response.statusCode == 200) {
    return WeatherData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Falha ao obter os dados');
  }
}

Future<WeatherData> fetchWeatherByLatLon(double? lat, double? lon) async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lang=pt_br&units=metric&lat=$lat&lon=$lon&appid=$apiKey'));

  if (response.statusCode == 200) {
    return WeatherData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Ocorreu algum erro.');
  }
}
