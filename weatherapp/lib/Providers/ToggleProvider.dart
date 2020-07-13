import 'package:flutter/cupertino.dart';

class ToggleProvider extends ChangeNotifier {

  bool _isSwitched1 = false;
  bool _isSwitched2 = false;

  void swap1() {
    _isSwitched1 = !_isSwitched1;
    notifyListeners();
  }
  void swap2() {
    _isSwitched2 = !_isSwitched2;
    notifyListeners();
  }

  //Getters
  bool get isSwitched1 => _isSwitched1;
  bool get isSwitched2 => _isSwitched2;
}