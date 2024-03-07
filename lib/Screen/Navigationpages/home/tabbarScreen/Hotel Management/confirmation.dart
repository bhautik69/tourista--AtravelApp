import 'package:demo/models/Hotel%20models/hoteladd.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Confirmation extends StatefulWidget {
  Hotel hotel;
  Confirmation({super.key, required this.hotel});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  int room = 1;
  int adult = 1;
  int child = 0;
  String check_In = "";
  String check_Out = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color.fromARGB(255, 236, 235, 235),
        appBar: AppBar(
            title: const Text("Booking overview"),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    const Icon(IconlyLight.arrow_left_2, color: Colors.white))),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
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
                              child: FancyShimmerImage(
                                imageUrl: widget.hotel.images!.first,
                                boxFit: BoxFit.cover,
                              ))),
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
                                      Titletext(title: widget.hotel.name!),
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black,
                                      size: 16,
                                    ),
                                    Text(
                                      "${widget.hotel.cityName} - ${widget.hotel.disttocenter} km to center",
                                      style: TextStyle(
                                          color: themeState.getDarkTheme
                                              ? Colors.white.withOpacity(0.75)
                                              : Colors.black.withOpacity(0.6)),
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
                                        "${room} Hotel rooms : ${room} bed",
                                        style: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white.withOpacity(0.75)
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
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white
                                                      : Colors.black,
                                                  //  fontWeight: FontWeight.w500,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            "₹${widget.hotel.price}",
                                            style: TextStyle(
                                                color: themeState.getDarkTheme
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
              SizedBox(
                height: mq.size.height * 0.0135,
              ),
              Container(
                color: themeState.getDarkTheme
                    ? const Color(0xff212121)
                    : const Color(0xffffffff),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Titletext(
                                title: "Check-in",
                                size: 15,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(check_In)
                            ],
                          ),
                          SizedBox(
                            width: mq.size.width * 0.28,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Titletext(
                                title: "Check-out",
                                size: 15,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(check_Out)
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: mq.size.height * 0.015,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Titletext(
                            title: "Rooms and guests",
                            size: 15,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "$room rooms . $adult adults ${child == 0 ? " " : ". $child children"}",
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mq.size.height * 0.0135,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const Fligthtab(),
                      //     ),
                      //     (route) => false);
                    },
                    child: Container(
                      height: mq.size.height * 0.067,
                      width: mq.size.width * 0.44,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff0078aa)),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Color(0xff0078aa),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mq.size.height * 0.067,
                    width: mq.size.width * 0.44,
                    child: commenButton(
                      title: "Confirm",
                      callback: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => const Fli(),
                        // ));
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getdata() async {
    var store = await SharedPreferences.getInstance();
    var v1 = store.getString("checkInDate");
    var v2 = store.getString("checkOutDate");
    var v3 = store.getInt("room");
    var v4 = store.getInt("adult");
    var v5 = store.getInt("child");

    setState(() {
      check_In = v1!;
      check_Out = v2!;
      room = v3!;
      adult = v4!;
      child = v5!;
    });
  }
}
