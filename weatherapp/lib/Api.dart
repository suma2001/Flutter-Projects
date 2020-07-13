import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {

  Api(String input)
  {
    getJsonObject(input);
  }

  List<String> weatherStates = ["lightrain", "clearsky", "fewclouds", "scatteredclouds", "brokenclouds", "showerrain", "rain", "thunderstorm", "snow"];


  String searchApiUrl = "http://api.openweathermap.org/data/2.5/weather?q=";
  String api = "&appid=8e967b4ad026677e01526bbd17156d69";
  var result;

  getJsonObject(String input) async{
    var searchResult = await http.get(searchApiUrl + input + api);
    result = json.decode(searchResult.body);
  }

  int getTemperature() {
    return (result["main"]["temp"]).toInt();
  }

  String getLocation() {
    return (result["name"]);
  }

  String getWeather() {
    String wea = result["weather"][0]["description"].replaceAll(' ', '').toLowerCase();
    if(!weatherStates.contains(wea))
      wea = "mist";
    return (wea);
  }

  String getAbbreviation() {
    return (result["weather"][0]["icon"]);
  }

  double getWindSpeed() {
    return (result["wind"]["speed"]);
  }

  double getHumidity() {
    return (result["main"]["humidity"]);
  }

  int getPressure() {
    return (result["main"]["pressure"]);
  }
}