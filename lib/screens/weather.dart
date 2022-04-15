import 'package:flutter/material.dart';
import 'package:flutter_study_weather_app/models/weather.dart';
import 'package:flutter_study_weather_app/util/color.dart';
import 'package:flutter_study_weather_app/widgets/error.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  late Future<WeatherData> futureWeather;

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    futureWeather = args['weatherData'];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Clima'),
        ),
        body: Center(
            child: FutureBuilder<WeatherData>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: Text(snapshot.data!.city!,
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                            child: Row(children: <Widget>[
                          Expanded(
                              child: Image.network(
                                  'http://openweathermap.org/img/wn/${snapshot.data!.icon}@2x.png')),
                          Expanded(
                            child: Text(
                              '${snapshot.data!.temperature}°C',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                            ),
                          ),
                        ])),
                        Expanded(
                          child: Text(
                              '${snapshot.data!.description![0].toUpperCase()}${snapshot.data!.description!.substring(1)}\nSensação térmica de ${snapshot.data!.feelsLike}°C',
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                            child: Row(children: <Widget>[
                          Expanded(
                            child: Text(
                                'Mínima:\n${snapshot.data!.minTemperature}°C',
                                textAlign: TextAlign.left),
                          ),
                          Expanded(
                            child: Text(
                                'Máxima:\n${snapshot.data!.maxTemperature}°C',
                                textAlign: TextAlign.right),
                          )
                        ]))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Error();
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: primaryBlack,
                  ));
                })));
  }
}
