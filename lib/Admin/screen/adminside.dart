// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Admin/screen/Admin%20Hotel%20Management/addhotel/hotelmainpage.dart';
import 'package:demo/Admin/screen/Admin%20Trip%20Management/tripMainpage.dart';
import 'package:demo/Admin/screen/Applictaion%20User/allusers.dart';
import 'package:demo/Exeptiopn/signout_fail.dart';
import 'package:demo/Screen/Auth/signin.dart';
import 'package:demo/widget/errortoast.dart';
import 'package:demo/widget/textwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Adminside extends StatefulWidget {
  const Adminside({super.key});

  @override
  State<Adminside> createState() => _AdminsideState();
}

class _AdminsideState extends State<Adminside> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 235, 235),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dashboard"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 3,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TripsManagement(),
                        ));
                  },
                  child: Card(
                    elevation: 5,
                    color: const Color(0xffffffff),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 23),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/family.png",
                                  scale: 12,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Titletext(
                                            title: "Trips Management",
                                            size: 18.5,
                                          ),
                                          SizedBox(
                                            height: mq.size.height * 0.013,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('package')
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  return Titletext(
                                                    title: snapshot
                                                        .data!.docs.length
                                                        .toString(),
                                                    size: 16,
                                                  );
                                                } else {
                                                  return const Titletext(
                                                    title: "00",
                                                    size: 16,
                                                  );
                                                }
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: mq.size.height * 0.013,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminHotelManagement(),
                        ));
                  },
                  child: Card(
                    elevation: 5,
                    color: const Color(0xffffffff),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 23),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/checkin.png",
                                  scale: 12,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Titletext(
                                            title: "Hotels Management ",
                                            size: 18.5,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('Hotel')
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  return Titletext(
                                                    title: snapshot
                                                        .data!.docs.length
                                                        .toString(),
                                                    size: 16,
                                                  );
                                                } else {
                                                  return const Titletext(
                                                    title: "00",
                                                    size: 16,
                                                  );
                                                }
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: mq.size.height * 0.013,
                ),
                Card(
                  elevation: 5,
                  color: const Color(0xffffffff),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 23),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/img/fliggt.png",
                                scale: 12,
                              ),
                              const Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Titletext(
                                          title: "Flights Management ",
                                          size: 18.5,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Titletext(
                                          title: "20",
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: mq.size.height * 0.013,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Allusers(),
                        ));
                  },
                  child: Card(
                    elevation: 5,
                    color: const Color(0xffffffff),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 23),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/user2.png",
                                  scale: 12,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Titletext(
                                            title: "Application Users",
                                            size: 18.5,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection("users")
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  return Titletext(
                                                    title: snapshot
                                                        .data!.docs.length
                                                        .toString(),
                                                    size: 16,
                                                  );
                                                } else {
                                                  return const Titletext(
                                                    title: "00",
                                                    size: 16,
                                                  );
                                                }
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: mq.size.height * 0.013,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: const Text(
                              "Are you sure you want to log out?",
                              style: TextStyle(fontSize: 18),
                            ),
                            content: const Text(
                                style: TextStyle(fontSize: 15),
                                "Logging out will temporarily hide all your personal data,including bookings.To see these again, simply log back in your account."),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("CANCEL")),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      // themeState.setDarkTheme = false;
                                    });
                                    logout();
                                  },
                                  child: const Text("PROCEED")),
                            ],
                            contentPadding: const EdgeInsets.only(
                                top: 20, left: 25, right: 25));
                      },
                    );
                  },
                  child: Card(
                    elevation: 5,
                    color: const Color(0xffffffff),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 23),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/logout.png",
                                  scale: 12,
                                ),
                                const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Titletext(
                                        title: "Logout",
                                        //size: 20,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void logout() async {
    try {
      auth.signOut().then((value) {
        Navigator.pop(context);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Signin(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      final ex = Signoutfail.code(e.code);
      Errortoast().toastmsg(ex.msg);

      throw ex;
    } catch (_) {
      const ex = Signoutfail();
      Errortoast().toastmsg(ex.msg);
      throw ex;
    }
  }
}
