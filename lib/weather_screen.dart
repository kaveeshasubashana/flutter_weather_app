import 'package:flutter/material.dart';
import 'package:flutter_weather_app/consts.dart';
import 'package:flutter_weather_app/welcome_screen.dart';

import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _MyAppState();
}

class _MyAppState extends State<WeatherScreen> {
  final WeatherFactory _wf = WeatherFactory(OpenWhetherApiKey);
  Weather? _weather;
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeather("Colombo"); // default city
  }

  // Fetch weather for a given city
  void _fetchWeather(String city) async {
    setState(() {
      _weather = null; // show loading spinner
    });

    try {
      Weather w = await _wf.currentWeatherByCityName(city);
      setState(() {
        _weather = w;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("City not found!")),
      );
    }
  }

  void _onSearch() {
    String city = _cityController.text.trim();
    if (city.isNotEmpty) {
      _fetchWeather(city);
      _cityController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 5, 9, 88),
          
          body: _weather == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        _cityInput(),
                        const SizedBox(height: 20),
                        _locationHeader(),
                        const SizedBox(height: 20),
                        _dateTimeInfo(),
                        const SizedBox(height: 20),
                        _weatherIcon(),
                        const SizedBox(height: 20),
                        _currentTemp(),
                        const SizedBox(height: 20),
                        _extraInfo(),
        
                        //back button
                         ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                                      );
                                    },
                                  child: const Text("Back to Welcome"),
                         ),
        
                       
                      ],
        
        
                      
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // City input field + search button
  Widget _cityInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _cityController,
            decoration: InputDecoration(
              hintText: "Enter city name",
               hintStyle: TextStyle(color: const Color.fromARGB(255, 255, 249, 249), fontSize: 16),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _onSearch(),
            style: TextStyle(
                    color: Colors.white, // color of the input text
                    fontSize: 16,        // font size of the input text
                    ),
            
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _onSearch,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: const Color.fromARGB(255, 13, 215, 255)
          
          ),
          child: const Text("Search"),
        ),
      ],
    );
  }

  // Location header
  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 40),
    );
  }

  // Date & Time info
  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(fontSize: 35,color: Colors.white),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700,color: Colors.white),
            ),
            Text(
              " ${DateFormat("d.M.y").format(now)}",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700,color: Colors.white),
            ),
          ],
        )
      ],
    );
  }

  // Weather icon & description
  Widget _weatherIcon() {
    return Column(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(color: Color.fromARGB(255, 240, 238, 238), fontSize: 20),
        ),
      ],
    );
  }

  // Current temperature
  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
          fontSize: 90, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 255, 253, 253)),
    );
  }

  // Extra info (Max/Min temp, Wind, Humidity)
  Widget _extraInfo() {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.80,
      height: MediaQuery.sizeOf(context).height * 0.15,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 4, 200, 239),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)} %",
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}