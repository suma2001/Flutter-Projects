import 'package:flutter/cupertino.dart';

class WindSpeedProvider extends ChangeNotifier {

  String _windUnit = "km/h";
  double _windSpeed = 0;

  void changeWindUnit(int index) {
    if(index==0)
      _windUnit = "km/h";
    else if(index==1)
      _windUnit = "m/s";
    else
      _windUnit = "mph";
    notifyListeners();
  }

  double windSpeedValue(String unit, double speed) {
    if(unit=="km/h")
      _windSpeed = speed;
    else if(unit == "m/s")
      _windSpeed = speed * (5/18);
    else
      _windSpeed = speed * (0.621);
    notifyListeners();
    return _windSpeed;

  }

  //Getters
  double get windSpeed => _windSpeed;
  String get windUnit => _windUnit;
}