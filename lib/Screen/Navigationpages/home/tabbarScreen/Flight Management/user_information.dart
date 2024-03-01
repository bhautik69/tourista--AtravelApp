import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/flight_confermation.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/user_contact.dart';
import 'package:demo/Screen/Navigationpages/home/tabbarScreen/Flight%20Management/user_detail.dart';
import 'package:demo/provider/flight_traveller_datastore_.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../provider/dark_theme_provider.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  int total = 0;
  int children = 0;
  int adult = 0;
  List<String> ages = [];
  bool v1 = false;
  bool v2 = false;
  bool v3 = false;
  bool v4 = false;
  @override
  void initState() {
    getravellerno();
    _initializeControllers();
    _initializeControllers1();
    _initializeControllers2();
    _initializeControllers3();
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

  Map<int, String> dob = {};
  void _initializeControllers1() {
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
          title: const Text("Who's flying?"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2, color: Colors.white))),
      body: ChangeNotifierProvider<TravellerDataProvider>(
        create: (context) => TravellerDataProvider(),
        child: Consumer<TravellerDataProvider>(
            builder: (context, provider, child) {
          return Column(
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
                                  builder: (context) => User_detail(
                                    store: (gender, Dob) {
                                      gender1[index] = gender;
                                      dob[index] = Dob;
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 2, top: 3),
                                                  child: Text(
                                                    index < adult
                                                        ? "Adult" +
                                                            (gender1[index] !=
                                                                    null
                                                                ? " . ${gender1[index]}"
                                                                : " ")
                                                        : "Child aged ${ages[index - adult]}" +
                                                            (gender1[index] !=
                                                                    null
                                                                ? " . ${gender1[index]}"
                                                                : " ") +
                                                            (dob[index] != null
                                                                ? " . ${dob[index]}"
                                                                : " "),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible:
                                                      visible1[index + 1] ??
                                                          false,
                                                  child: Text(
                                                    visible2[index + 1] == true
                                                        ? "✓ successfully added"
                                                        : "Add details for this traveller ⓘ",
                                                    style: TextStyle(
                                                        color: visible2[index +
                                                                    1] ==
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
                                builder: (context) => Usercontact(
                                  contectDetails: (email, phone) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
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
                            const Titletext(title: "₹ 15,135"),
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const FlightConfirm(),
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
          );
        }),
      ),
    );
  }

  void getravellerno() async {
    var prefs = await SharedPreferences.getInstance();
    var gett = prefs.getInt("total");
    var getc = prefs.getInt("children");
    var geta = prefs.getInt("adult");
    var agelist = prefs.getStringList("agelist");
    ages = agelist ?? [];
    total = gett ?? 1;
    children = getc ?? 0;
    adult = geta ?? 0;
    setState(() {});
  }
}
