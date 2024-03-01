// ignore_for_file: camel_case_types, unused_local_variable

import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class show_hotel extends StatefulWidget {
  const show_hotel({super.key});

  @override
  State<show_hotel> createState() => _show_hotelState();
}

class _show_hotelState extends State<show_hotel> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: themeState.getDarkTheme
          ? const Color(0xff121212)
          : const Color.fromARGB(255, 236, 235, 235),
      appBar: AppBar(
          title: const Text("Book Trip"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2, color: Colors.white))),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: mq.size.height * 0.02),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    width: mq.size.width,
                    color: themeState.getDarkTheme
                        ? const Color(0xff212121)
                        : const Color(0xffffffff),
                    // elevation: 5,
                    //  shape: RoundedRectangleBorder(
                    //    borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(mq.size.width * 0.026),
                      child: Column(
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 1.8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "https://th.bing.com/th/id/OIP.t9W7LcjXZiA85wwPCCHPnwHaE8?rs=1&pid=ImgDetMain",
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: mq.size.width * 0.023),
                                      child: Row(
                                        children: [
                                          Titletext(
                                            title: "Queen Hotel",
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.favorite_border,
                                            color: color,
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: themeState.getDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                          size: 16,
                                        ),
                                        Text(
                                          "Baga - 0.86 km to center",
                                          style: TextStyle(
                                              color: themeState.getDarkTheme
                                                  ? Colors.white
                                                      .withOpacity(0.75)
                                                  : Colors.black
                                                      .withOpacity(0.6)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: mq.size.width * 0.023,
                                              bottom: mq.size.width * 0.03 -
                                                  mq.size.width * 0.021),
                                          child: Text(
                                            "2 Hotel rooms : 2 bed",
                                            style: TextStyle(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                        .withOpacity(0.75)
                                                    : Colors.black
                                                        .withOpacity(0.6)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              // top: mq.size.width * 0.023,
                                              bottom: mq.size.width * 0.03 -
                                                  mq.size.width * 0.023),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text("Price for 1 night, 1 adult",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                      //  fontWeight: FontWeight.w500,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                "₹2000",
                                                style: TextStyle(
                                                    color:
                                                        themeState.getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
