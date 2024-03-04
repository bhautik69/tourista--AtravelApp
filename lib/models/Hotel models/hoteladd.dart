// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  String? id;
  String? name;
  String? description;
  Map<String, dynamic>? facilities;
  List<dynamic>? images;
  String? price;
  String? cityName;
  String? disttocenter;
  String? address;
  String? latitude;
  String? longitude;
  String? checkinfrom;
  String? checkinUntil;
  String? checkoutUntil;
  String? transeferFee;
  String? distFromAirport;
  String? traveltimetoairport;

  Hotel(
      {this.id,
      required this.name,
      required this.description,
      required this.facilities,
      required this.images,
      required this.price,
      required this.cityName,
      required this.disttocenter,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.checkinfrom,
      required this.checkinUntil,
      required this.checkoutUntil,
      required this.transeferFee,
      required this.distFromAirport,
      required this.traveltimetoairport});

  static Future<void> addhoteldetail(Hotel addHotel) async {
    CollectionReference db = FirebaseFirestore.instance.collection("Hotel");
    Map<String, dynamic> data = {
      "id": addHotel.id,
      "name": addHotel.name,
      "description": addHotel.description,
      "facilities": addHotel.facilities,
      "images": addHotel.images,
      "price": addHotel.price,
      "cityName": addHotel.cityName,
      "disttocenter": addHotel.disttocenter,
      "address": addHotel.address,
      "latitude": addHotel.latitude,
      "longitude": addHotel.longitude,
      "checkinfrom": addHotel.checkinfrom,
      "checkinUntil": addHotel.checkinUntil,
      "checkoutUntil": addHotel.checkoutUntil,
      "transeferFee": addHotel.transeferFee,
      "distFromAirport": addHotel.distFromAirport,
      "traveltimetoairport": addHotel.traveltimetoairport,
    };

    await db.add(data);
  }

  static Future<void> updatehoteldetail(String id, Hotel updatehotel) async {
    CollectionReference db = FirebaseFirestore.instance.collection("Hotel");
    Map<String, dynamic> data = {
      "id": updatehotel.id,
      "name": updatehotel.name,
      "description": updatehotel.description,
      "facilities": updatehotel.facilities,
      "images": updatehotel.images,
      "price": updatehotel.price,
      "cityName": updatehotel.cityName,
      "disttocenter": updatehotel.disttocenter,
      "address": updatehotel.address,
      "latitude": updatehotel.latitude,
      "longitude": updatehotel.longitude,
      "checkinfrom": updatehotel.checkinfrom,
      "checkinUntil": updatehotel.checkinUntil,
      "checkoutUntil": updatehotel.checkoutUntil,
      "transeferFee": updatehotel.transeferFee,
      "distFromAirport": updatehotel.distFromAirport,
      "traveltimetoairport": updatehotel.traveltimetoairport,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deletehotel(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("Hotel");
    await db.doc(id).delete();
  }
}
