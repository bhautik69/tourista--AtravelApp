// ignore_for_file: prefer_const_constructors

import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

/*Widget detailpage(
    {required BuildContext context,
    required bool showFligth,
    required bool showTransefer,
    required bool showHotel,
    required bool showActivity}) {
  final themeState = Provider.of<DarkThemeProvider>(context);
  var mq = MediaQuery.of(context);
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 2,
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: themeState.getDarkTheme
                ? const Color(0xff212121)
                : const Color(0xffffffff),
            elevation: 2.5,
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
          ),
          SizedBox(
            height: mq.size.height * 0.01,
          ),
          Card(
            elevation: 2.5,
            child: Container(
              color: themeState.getDarkTheme
                  ? const Color(0xff212121)
                  : const Color(0xffffffff),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(visible: showFligth, child: fligth(context)),
                    Visibility(visible: showHotel, child: hotel(context)),
                    Visibility(visible: showActivity, child: activity(context))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: mq.size.height * 0.015,
          ),
        ],
      );
    },
  );
}
*/
Widget activity(
    {required BuildContext context,
    required String to,
    required List allactivity}) {
  final themeState = Provider.of<DarkThemeProvider>(context);
  var mq = MediaQuery.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.hiking_sharp,
          ),
          Titletext(
            title: "  Activities in $to",
            size: 18,
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mq.size.width * 0.3,
                  width: mq.size.width * 0.3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                        imageUrl: allactivity[index]['activityImg'],
                        boxFit: BoxFit.cover,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Titletext(
                        title: allactivity[index]['activityname'],
                        size: 18,
                      ),
                      SizedBox(
                        height: mq.size.height * 0.01,
                      ),
                      SizedBox(
                        width: mq.size.width * 0.48,
                        child: Text(
                          allactivity[index]['activityDesc'],
                          style: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.black.withOpacity(0.7)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: mq.size.height * 0.01,
                      ),
                    ],
                  ),
                )
              ],
            );
          },
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Divider(
                    color: themeState.getDarkTheme
                        ? Colors.white38
                        : Colors.black38),
              ),
          itemCount: allactivity.length),
    ],
  );
}

Widget fligth(
    {required BuildContext context,
    required String title,
    required String flgthtime,
    required String reachtime,
    required String fligthdate,
    required String rechdate,
    required String to,
    required String from}) {
  final themeState = Provider.of<DarkThemeProvider>(context);
  var mq = MediaQuery.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Titletext(
        title: title,
        size: 18,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.size.height * 0.01,
              ),
              Titletext(
                title: flgthtime,
                size: 16,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    fligthdate,
                    style: TextStyle(
                        color: themeState.getDarkTheme
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black.withOpacity(0.7)),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  from,
                  style: TextStyle(
                      color: themeState.getDarkTheme
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7)),
                ),
              )
            ],
          ),
          RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.flight,
                color: themeState.getDarkTheme ? Colors.white : Colors.black,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.size.height * 0.01,
              ),
              Titletext(
                title: reachtime,
                size: 16,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    rechdate,
                    style: TextStyle(
                        color: themeState.getDarkTheme
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black.withOpacity(0.7)),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  to,
                  style: TextStyle(
                      color: themeState.getDarkTheme
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7)),
                ),
              )
            ],
          ),
        ],
      ),
      /* Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Divider(
          color: themeState.getDarkTheme ? Colors.white38 : Colors.black38,
        ),
      ),*/
    ],
  );
}

Widget hotel(
    {required BuildContext context,
    required String to,
    required String hotelname,
    required VoidCallback showMap,
    required VoidCallback viewDetails,
    required String img,
    required String phone,
    required String address,
    required String rating}) {
  final themeState = Provider.of<DarkThemeProvider>(context);
  var mq = MediaQuery.of(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.business_outlined,
          ),
          Titletext(
            title: "  Check-in to hotel in $to",
            size: 18,
          ),
        ],
      ),
      SizedBox(
        height: mq.size.height * 0.017,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: mq.size.width * 0.3,
                width: mq.size.width * 0.3,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FancyShimmerImage(
                      imageUrl: img,
                      boxFit: BoxFit.cover,
                    )),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xff0078aa),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(11))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      child: Text(
                        "$rating/5",
                        style: TextStyle(
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: mq.size.width * 0.48,
                  child: Titletext(
                    title: hotelname,
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
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black.withOpacity(0.7)),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: mq.size.height * 0.01,
                ),
                Row(
                  children: [
                    Text(
                      "Phone : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      phone,
                      style: TextStyle(
                          color: themeState.getDarkTheme
                              ? Colors.white.withOpacity(0.7)
                              : Colors.black.withOpacity(0.7)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
      SizedBox(
        height: mq.size.height * 0.012,
      ),
      Row(
        children: [
          Spacer(),
          InkWell(
            onTap: () {
              showMap();
            },
            child: Text(
              "Show On Map",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ),
          //
          // GestureDetector(
          //   onTap: () => viewDetails,
          //   child: Text(
          //     "View Details",
          //     style: TextStyle(
          //       fontWeight: FontWeight.w500,
          //       fontSize: 16,
          //       color: Colors.blue,
          //     ),
          //   ),
          // ),
        ],
      )
    ],
  );
}

Widget dot(BuildContext context) {
  final themeState = Provider.of<DarkThemeProvider>(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7),
    child: Container(
      height: 5,
      width: 5,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeState.getDarkTheme ? Colors.white : Colors.black),
    ),
  );
}

Widget returnfligth({
  required BuildContext context,
  required String form,
  required String to,
  required String flgthtime,
  required String reachtime,
  required String fligthdate,
  required String rechdate,
}) {
  final themeState = Provider.of<DarkThemeProvider>(context);
  var mq = MediaQuery.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Titletext(
        title: "Departure in $form via fligth",
        size: 18,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.size.height * 0.01,
              ),
              Titletext(
                title: flgthtime,
                size: 16,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    fligthdate,
                    style: TextStyle(
                        color: themeState.getDarkTheme
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black.withOpacity(0.7)),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  form,
                  style: TextStyle(
                      color: themeState.getDarkTheme
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7)),
                ),
              )
            ],
          ),
          RotatedBox(
              quarterTurns: -1,
              child: Icon(
                Icons.flight,
                color: themeState.getDarkTheme ? Colors.white : Colors.black,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.size.height * 0.01,
              ),
              Titletext(
                title: reachtime,
                size: 16,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    rechdate,
                    style: TextStyle(
                        color: themeState.getDarkTheme
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black.withOpacity(0.7)),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  to,
                  style: TextStyle(
                      color: themeState.getDarkTheme
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7)),
                ),
              )
            ],
          ),
        ],
      ),
      /* Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Divider(
          color: themeState.getDarkTheme ? Colors.white38 : Colors.black38,
        ),
      ),*/
    ],
  );
}
