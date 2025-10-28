import 'package:flutter/material.dart';
import 'package:flutter_weather_app/consts.dart';
import 'package:intl/intl.dart';
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

    final WeatherFactory _wf =WeatherFactory(OpenWhetherApiKey);

    Weather? _weather;

    @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("colombo").then(
      (w){
          setState(() {
            _weather = w;
          });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _buildUI(),
      ),
    );
  }


  Widget _buildUI(){

    if(_weather == null ){
      return const Center(
       child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: SizedBox(
                      
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        
                        children: [
      
                          //location
                          _locationHeader(),
      
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                          ),
      
                            //date and time 
                            _dateTimeInfor(),
      
                           SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.05,
                          ),
      
      
                          //whethericon
                          _wetherIcon(),
      
                          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
      
      
                          //current temp
                          _currentTemp(),
      
                          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
      
                          //more information
                          _extrainfo(),
      
      
      
      
      
      
                        ],
                      ),),
    );
  }


  //header
  Widget _locationHeader(){
    return Text(_weather?.areaName ?? "",style: TextStyle(color:Colors.black,fontSize: 40),);
  }
  

  //date and time info
  Widget _dateTimeInfor(){
       DateTime now = _weather!.date!;

       return Column(

          children: [
            Text(DateFormat("h:mm a").format(now), style: TextStyle(fontSize: 35),),
            const SizedBox(),


            Row(

              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                  Text(DateFormat("EEEE").format(now), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                  Text(" ${DateFormat("d.m.y").format(now) }",  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
              ],
            )
          ],
       );

  }


  //wetaher icon
  Widget _wetherIcon(){
    return Column(

        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.20,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage("http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png")),
              ),
            ),

            Text(_weather?.weatherDescription ?? "",style: TextStyle( color: Colors.black,fontSize: 20),),
        ],
    );
  }


  //current temp
  Widget _currentTemp(){
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C", style: TextStyle(fontSize: 90, fontWeight: FontWeight.w500,color: Colors.black),);
  }


  //more information
   Widget _extrainfo(){

        return Container(

            width: MediaQuery.sizeOf(context).width * 0.80,
            height: MediaQuery.sizeOf(context).height * 0.15,

            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(20)
            ),

            padding: const EdgeInsets.all(8.0),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //row1
                Row(

                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Text("Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C", style: const TextStyle( color: Colors.white,fontSize: 15,),),
                        Text("Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C", style: const TextStyle( color: Colors.white,fontSize: 15,),),
                    ],
                ),

                //row2
                Row(

                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Text("Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s", style: const TextStyle( color: Colors.white,fontSize: 15,),),
                        Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)} %", style: const TextStyle( color: Colors.white,fontSize: 15,),),
                    ],
                ),


              ],
            ),
        );
  }

}