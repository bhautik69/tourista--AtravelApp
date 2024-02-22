import 'package:flutter/material.dart';

class TravellerDataProvider with ChangeNotifier {
  String? travelerNo;
  List<Map<String, dynamic>>? childAge;

  void updateTravelerNo(String travelerNum) {
    travelerNo = travelerNum;
    notifyListeners();
  }

  void updatechildAge(List<Map<String, dynamic>> childage) {
   childAge  = childage;
    notifyListeners();
  }
}
