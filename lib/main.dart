import 'package:flutter/material.dart';
import 'package:flutter_weather_app/consts.dart';
import 'package:weather/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    final WeatherFactory _wf =WeatherFactory(OPENWETHER_API_KEY);

    Weather? _weather;
    
    @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("collombo").then(
      (w){
          setState(() {
            _weather = w;
          });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}