import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Hotelmaps extends StatefulWidget {
  String? hotelname;
  String? add;
  String? imges;
  Hotelmaps({super.key, this.add, this.imges, this.hotelname});

  @override
  State<Hotelmaps> createState() => _HotelmapsState();
}

class _HotelmapsState extends State<Hotelmaps> {
  static const CameraPosition _kGoogleplex = CameraPosition(
    target: LatLng(21.170240, 72.831062),
    zoom: 14,
  );
  // ignore: prefer_typing_uninitialized_variables
  var hotelname1;
  var img;
  var address;
  @override
  void initState() {
    hotelname1 = widget.hotelname;
    img = widget.imges;
    address = widget.add;
    setState(() {});
    super.initState();
  }

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
            compassEnabled: false,
            myLocationEnabled: true,
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
                  child: Container(
                    height: mq.size.height / 4,
                    width: mq.size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                Spacer(),
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
        ],
      ),
    );
  }
}
