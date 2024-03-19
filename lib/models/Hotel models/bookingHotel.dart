import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class bookingHotel {
  String? id;
  String? name;
  String? description;
  Map<String, dynamic>? facilities;
  List<dynamic>? images;
  String? personPrice;
  String? cityName;
  String? disttocenter;
  String? address;
  String? latitude;
  String? longitude;
  String? checkinfrom;
  String? checkinUntil;
  String? checkoutUntil;
  String? bookingdate;
  String? transeferFee;
  String? distFromAirport;
  String? traveltimetoairport;
  String? email;
  String? phoneno;
  String? room;
  String? adult;
  String? children;
  List<Map<String, dynamic>>? adultList;
  List<Map<String, dynamic>>? childrenList;
  String? totalPrice;
  // ignore: non_constant_identifier_names
  String? check_out;
  // ignore: non_constant_identifier_names
  String? check_in;

  bookingHotel(
      {this.id,
      required this.name,
      required this.description,
      required this.facilities,
      required this.images,
      required this.personPrice,
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
      required this.traveltimetoairport,
      required this.room,
      required this.adult,
      required this.children,
      required this.email,
      required this.bookingdate,
      required this.phoneno,
      required this.adultList,
      required this.childrenList,
      required this.totalPrice,
      // ignore: non_constant_identifier_names
      required this.check_out,
      // ignore: non_constant_identifier_names
      required this.check_in});

  static Future<void> addBookingHotels(bookingHotel bookinghotel, id) async {
    CollectionReference collectionReference =
        await FirebaseFirestore.instance.collection("HotelBooking");

    Map<String, dynamic> data = {
      "id": bookinghotel.id,
      "name": bookinghotel.name,
      "description": bookinghotel.description,
      "facilities": bookinghotel.facilities,
      "images": bookinghotel.images,
      "price": bookinghotel.personPrice,
      "cityName": bookinghotel.cityName,
      "disttocenter": bookinghotel.disttocenter,
      "address": bookinghotel.address,
      "latitude": bookinghotel.latitude,
      "longitude": bookinghotel.longitude,
      "checkinfrom": bookinghotel.checkinfrom,
      "checkinUntil": bookinghotel.checkinUntil,
      "checkoutUntil": bookinghotel.checkoutUntil,
      "transeferFee": bookinghotel.transeferFee,
      "distFromAirport": bookinghotel.distFromAirport,
      "traveltimetoairport": bookinghotel.traveltimetoairport,
      "email": bookinghotel.email,
      "phoneno": bookinghotel.phoneno,
      "adultList": bookinghotel.adultList,
      "childrenList": bookinghotel.childrenList,
      "bookingdate": bookinghotel.bookingdate,
      "totalPrice": bookinghotel.totalPrice,
      "room": bookinghotel.room,
      "adult": bookinghotel.adult,
      "children": bookinghotel.children,
      "check_out": bookinghotel.check_out,
      "check_in": bookinghotel.check_in
    };

    collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserBooking")
        .doc(id)
        .set(data);
  }

  static Future<void> deleteHotelBooking(String id) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection('HotelBooking');
    await db
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserBooking")
        .doc(id)
        .delete();
  }
}
