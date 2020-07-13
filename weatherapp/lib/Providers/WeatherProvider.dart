import 'package:flutter/cupertino.dart';

class WeatherProvider extends ChangeNotifier {

  int temperature;
  String location;
  String weather;
  String abbreviation;
  double windSpeed;
  double humidity;
  int pressure;

  // Getters
  int getTemperature() {
    return temperature;
  }
  String getLocation() {
    return location;
  }
  String getWeather() {
    return weather;
  }
  String getAbbreviation() {
    return abbreviation;
  }
  double getWindSpeed() {
    return windSpeed;
  }
  double getHumidity() {
    return humidity;
  }
  int getPressure() {
    return pressure;
  }


  // Setters
  void setTemperature(int temperature) {
    this.temperature = temperature;
  }

  void setLocation(String location) {
    this.location = location;
  }

  void setWeather(String weather) {
    this.weather = weather;
  }

  void setAbbreviation(String abbreviation) {
    this.abbreviation = abbreviation;
  }

  void setWindSpeed(double windSpeed) {
    this.windSpeed = windSpeed;
  }

  void setHumidity(double humidity) {
    this.humidity = humidity;
  }

  void setPressure(int pressure) {
    this.pressure = pressure;
  }

  void setValues() {

  }
}