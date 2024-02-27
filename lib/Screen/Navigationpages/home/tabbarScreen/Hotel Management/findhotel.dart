// ignore_for_file: camel_case_types, unused_local_variable

import 'package:demo/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("data"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: themeState.getDarkTheme
                        ? const Color(0xff212121)
                        : const Color(0xffffffff),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              AspectRatio(
                                  aspectRatio: 2,
                                  child: Image.network(
                                    "https://th.bing.com/th/id/OIP.t9W7LcjXZiA85wwPCCHPnwHaE8?rs=1&pid=ImgDetMain",
                                    fit: BoxFit.cover,
                                  )),
                              Container(
                                color:
                                    Colors.white, //HotelTheme.buildLightTheme()

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              "Queen Hotel",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Wembley, Londan",
                                                  style: TextStyle(
                                                      color: Colors.grey
                                                          .withOpacity(0.8),
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(width: 4),
                                                const Icon(
                                                  Icons.location_on,
                                                  size: 16,
                                                  color: Colors.blue,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  ' 4.0 km to city....',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ))
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  RatingBar(
                                                    ratingWidget: RatingWidget(
                                                      full: const Icon(
                                                        Icons.star_rate_rounded,
                                                        color:
                                                            Color(0xff7FBA67),
                                                      ),
                                                      half: const Icon(
                                                        Icons.star_half_rounded,
                                                        color:
                                                            Color(0xff7FBA67),
                                                      ),
                                                      empty: const Icon(
                                                        Icons
                                                            .star_border_rounded,
                                                        color:
                                                            Color(0xff7FBA67),
                                                      ),
                                                    ),
                                                    onRatingUpdate: (value) {},
                                                    itemPadding:
                                                        EdgeInsets.zero,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 24,
                                                  ),
                                                  Text(
                                                    'Reviews',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, top: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "\$180",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '/per night',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                                    .withOpacity(0.8)),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Positioned(
                              top: 8,
                              right: 8,
                              child: Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Color(0xff7FBA67),
                                  ),
                                ),
                              ))
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
