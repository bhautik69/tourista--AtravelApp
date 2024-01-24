// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:ui' as ui;
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Hotelmaps extends StatefulWidget {
  String? hotelname;
  String? add;
  String? imges;
  String? latitude;
  String? longitude;
  Hotelmaps(
      {super.key,
      this.add,
      this.imges,
      this.hotelname,
      this.latitude,
      this.longitude});

  @override
  State<Hotelmaps> createState() => _HotelmapsState();
}

class _HotelmapsState extends State<Hotelmaps> {
  var hotelname1;
  var img;
  var address;
  var latitude;
  var longitude;
  late CameraPosition _kGoogleplex;
  Set<Marker> markers = {};
  String maptheme = "";
  Uint8List? markerImg;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  loadData() async {
    final Uint8List markericon =
        await getBytesFromAsset("assets/img/location.png", 100);
    markers.add(Marker(
        markerId: const MarkerId("1"),
        icon: BitmapDescriptor.fromBytes(markericon),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: hotelname1)));

    setState(() {});
  }

  @override
  void initState() {
    hotelname1 = widget.hotelname;
    img = widget.imges;
    address = widget.add;
    latitude = double.parse(widget.latitude!);
    longitude = double.parse(widget.longitude!);
    loadData();

    _kGoogleplex = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 17,
    );
    DefaultAssetBundle.of(context)
        .loadString("assets/maptheme/dark_theme.json")
        .then(
      (value) {
        maptheme = value;
      },
    );
    setState(() {});
    super.initState();
  }

  final Completer<GoogleMapController> _controler = Completer();

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(hotelname1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              IconlyLight.arrow_left_2,
              color: Colors.white,
            )),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGoogleplex,
            compassEnabled: true,
            myLocationEnabled: false,
            myLocationButtonEnabled: true,
            markers: markers,
            onMapCreated: (GoogleMapController controller) => {
              _controler.complete(controller),
              if (themeState.getDarkTheme) {controller.setMapStyle(maptheme)}
            },
          ),
          Positioned(
            bottom: mq.size.height * 0.04,
            left: mq.size.height * 0.0011,
            right: mq.size.height * 0.0011,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                  elevation: 5,
                  color: themeState.getDarkTheme
                      ? const Color(0xff212121)
                      : const Color(0xffffffff),
                  child: SizedBox(
                    height: mq.size.height / 4,
                    width: mq.size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: mq.size.width * 0.22,
                                  width: mq.size.width * 0.22,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FancyShimmerImage(
                                        imageUrl: img,
                                        boxFit: BoxFit.cover,
                                      )),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: mq.size.width * 0.48,
                                        child: Titletext(
                                          title: hotelname1,
                                          size: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: mq.size.height * 0.01,
                                      ),
                                      SizedBox(
                                        width: mq.size.width * 0.48,
                                        child: Text(
                                          address,
                                          style: TextStyle(
                                              color: themeState.getDarkTheme
                                                  ? Colors.white
                                                      .withOpacity(0.7)
                                                  : Colors.black
                                                      .withOpacity(0.7)),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: mq.size.height * 0.03,
                          ),
                          SizedBox(
                            height: 52,
                            width: double.infinity,
                            child: commenButton(
                              title: "View Details",
                              callback: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ),
          /*  Positioned(
            top: 13,
            right: 13,
            child: FloatingActionButton(
                onPressed: () {
                  getUserCurrentLocation();
                },
                elevation: 8,
                backgroundColor: themeState.getDarkTheme
                    ? const Color(0xff212121)
                    : Colors.white,
                child: Icon(
                  Icons.my_location_outlined,
                  color: themeState.getDarkTheme
                      ? Colors.red.withOpacity(0.8)
                      : Colors.red,
                )),
          )*/
        ],
      ),
    );
  }

  /*Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());

      
    });
    return await Geolocator.getCurrentPosition();
  }*/
}
