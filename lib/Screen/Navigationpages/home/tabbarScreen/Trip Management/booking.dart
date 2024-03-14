// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Screen/Navigationpages/main_page.dart';

import 'package:demo/models/Trip%20models/bookingmodel.dart';
import 'package:demo/models/Trip%20models/packagemodel.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// ignore: must_be_immutable
class BookingDone extends StatefulWidget {
  String? id;
  Package? package;
  BookingDone({super.key, this.id, this.package});

  @override
  State<BookingDone> createState() => _BookingDoneState();
}

// bool loading = false;
final _formKey = GlobalKey<FormState>();

class _BookingDoneState extends State<BookingDone> {
  var name = TextEditingController();

  var email = TextEditingController();

  var phone = TextEditingController();
  var address = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();
  var tname = TextEditingController();
  var dob = TextEditingController();
  String gender = list.first;
  List<Map<String, dynamic>> travellerList = [];

  static const List<String> list = <String>[
    '---Select---',
    'Male',
    'Female',
  ];
  int totleprise = 0;
  var okprise;
  @override
  void initState() {
    okprise = widget.package!.price;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      name.text = snapshot['name'];
      email.text = snapshot['email'];

      phone.text = snapshot['phone'];
      address.text = snapshot['address'];
      city.text = snapshot['city'];
      state.text = snapshot['State'];
      totleprise = int.parse(widget.package!.price!);

      setState(() {});
    });

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  late Razorpay _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("Payment Successfully")));
    saveBooking();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Mainpage(),
        ),
        (route) => false);
    mesg();
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

  void mesg() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("BOOKING SUCCESSFULLY")));
  }

  // ignore: prefer_typing_uninitialized_variables
  bool validateMobile(String value) {
    String pattern = r'(?:\+91|0)?[9678]\d{9}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  int? traveleller;
  Map<String, dynamic>? paymentIntenData;
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
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
      body: name.text.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff0078aa),
              ),
            )
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: themeState.getDarkTheme
                                ? const Color(0xff212121)
                                : const Color(0xffffffff),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mq.size.width * 0.046,
                                  vertical: mq.size.width * 0.046),
                              child: Column(
                                children: [
                                  const Titletext(
                                      title: "Fill In Your Details"),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      }
                                      return null;
                                    },
                                    controller: name,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("Name"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      }
                                      return null;
                                    },
                                    controller: email,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("Email"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      } else {
                                        if (!validateMobile(value)) {
                                          return 'Invalid mobile number';
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    controller: phone,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("Mobile phone"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      }
                                      return null;
                                    },
                                    controller: address,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("Address"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      }
                                      return null;
                                    },
                                    controller: city,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("city"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* required";
                                      }
                                      return null;
                                    },
                                    controller: state,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        label: const Text("State"),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mq.size.width * 0.046,
                                      vertical: mq.size.width * 0.046),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          // width: 85,
                                          width: mq.size.width * 0.239,
                                        ),
                                        const Titletext(
                                            title: "Traveller Details"),
                                        const Spacer(),
                                        TextButton(
                                            onPressed: () {
                                              addTravellers();
                                              setState(() {
                                                traveleller =
                                                    travellerList.length;
                                                totleprise =
                                                    totleprise * traveleller!;
                                                okprise =
                                                    totleprise * traveleller!;
                                              });
                                            },
                                            child: const Text("+ Traveller"))
                                      ],
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (travellerList.isEmpty) {
                                          if (value!.isEmpty) {
                                            return "* required";
                                          }
                                          return null;
                                        }
                                        return null;
                                      },
                                      controller: tname,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                          label: const Text("Name"),
                                          labelStyle: TextStyle(
                                              color: themeState.getDarkTheme
                                                  ? Colors.white54
                                                  : Colors.black54,
                                              fontWeight: FontWeight.w500),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1.5,
                                                      color:
                                                          Color(0xff0078aa))),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white
                                                      : Colors.black))),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (travellerList.isEmpty) {
                                          if (value!.isEmpty) {
                                            return "* required";
                                          }
                                          return null;
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                      controller: dob,
                                      onTap: () async {
                                        var dateTime = await showDatePicker(
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Theme(
                                                data: ThemeData().copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                  primary: Color(0xff0078aa),
                                                  onPrimary: Colors.white,
                                                  onSurface: Colors.black,
                                                )),
                                                child: child!,
                                              );
                                            },
                                            context: context,
                                            initialDate: DateTime(2018, 1, 1),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2019));

                                        dob.text =
                                            "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                                      },
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        label: const Text("Date of birth"),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xff0078aa))),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black)),
                                        labelStyle: TextStyle(
                                            color: themeState.getDarkTheme
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    DropdownButtonFormField(
                                      validator: (value) {
                                        if (travellerList.isEmpty) {
                                          if (value!.isEmpty &&
                                              value == list.first) {
                                            return "* required";
                                          }
                                          return null;
                                        }
                                        return null;
                                      },
                                      items: list
                                          .map((e) => DropdownMenuItem<String>(
                                              value: e, child: Text(e)))
                                          .toList(),
                                      value: gender,
                                      hint: const Text("Gender"),
                                      decoration: InputDecoration(
                                          label: const Text("Gender"),
                                          labelStyle: TextStyle(
                                              color: themeState.getDarkTheme
                                                  ? Colors.white54
                                                  : Colors.black54,
                                              fontWeight: FontWeight.w500),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1.5,
                                                      color:
                                                          Color(0xff0078aa))),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: themeState.getDarkTheme
                                                      ? Colors.white
                                                      : Colors.black))),
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      "Note : Only add the details of the person above Five years.",
                                      style: TextStyle(
                                          color: themeState.getDarkTheme
                                              ? Colors.white.withOpacity(0.7)
                                              : Colors.black.withOpacity(0.7)),
                                    )
                                  ]))),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
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
                      children: [
                        Container(
                            width: mq.size.width,
                            height: 3,
                            color: themeState.getDarkTheme
                                ? Colors.white12
                                : Colors.black12),
                        SizedBox(
                          height: mq.size.height * 0.019,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Titletext(title: "₹ $totleprise "),
                                SizedBox(
                                  height: mq.size.height * 0.01,
                                ),
                                Text(
                                    travellerList.isEmpty || traveleller == 1
                                        ? "Per person"
                                        : "$traveleller Traveller",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: themeState.getDarkTheme
                                            ? Colors.white54
                                            : Colors.black54,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                                height: mq.size.height * 0.067,
                                width: mq.size.width * 0.44,
                                child: commenButton(
                                    // loading: loading,
                                    title: "Pay Now",
                                    callback: () {
                                      // await makePayment();
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          // totleprise =
                                          //     int.parse(widget.package!.price!);
                                          print("$totleprise-----------------");
                                          var options = {
                                            'key': 'rzp_test_xvlZZBGCo0SzL0',
                                            // 'key': 'rzp_live_ILgsfZCZoFIKMb',
                                            'amount': totleprise *
                                                100, //paisa ma hoy aetale into 100 karya chhe and paisa hamesa interger av se
                                            'name': 'Tourista',
                                            'description': 'Trip Booking',
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
                                        });
                                        travellerList.clear();
                                      }
                                    }))
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> saveBooking() async {
    addTravellers();
    await Booking.addBookPackage(
        Booking(
          latitude: widget.package!.latitude,
          longitude: widget.package!.longitude,
          type: "booking",
          // package: widget.package!,
          id: widget.id,
          name: name.text,
          email: email.text,
          address: address.text,
          phone: phone.text,
          city: city.text,
          state: state.text,
          totalprice: okprise.toString(),
          travellerlist: travellerList,
          retunfligthdate: widget.package!.retunfligthdate,
          retunreachfligthdate: widget.package!.retunreachfligthdate,
          retunfligthtime: widget.package!.retunfligthtime,
          retunreachfligthtime: widget.package!.retunreachfligthtime,
          ActivityList: widget.package!.ActivityList,
          startingForm: widget.package!.startingForm,
          traveligTo: widget.package!.traveligTo,
          startDate: widget.package!.startDate,
          endDate: widget.package!.endDate,
          imgUrl: widget.package!.imgUrl,
          decs: widget.package!.decs,
          price: widget.package!.price,
          img2: widget.package!.img2,
          img1: widget.package!.img1,
          reachDate: widget.package!.reachDate,
          hotelName: widget.package!.hotelName,
          hotelRate: widget.package!.hotelRate,
          img3: widget.package!.img3,
          img4: widget.package!.img4,
          flightDate: widget.package!.flightDate,
          flightTime: widget.package!.flightTime,
          hotelImg: widget.package!.hotelImg,
          hotelAdd: widget.package!.hotelAdd,
          reachTime: widget.package!.reachTime,
          hotelPhone: widget.package!.hotelPhone,
        ),
        widget.id);
  }

  addTravellers() {
    if (tname.text.isNotEmpty &&
        gender.isNotEmpty &&
        gender != list.first &&
        dob.text.isNotEmpty) {
      travellerList.add({
        "travellerName": tname.text,
        "gender": gender,
        "travellerDob": dob.text
      });

      tname.clear();
      gender = list.first;
      dob.clear();
      //ScaffoldMessenger.of(context)
      //  .showSnackBar(const SnackBar(content: Text("ADDED SUCCESSFULLY")));
    } /*else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ENTER THE TRAVELLER DETAILS")));
    }*/
  }
}
