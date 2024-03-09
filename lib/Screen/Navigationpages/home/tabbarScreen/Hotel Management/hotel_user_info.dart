import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/confirmation.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/hotel_user_contact.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Hotel%20Management/hotel_user_detail.dart';
import 'package:demo/models/Hotel%20models/hoteladd.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HotelUserInfo extends StatefulWidget {
  Hotel hotel;
  String id;
  HotelUserInfo({super.key, required this.hotel, required this.id});

  @override
  State<HotelUserInfo> createState() => _HotelUserInfoState();
}

class _HotelUserInfoState extends State<HotelUserInfo> {
  int total = 0;
  int children = 0;
  int adult = 0;
  List<String> ages = [];
  List<Map<String, dynamic>> childList = [];
  List<Map<String, dynamic>> adultList1 = [];

  bool v1 = false;
  bool v2 = false;
  bool v3 = false;
  bool v4 = false;
  int totalprice = 0;
  @override
  void initState() {
    getravellerno();
    _initializeControllers();
    _initializeControllers1();
    _initializeControllers2();
    _initializeControllers3();
    _initializeControllers4();
    _initializeControllers5();

    super.initState();
  }

  Map<int, String> gender1 = {};
  void _initializeControllers() {
    for (int i = 0; i < total; i++) {
      if (!gender1.containsKey(i)) {
        gender1[i];
      }
    }
  }

  Map<int, String> firstName = {};
  void _initializeControllers1() {
    for (int i = 0; i < total; i++) {
      if (!firstName.containsKey(i)) {
        firstName[i];
      }
    }
  }

  Map<int, String> lastName = {};
  void _initializeControllers4() {
    for (int i = 0; i < total; i++) {
      if (!lastName.containsKey(i)) {
        lastName[i];
      }
    }
  }

  Map<int, String> dob = {};
  void _initializeControllers5() {
    for (int i = 0; i < total; i++) {
      if (!dob.containsKey(i)) {
        dob[i];
      }
    }
  }

  Map<int, bool> visible1 = {};
  void _initializeControllers3() {
    for (int i = 0; i < total; i++) {
      if (!visible1.containsKey(i)) {
        visible1[i] = false;
      }
    }
  }

  Map<int, bool> visible2 = {};
  void _initializeControllers2() {
    for (int i = 0; i < total; i++) {
      if (!visible2.containsKey(i)) {
        visible2[i] = false;
      }
    }
  }

