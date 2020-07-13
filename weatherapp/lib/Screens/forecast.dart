
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/main.dart';

class ForeCast extends StatefulWidget {
  @override
  _ForeCastState createState() => _ForeCastState();
}

class _ForeCastState extends State<ForeCast> {

  static DateTime cur = new DateTime.now();
  static DateTime date = new DateTime(cur.year, cur.month, cur.day);

  List<String> weatherStates = ["lightrain", "clearsky", "fewclouds", "scatteredclouds", "brokenclouds", "showerrain", "rain", "thunderstorm", "snow"];
   List<int> temp = [];
   List<String> abbr = [];
   List<String> weat = [];
   List<String> dat = [];


  int temperature = 0;
  String location = "";
//  String abbreviation = "03n";
  String weather = "";
  String errorMessage = "";
  double windSpeed = 0.0;
  double humidity = 0.0;
  int pressure = 0;

  String searchApiUrl = "http://api.openweathermap.org/data/2.5/forecast?q=";
  String api = "&appid=8e967b4ad026677e01526bbd17156d69";

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;

  String fun() {
    return date.toString().split(' ')[0];
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
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
      fetchResults(pl);
    } catch (e) {
      print(e);
    }
  }

  void clear()
  {
    temp.clear();
    abbr.clear();
    weat.clear();
    dat.clear();
  }

  void fetchResults(String input) async {
      print(input);

      var searchResult = await http.get(searchApiUrl + input + api);
      var result = json.decode(searchResult.body);
      var data = result["list"];
      int n = result["cnt"];

      setState(() {
        clear();
        location = input;
        print(data[0]["wind"]["speed"]);
//        print(wind);
        windSpeed = data[0]["wind"]["speed"].toDouble();
        humidity = data[0]["main"]["humidity"].toDouble();
        pressure = data[0]["main"]["pressure"].toInt();

        for (int i = 0; i < n; i++)
        {
          String d = data[i]["dt_txt"].split(' ')[0];
          if(!dat.contains(d))
            {
              int x = (data[i]["main"]["temp"] - 273).toInt();
              String y = data[i]["weather"][0]["icon"];
              String z = data[i]["weather"][0]["description"];
              temp.add(x);
              abbr.add(y);
              weat.add(z);
              dat.add(d);
            }
        }
      });

  }

  Widget getTextWidgets(int n)
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < n; i++){
      list.add(new SizedBox(width: 10,));
      list.add(new Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight, // 10% of the width, so there are ten blinds.
            colors: [Colors.blue, Colors.lightBlueAccent], // whitish to gray
//            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
//          color: Colors.blue[200],
//                        shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(25.0),
        ),
        width: 200,
        child: Center(
            child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                (dat[i]==null) ? Center(child: new CircularProgressIndicator(),) :
                Container(
                  child: Text(dat[i], style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
                SizedBox(height: 40,),
                (abbr[i]==null) ?  Center(child: new CircularProgressIndicator(),) :
                Container(child: Image.network('http://openweathermap.org/img/w/' + abbr[i] + '.png', )),
                (temp[i]==null) ? Center(child: new CircularProgressIndicator(),) :
                Container(
                  child: Text(
                    temp[i].toString() + "\u00B0" + "C",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(height: 30,),
                (weat[i]==null) ? Center(child: new CircularProgressIndicator(),) :
                Container(
                  child: Text(
                    weat[i].toString(),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            )
        ),
      ),
      );
    }
    list.add(new SizedBox(width: 10,));
    return new Row(children: list);
  }

  Widget scroller() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            getTextWidgets(temp.length),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {Navigator.of(context).pop();}
        ),
        actions: <Widget>[
          Container(
            width: 200,
            child: TextField(
              onSubmitted: (String input) {
                fetchResults(input);
              },
              style: TextStyle(color: Colors.white, fontSize: 20.0),
              decoration: InputDecoration(
                  hintText: "Search . . .",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )
              ),
            ),
          ),
          SizedBox(width: 10,)

        ],
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
//      backgroundColor: Colors.lightBlueAccent[100],
      body:
          ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/download.jfif'),
                        fit: BoxFit.cover,
                      ),
//                    borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height * 0.50,
                  ),
                  Container(
                    child: Column(
                        children: <Widget>[
                          (temp.length==0) ? Center(child: CircularProgressIndicator()) :
                          Container(
                            child: Text(
                               temp[0].toString() + "\u00B0" + "C"  ,
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                          Container(
                              child: Text(
                                location.toString(),
                                style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                          )
                        ]
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              scroller(),
//              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight, // 10% of the width, so there are ten blinds.
                      colors: [Colors.blue, Colors.lightBlueAccent], // whitish to gray
//            tileMode: TileMode.repeated, // repeats the gradient over the canvas
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(width: 15,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(width: 1.0, color: const Color(0xFFFFFFFF)),
                            ),
                            height: 60,
                            width: 145,

                            child: ListTile(
                              leading: new Icon(FontAwesomeIcons.wind, size: 18, color: Colors.white,),
                              title: Text(windSpeed.toString() + " km/h", style: TextStyle(fontSize: 12, color: Colors.white),),
                            ),
                          ),
                          SizedBox(width: 10,),
                          (temp.length==0) ? Center(child: new CircularProgressIndicator(),) :
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(width: 1.0, color: const Color(0xFFFFFFFF)),
//                              color: Colors.lightBlueAccent,
                            ),
                            height: 60,
                            width: 145,
                              child: ListTile(
                               leading: new Icon(FontAwesomeIcons.thermometerHalf, size: 20, color: Colors.white),
                               title: Text(temp[0].toString() + "\u00B0" + "C", style: TextStyle(fontSize: 12, color: Colors.white),),
                            ),
                          ),
                          SizedBox(width: 15,),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 15,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(width: 1.0, color: const Color(0xFFFFFFFF)),
                            ),
                            height: 60,
                            width: 145,
                            child: ListTile(
                              leading: new Icon(FontAwesomeIcons.sun, size: 18, color: Colors.white,),
                              title: Text(humidity.toString(), style: TextStyle(fontSize: 12, color: Colors.white),),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(width: 1.0, color: const Color(0xFFFFFFFF)),
                              ),
                            height: 60,
                            width: 145,
                            child: ListTile(
                              leading: new Icon(FontAwesomeIcons.sun, size: 18, color: Colors.white,),
                              title: Text(pressure.toString() + " hPa", style: TextStyle(fontSize: 12, color: Colors.white),),
                            )
                          ),
                          SizedBox(width: 15,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5,),
            ],

          ),

    );
  }
}
