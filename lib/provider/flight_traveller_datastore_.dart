import 'package:flutter/material.dart';

class TravellerDataProvider with ChangeNotifier {
  int travelerNo=2;
  List<Map<String, dynamic>>? childAge;

  void updateTravelerNo(int travelerNum) {
    travelerNo = travelerNum;
    notifyListeners();
  }

  void updatechildAge(List<Map<String, dynamic>> childage) {
   childAge  = childage;
    notifyListeners();
  }
}
