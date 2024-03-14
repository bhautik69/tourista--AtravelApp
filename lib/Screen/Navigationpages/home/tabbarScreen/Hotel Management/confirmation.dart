import 'package:demo/Screen/Navigationpages/main_page.dart';
import 'package:demo/models/Hotel%20models/bookingHotel.dart';
import 'package:demo/models/Hotel%20models/hoteladd.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Confirmation extends StatefulWidget {
  Hotel hotel;
  String id;
  String email;
  String phone;
  String totalPrice;
  List<Map<String, dynamic>> adultList;
  List<Map<String, dynamic>> childList;
  int adult;
  int child;
  int room;

  Confirmation(
      {super.key,
      required this.totalPrice,
      required this.id,
      required this.hotel,
      required this.email,
      required this.adult,
      required this.child,
      required this.room,
      required this.phone,
      required this.adultList,
      required this.childList});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  // int room = 1;
  // int adult = 1;
  // int child = 0;
  // ignore: non_constant_identifier_names
  String check_In = "";
  // ignore: non_constant_identifier_names
  String check_Out = "";
  bool isloading = false;
  int night = 0;
  int price = 0;
  @override
  void initState() {
    super.initState();
    getdata();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  late Razorpay _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("Payment Successfully")));
    save();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Mainpage(),
        ),
        (route) => false);

    print("\$\$\$\$\$\$\$\$\$\$\$\$\$success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("\$\$\$\$\$\$\$\$\$\$\$\$\ error${response.message}");
    print("\$\$\$\$\$\$\$\$\$\$\$\$\ error${response.error}");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Payment Cancel")));

    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Server Down!Please try Again After 30 minute")));

    print("\$\$\$\$\$\$\$\$\$\$\$\$\ wallet");

    // Do something when an external wallet was selected
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
                  Navigator.of(context).pop();
                },
                icon:
                    const Icon(IconlyLight.arrow_left_2, color: Colors.white))),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
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
                                            Titletext(
                                                title: widget.hotel.name!),
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
                                            "${widget.hotel.cityName} - ${widget.hotel.disttocenter} km to center",
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
                                          const Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: mq.size.width * 0.023,
                                                bottom: mq.size.width * 0.03 -
                                                    mq.size.width * 0.021),
                                            child: Text(
                                              "${widget.room} Hotel rooms : ${widget.room} bed",
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
                                                Text(
                                                    "Price for $night night, ${widget.adult + widget.child} Traveller",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                        //  fontWeight: FontWeight.w500,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "₹ ${int.parse(widget.totalPrice) * night}",
                                                  style: TextStyle(
                                                      color: themeState
                                                              .getDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
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
                                  "${widget.room} rooms . ${widget.adult} adults ${widget.child == 0 ? " " : ". ${widget.child} children"}",
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
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: themeState.getDarkTheme
                        ? const Color(0xff212121)
                        : const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(5, 5),
                          color: themeState.getDarkTheme
                              ? Colors.white12
                              : Colors.black12)
                    ]),
                height: mq.size.height * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: mq.size.width,
                        height: 3,
                        color: themeState.getDarkTheme
                            ? Colors.white12
                            : Colors.black12),
                    SizedBox(
                      height: mq.size.height * 0.016,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Mainpage(),
                                  ),
                                  (route) => false);
                            },
                            child: Container(
                              height: mq.size.height * 0.067,
                              width: mq.size.width * 0.44,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xff0078aa)),
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
                          const Spacer(),
                          SizedBox(
                            height: mq.size.height * 0.067,
                            width: mq.size.width * 0.44,
                            child: commenButton(
                              loading: isloading,
                              title: "Confirm",
                              callback: () {
                                price = int.parse(widget.totalPrice) * night;
                                var options = {
                                  'key': 'rzp_test_xvlZZBGCo0SzL0',
                                  // 'key': 'rzp_live_ILgsfZCZoFIKMb',
                                  'amount': price *
                                      100, //paisa ma hoy aetale into 100 karya chhe and paisa hamesa interger av se
                                  'name': 'Tourista',
                                  'description': 'Hotel Booking',
                                  'theme.color': "#0078AA",
                                  'prefill': {
                                    'contact': '8888888888',
                                    'email': 'test@razorpay.com'
                                  },
                                  // "note": {
                                  //   'payment_type': 'UPI',
                                  //   'phonepe': true,
                                  // }
                                };
                                _razorpay.open(options);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
    setState(() {
      check_In = v1!;
      check_Out = v2!;
    });
    night = getNight(v1!, v2!);
    setState(() {});
  }

  save() async {
    setState(() {
      isloading = true;
    });

    await bookingHotel
        .addBookingHotels(
      bookingHotel(
          name: widget.hotel.name,
          id: widget.id,
          description: widget.hotel.description,
          facilities: widget.hotel.facilities,
          images: widget.hotel.images,
          personPrice: widget.hotel.price,
          cityName: widget.hotel.cityName,
          disttocenter: widget.hotel.disttocenter,
          address: widget.hotel.address,
          latitude: widget.hotel.latitude,
          longitude: widget.hotel.longitude,
          checkinfrom: widget.hotel.checkinfrom,
          checkinUntil: widget.hotel.checkinUntil,
          checkoutUntil: widget.hotel.checkoutUntil,
          transeferFee: widget.hotel.transeferFee,
          distFromAirport: widget.hotel.distFromAirport,
          traveltimetoairport: widget.hotel.traveltimetoairport,
          email: widget.email,
          phoneno: widget.phone,
          adultList: widget.adultList,
          childrenList: widget.childList,
          totalPrice: widget.totalPrice,
          room: widget.room.toString(),
          adult: widget.adult.toString(),
          children: widget.child.toString(),
          check_out: check_Out,
          check_in: check_In),
      widget.id,
    )
        .whenComplete(() {
      setState(() {
        isloading = false;

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("BOOKING SUCCESSFULLY")));
      });
    });
  }

  int getNight(String checkIn, String checkOut) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    DateTime dateTime1 = dateFormat.parse(checkIn);
    DateTime dateTime2 = dateFormat.parse(checkOut);
    Duration duration = dateTime2.difference(dateTime1);
    return duration.inDays;
  }
}
