import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class BookingFlight {
  String? id;
  String? startingFrom;
  String? travelingTo;
  String? flightNumber;
  String? startDate;
  String? endDate;
  String? takeoffTime;
  String? landingTime;
  String? price;
  String? flightname;
  List seatList;
  String? email;
  String? phoneno;
  String? classtype;
  String? adult;
  String? children;
  List<Map<String, dynamic>>? adultList;
  List<Map<String, dynamic>>? childrenList;
  String? totalPrice;

  BookingFlight(
      {this.id,
      required this.startingFrom,
      required this.classtype,
      required this.travelingTo,
      required this.flightNumber,
      required this.startDate,
      required this.endDate,
      required this.takeoffTime,
      required this.landingTime,
      required this.price,
      required this.flightname,
      required this.seatList,
      required this.adult,
      required this.children,
      required this.email,
      required this.phoneno,
      required this.adultList,
      required this.childrenList,
      required this.totalPrice});

  static Future<void> addBookingFlight(BookingFlight bookingflight, id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("FlightBooking");

    Map<String, dynamic> data = {
      "id": bookingflight.id,
      "classtype" : bookingflight.classtype,
      "startingFrom": bookingflight.startingFrom,
      "travelingTo": bookingflight.travelingTo,
      "flightNumber": bookingflight.flightNumber,
      "startDate": bookingflight.startDate,
      "endDate": bookingflight.endDate,
      "seatList": bookingflight.seatList,
      "takeoffTime": bookingflight.takeoffTime,
      "landingTime": bookingflight.landingTime,
      "price": bookingflight.price,
      "flightname": bookingflight.flightname,
      "email": bookingflight.email,
      "phoneno": bookingflight.phoneno,
      "adultList": bookingflight.adultList,
      "childrenList": bookingflight.childrenList,
      "totalPrice": bookingflight.totalPrice,
      "adult": bookingflight.adult,
      "children": bookingflight.children,
    };

    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("FlightUserBooking")
        .doc(id)
        .set(data);
  }

  static Future<void> deleteFlightBooking(String id) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection('FlightBooking');
    await db
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("FlightUserBooking")
        .doc(id)
        .delete();
  }
}
