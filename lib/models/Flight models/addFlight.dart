// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AddFlight {
  String? id;
  String? startingFrom;
  String? travelingTo;
  String? flightNumber;
  String? startDate;
  String? endDate;
  String? timeDuration;
  String? takeoffTime;
  String? landingTime;
  String? price;
  String? flightname;

  AddFlight({
    this.id,
    required this.startingFrom,
    required this.travelingTo,
    required this.flightNumber,
    required this.startDate,
    required this.endDate,
    required this.timeDuration,
    required this.takeoffTime,
    required this.landingTime,
    required this.price,
    required this.flightname,
  });

  static Future<void> addNewFlight(AddFlight addFlight) async {
    CollectionReference db = FirebaseFirestore.instance.collection("FlightDetail");

    Map<String, dynamic> data = {
      "id": addFlight.id,
      "startingFrom": addFlight.startingFrom,
      "travelingTo": addFlight.travelingTo,
      "flightNumber": addFlight.flightNumber,
      "startDate": addFlight.startDate,
      "endDate": addFlight.endDate,
      "timeDuration": addFlight.timeDuration,
      "takeoffTime": addFlight.takeoffTime,
      "landingTime": addFlight.landingTime,
      "price": addFlight.price,
      "flightname": addFlight.flightname,
    };
    await db.add(data);
  }

  static Future<void> updateFlight(String id, AddFlight updateFlight) async {
    CollectionReference db = FirebaseFirestore.instance.collection("FlightDetail");

    Map<String, dynamic> data = {
      "id": updateFlight.id,
      "startingFrom": updateFlight.startingFrom,
      "travelingTo": updateFlight.travelingTo,
      "flightNumber": updateFlight.flightNumber,
      "startDate": updateFlight.startDate,
      "endDate": updateFlight.endDate,
      "timeDuration": updateFlight.timeDuration,
      "takeoffTime": updateFlight.takeoffTime,
      "landingTime": updateFlight.landingTime,
      "price": updateFlight.price,
      "flightname": updateFlight.flightname,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteFlight(String? id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("FlightDetail");
    await db.doc(id).delete();
  }
}
