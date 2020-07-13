import 'package:flutter/cupertino.dart';

class TemperatureProvider extends ChangeNotifier {

  String _tempSym = "C";
  int _temperature = 0;

  void changeValue(int index) {
    if(index==0)
      _tempSym = "C";
    else
      _tempSym = "F";
    notifyListeners();
  }

  int changeTemperature(String tempSym, int temp) {
    if(tempSym=="C")
      _temperature = temp-273;
    else
      _temperature = temp;
    notifyListeners();
    return _temperature;

  }

  String get tempSym => _tempSym;
  int get temperature => _temperature;
}