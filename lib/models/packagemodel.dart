import 'package:cloud_firestore/cloud_firestore.dart';

class Package {
  // ignore: non_constant_identifier_names
  List<dynamic>? ActivityList;
  String? id;
  String? startingForm;
  String? traveligTo;

  String? startDate;
  String? endDate;
  String? imgUrl;
  String? decs;
  String? price;
  String? img1;
  String? img2;
  String? img3;
  String? img4;
  String? retunfligthdate;
  String? retunreachfligthdate;
  String? retunfligthtime;
  String? retunreachfligthtime;
  String? flightDate;
  String? reachDate;
  String? flightTime;
  String? reachTime;
  String? hotelName;
  String? hotelImg;
  String? hotelRate;
  String? hotelAdd;
  String? hotelPhone;

  bool? isFavorite;
  Package(
      {this.id,
      required this.retunfligthdate,
      required this.retunreachfligthdate,
      required this.retunfligthtime,
      required this.retunreachfligthtime,
      // ignore: non_constant_identifier_names
      required this.ActivityList,
      required this.startingForm,
      required this.traveligTo,
      required this.startDate,
      required this.endDate,
      required this.imgUrl,
      required this.decs,
      required this.price,
      required this.img1,
      required this.img2,
      required this.img3,
      required this.img4,
      required this.flightDate,
      required this.reachDate,
      required this.flightTime,
      required this.reachTime,
      required this.hotelName,
      required this.hotelImg,
      required this.hotelAdd,
      required this.hotelPhone,
      required this.hotelRate,
      this.isFavorite = false});

  static Future<void> addPackage(Package package) async {
    CollectionReference db = FirebaseFirestore.instance.collection('package');
    Map<String, dynamic> data = {
      "id": package.id,
      'startingForm': package.startingForm,
      'retunFligthDate': package.retunfligthdate,
      'retunReachFligthDate': package.retunreachfligthdate,
      'retunFligthTime': package.retunfligthtime,
      'retunReachFligthTime': package.retunreachfligthtime,
      "traveligTo": package.traveligTo,
      "startDate": package.startDate,
      "endDate": package.endDate,
      "imgUrl": package.imgUrl,
      "decs": package.decs,
      "price": package.price,
      "img1": package.img1,
      "img2": package.img2,
      "img3": package.img3,
      "img4": package.img4,
      "flightDate": package.flightDate,
      "reachDate": package.reachDate,
      "flightTime": package.flightTime,
      "reachTime": package.reachTime,
      "hotelName": package.hotelName,
      "hotelImg": package.hotelImg,
      "hotelAdd": package.hotelAdd,
      "hotelPhone": package.hotelPhone,
      "hotelRate": package.hotelRate,
      "activityList": package.ActivityList,
      "isFavorite": package.isFavorite
    };
    await db.add(data);
  }

  static Future<void> updatePackage(String id, Package updatePackage) async {
    CollectionReference db = FirebaseFirestore.instance.collection('package');
    Map<String, dynamic> data = {
      "id": updatePackage.id,
      'startingForm': updatePackage.startingForm,
      "traveligTo": updatePackage.traveligTo,
      "startDate": updatePackage.startDate,
      "endDate": updatePackage.endDate,
      "imgUrl": updatePackage.imgUrl,
      "decs": updatePackage.decs,
      "price": updatePackage.price,
      "img1": updatePackage.img1,
      "img2": updatePackage.img2,
      "img3": updatePackage.img3,
      "img4": updatePackage.img4,
      "flightDate": updatePackage.flightDate,
      "reachDate": updatePackage.reachDate,
      "flightTime": updatePackage.flightTime,
      "reachTime": updatePackage.reachTime,
      "hotelName": updatePackage.hotelName,
      "hotelImg": updatePackage.hotelImg,
      "hotelAdd": updatePackage.hotelAdd,
      "hotelPhone": updatePackage.hotelPhone,
      "hotelRate": updatePackage.hotelRate,
      "activityList": updatePackage.ActivityList,
      "isFavorite": updatePackage.isFavorite,
      'retunFligthDate': updatePackage.retunfligthdate,
      'retunReachFligthDate': updatePackage.retunreachfligthdate,
      'retunFligthTime': updatePackage.retunfligthtime,
      'retunReachFligthTime': updatePackage.retunreachfligthtime,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deletePackage(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection('package');
    await db.doc(id).delete();
  }
}
