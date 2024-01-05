import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class UserDetailsAdmin extends StatefulWidget {
  String profileimg;
  String name;
  String email;
  String phone;
  String dob;
  String gender;
  String add;
  String city;
  String sate;
  UserDetailsAdmin(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.dob,
      required this.gender,
      required this.add,
      required this.city,
      required this.sate,
      required this.profileimg});

  @override
  State<UserDetailsAdmin> createState() => _UserDetailsAdminState();
}

class _UserDetailsAdminState extends State<UserDetailsAdmin> {
  String img = "";
  String name = "";

  String email = "";
  String phone = "";
  String dob = "";
  String gender = "";
  String add = "";
  String city = "";
  String sate = "";
  @override
  void initState() {
    img = widget.profileimg;
    name = widget.name;
    email = widget.email;
    phone = widget.phone;
    dob = widget.dob;
    gender = widget.gender;
    add = widget.add;
    city = widget.city;
    sate = widget.sate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconlyLight.arrow_left_2)),
      ),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: mq.size.height * 0.05,
                ),
                SizedBox(
                  width: mq.size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          img.isEmpty
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 55,
                                  child: Image.asset(
                                    "assets/img/profile.png",
                                    scale: 16,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(img),
                                  radius: 56,
                                ),
                          SizedBox(
                            height: mq.size.height * 0.05,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  name.isEmpty
                                      ? const Text(
                                          "",
                                        )
                                      : Text(
                                          "NAME           :     $name",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                  SizedBox(
                                    height: mq.size.height * 0.028,
                                  ),
                                  email.isEmpty
                                      ? const Text(
                                          "",
                                        )
                                      : Text(
                                          "EMAIL           :     $email",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                  SizedBox(
                                    height: mq.size.height * 0.028,
                                  ),
                                  dob.isEmpty
                                      ? const Text(
                                          "",
                                        )
                                      : Text(
                                          "DOB               :     $dob",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                  SizedBox(
                                    height: mq.size.height * 0.028,
                                  ),
                                  gender.isEmpty
                                      ? const Text(
                                          "",
                                        )
                                      : Text(
                                          "GENDER        :     $gender",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                  SizedBox(
                                    height: mq.size.height * 0.028,
                                  ),
                                  phone.isEmpty
                                      ? const Text(
                                          "",
                                        )
                                      : Text(
                                          "PHONE          :     $phone",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                  SizedBox(
                                    height: mq.size.height * 0.028,
                                  ),
                                  add.isEmpty
                                      ? const Text(
                                          "",
                                        )
                                      : Text(
                                          "ADDRESS     :     $add",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                  SizedBox(
                                    height: mq.size.height * 0.028,
                                  ),
                                  city.isEmpty
                                      ? const Text(
                                          "",
                                        )
                                      : Text(
                                          "CITY              :     $city",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                  SizedBox(
                                    height: mq.size.height * 0.028,
                                  ),
                                  sate.isEmpty
                                      ? const Text(
                                          "",
                                        )
                                      : Text(
                                          "STATE           :     $sate",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                  SizedBox(
                                    height: mq.size.height * 0.028,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