  String emailadd = "";
  String phonenum = "";
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor: themeState.getDarkTheme
            ? const Color(0xff121212)
            : const Color.fromARGB(255, 236, 235, 235),
        appBar: AppBar(
            // centerTitle: true,
            title: const Text("Who's staying?"),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    const Icon(IconlyLight.arrow_left_2, color: Colors.white))),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: mq.size.height * 0.02),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: total,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HotelUserDetail(
                                  store: (gender, Dob, firstname, lastname) {
                                    gender1[index] = gender;
                                    dob[index] = Dob;
                                    firstName[index] = firstname;
                                    lastName[index] = lastname;
                                    for (int i = 0; i <= total; i++) {
                                      gender1[i] == null || gender1[i] == " "
                                          ? visible1[i] = true
                                          : visible2[i + 1] = true;
                                    }

                                    setState(() {});
                                  },
                                  age: index + 1 > adult
                                      ? ages[index - adult]
                                      : "0",
                                  visible: index < adult ? false : true,
                                  traveller: index < adult
                                      ? "Adult"
                                      : "Child aged ${ages[index - adult]}",
                                  travellerNo: "Traveller ${index + 1}",
                                ),
                              ));
                            },
                            child: Container(
                              //elevation: 2.5,
                              color: themeState.getDarkTheme
                                  ? const Color(0xff212121)
                                  : const Color(0xffffffff),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mq.size.height * 0.02,
                                    vertical: mq.size.height * 0.02),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/img/user1.png",
                                      scale: 22.5,
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: mq.size.width * 0.05,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Traveller ${index + 1}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 2, top: 3),
                                                child: Text(
                                                  index < adult
                                                      ? "Adult${gender1[index] != null ? " . ${gender1[index]}" : " "}"
                                                      : "Child aged ${ages[index - adult]}${gender1[index] != null ? " . ${gender1[index]}" : " "}${dob[index] != null ? " . ${dob[index]}" : " "}",
                                                ),
                                              ),
                                              Visibility(
                                                visible: visible1[index + 1] ??
                                                    false,
                                                child: Text(
                                                  visible2[index + 1] == true
                                                      ? "✓ successfully added"
                                                      : "Add details for this traveller ⓘ",
                                                  style: TextStyle(
                                                      color:
                                                          visible2[index + 1] ==
                                                                  true
                                                              ? Colors.green
                                                              : Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: themeState.getDarkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelUserContact(
                                contact: (email, phone) {
                                  emailadd = email;
                                  phonenum = phone;
                                  emailadd == "" || emailadd.isEmpty
                                      ? v1 = false
                                      : v1 = true;
                                  phonenum == "" || phonenum.isEmpty
                                      ? v2 = false
                                      : v2 = true;
                                  emailadd == "" ||
                                          emailadd.isEmpty ||
                                          phonenum == "" ||
                                          phonenum.isEmpty
                                      ? v3 = true
                                      : v4 = true;
                                  setState(() {});
                                },
                              ),
                            ));
                      },
                      child: Container(
                        //elevation: 2.5,
                        color: themeState.getDarkTheme
                            ? const Color(0xff212121)
                            : const Color(0xffffffff),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: mq.size.height * 0.0175,
                              vertical: mq.size.height * 0.02),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 29,
                                width: 29,
                                child: Image.asset(
                                  "assets/img/contact.png",
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: mq.size.width * 0.036,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Contact details",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 02, top: 3),
                                          child: Visibility(
                                            visible: v1,
                                            child: Text(
                                              emailadd,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          child: Visibility(
                                            visible: v2,
                                            child: Text(
                                              phonenum,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: v3,
                                          child: Text(
                                            v4 == true
                                                ? "✓ successfully added"
                                                : "Add contact details ⓘ",
                                            style: TextStyle(
                                                color: v4 == true
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.01,
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
                          Titletext(title: "₹ ${widget.hotel.price}"),
                          SizedBox(
                            height: mq.size.height * 0.01,
                          ),
                          Text("Per person",
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
                              title: "Next",
                              callback: () {
                                totalprice =
                                    int.parse(widget.hotel.price!) * total;
                                v3 = true;
                                setState(() {});
                                for (int i = 0; i <= total; i++) {
                                  gender1[i] == null || gender1[i] == " "
                                      ? visible1[i] = true
                                      : visible2[i + 1] = true;
                                }
                                emailadd == "" ||
                                        emailadd.isEmpty ||
                                        phonenum == "" ||
                                        phonenum.isEmpty
                                    ? v3 = true
                                    : v4 = true;

                                for (int i = 0; i <= total; i++) {
                                  if (v4 == true &&
                                      v3 == true &&
                                      visible2[i] == true) {
                                    addAdult();
                                    addChildren();
                                    setState(() {});
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Confirmation(
                                              id: widget.id,
                                              adultList: adultList1,
                                              childList: childList,
                                              totalPrice: totalprice.toString(),
                                              email: emailadd,
                                              phone: phonenum,
                                              hotel: Hotel(
                                                  name: widget.hotel.name,
                                                  description:
                                                      widget.hotel.description,
                                                  facilities:
                                                      widget.hotel.facilities,
                                                  images: widget.hotel.images,
                                                  price: widget.hotel.price,
                                                  cityName:
                                                      widget.hotel.cityName,
                                                  disttocenter:
                                                      widget.hotel.disttocenter,
                                                  address: widget.hotel.address,
                                                  latitude:
                                                      widget.hotel.latitude,
                                                  longitude:
                                                      widget.hotel.longitude,
                                                  checkinfrom:
                                                      widget.hotel.checkinfrom,
                                                  checkinUntil:
                                                      widget.hotel.checkinUntil,
                                                  checkoutUntil: widget
                                                      .hotel.checkoutUntil,
                                                  transeferFee:
                                                      widget.hotel.transeferFee,
                                                  distFromAirport: widget
                                                      .hotel.distFromAirport,
                                                  traveltimetoairport: widget
                                                      .hotel
                                                      .traveltimetoairport)),
                                        ));
                                  }
                                }
                                setState(() {});
                              }))
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void getravellerno() async {
    var prefs = await SharedPreferences.getInstance();
    var gett = prefs.getInt("total");
    var getc = prefs.getInt("children");
    var geta = prefs.getInt("adult");
    var agelist = prefs.getStringList("AgeList");
    ages = agelist ?? [];
    total = gett ?? 1;
    children = getc ?? 0;
    adult = geta ?? 0;
    setState(() {});
  }

  addAdult() {
    for (int i = 0; i < adult; i++) {
      if (adultList1.length < adult) {
        adultList1.add({
          "firstName": firstName[i],
          "lastName": lastName[i],
          "gender": gender1[i]
        });
      }
    }
    print(adultList1);
  }

  addChildren() {
    for (int i = 0; i < total - adult; i++) {
      print(childList.length);
      if (childList.length < total - adult) {
        print(firstName[i]);
        childList.add({
          "firstName": firstName[i + adult],
          "lastName": lastName[i + adult],
          "gender": gender1[i + adult],
          "dob": dob[i + adult]
        });
      }
    }
    print(childList);
  }
}