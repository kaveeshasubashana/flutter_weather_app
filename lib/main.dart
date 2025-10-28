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
                          height: MediaQuery.sizeOf(context).height * 0.08,
                        ),


                        //whethericon
                        _wetherIcon(),
                      ],
                    ),);
  }


  Widget _locationHeader(){
    return Text(_weather?.areaName ?? "",style: TextStyle(color:Colors.black,fontSize: 40),);
  }
  
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
}