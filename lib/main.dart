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
    return SizedBox(width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
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
                        





                      ],
                    ),);
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



}