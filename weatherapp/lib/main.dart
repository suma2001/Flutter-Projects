import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/WindSpeedProvider.dart';
import 'package:weatherapp/Widgets/nav-drawer.dart';
import 'package:weatherapp/Providers/TemperatureProvider.dart';
import 'package:weatherapp/Providers/ToggleProvider.dart';
import 'package:weatherapp/Providers/WeatherProvider.dart';
import 'package:weatherapp/Api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
      MultiProvider(
      providers: [
          ChangeNotifierProvider<TemperatureProvider>(create: (BuildContext context) { return TemperatureProvider(); },),
          ChangeNotifierProvider<WindSpeedProvider>(create: (BuildContext context) { return WindSpeedProvider();},),
          ChangeNotifierProvider<ToggleProvider>(create: (BuildContext context) { return ToggleProvider(); },),
          ChangeNotifierProvider<WeatherProvider>(create: (BuildContext context) { return WeatherProvider(); },)
      ],
        child: WeatherApp(),
    ),

);

class WeatherApp extends StatefulWidget {

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

  List<String> weatherStates = ["lightrain", "clearsky", "fewclouds", "scatteredclouds", "brokenclouds", "showerrain", "rain", "thunderstorm", "snow"];


  int temperature = 0;
//  String tempSym = "C";
  String location = "Delhi";
  String weather = "clearsky";
  String abbreviation = "02d";
  double windSpeed = 0.0;
  double humidity = 0.0;
  int pressure = 0;
  String errorMessage = "";

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;


  @override
  void initState() {
    search(location);

  }

  void onTextFieldSubmitted(String input) async {
      search(input);
  }

  void prin() {
//    print(temperature);
    print(weather);
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      return _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        String _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      String pl = place.locality.split(' ')[0];
      onTextFieldSubmitted(pl);
    } catch (e) {
      print(e);
    }
  }

  String searchApiUrl = "http://api.openweathermap.org/data/2.5/weather?q=";
  String api = "&appid=8e967b4ad026677e01526bbd17156d69";

  Future search(String input) async {
    try {
      print(location);
      var searchResult = await http.get(searchApiUrl + input + api);
      var result = json.decode(searchResult.body);
      temperature = (result["main"]["temp"]-273).toInt();
      windSpeed = result["wind"]["speed"];
      print((result["main"]["temp"] - 273).toInt());

      setState(() {
//        if(tempSym == "C")
//          temperature = (result["main"]["temp"] - 273).toInt();
//        else

        location = result["name"];
        abbreviation = result["weather"][0]["icon"];
        weather = result["weather"][0]["description"].replaceAll(' ', '').toLowerCase();
        String val = result["weather"][0]["main"].replaceAll(' ', '').toLowerCase();
        if(!weatherStates.contains(weather))
          {
            if(weatherStates.contains(val))
              weather = val;
            else
              weather = "mist";
          }
        errorMessage = "";
      });

    }

    catch(e) {
      errorMessage = "Sorry... We don't have data about the city. Try another one.";
    }
  }
//  Api obj = new Api("Neyveli");


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      home: (obj.result==null) ? Center(child: CircularProgressIndicator(),) :
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
//                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
                image: AssetImage('images/$weather.png'),
                fit: BoxFit.cover
            )
        ),

        child: /*(temperature == null) ? Center(child: CircularProgressIndicator()) :*/
        Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    _getCurrentLocation();
                  },
                  child: Icon(Icons.location_city, size: 36, color: Colors.grey[900],),
                ),
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: Image.network('http://openweathermap.org/img/w/$abbreviation.png', height: 90,),
                  ),
                  Center(
                        child: Consumer<TemperatureProvider>(
                          builder: (context, provider, child){
                            return Text(
                              ((provider.tempSym == 'C') ? temperature.toString(): (temperature*(9/5) + 32).toString()) + "\u00B0" + provider.tempSym.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          },
                        )
                  ),

                  Center(
                      child: Text(
                        location,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                  ),
                ],
              ),

              Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    child: TextField(
                      onSubmitted: (String input) {
                        onTextFieldSubmitted(input);
                      },
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                      decoration: InputDecoration(
                          hintText: "Search another location . . .",
                          hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: Platform.isAndroid? 15.0 : 20.0
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



