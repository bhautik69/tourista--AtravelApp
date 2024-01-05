// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/widget/progresindicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../provider/dark_theme_provider.dart';

class MngAcc extends StatefulWidget {
  const MngAcc({super.key});

  @override
  State<MngAcc> createState() => _MngAccState();
}

class _MngAccState extends State<MngAcc> {
  static const List<String> list = <String>[
    'I am a man',
    'I am a woman',
    'I am a non-binary',
    'I prefer not to say'
  ];

  final ImagePicker picker = ImagePicker();
  String? file;
  void pickImage() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      setState(() {
        file = image.path;
        selection = true;
      });
    }
  }

  var nameC = TextEditingController();
  var dateC = TextEditingController();
  String gender = "";
  var phoneC = TextEditingController();
  var addC = TextEditingController();
  var cityC = TextEditingController();
  var stateC = TextEditingController();
  bool selection = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Plese complete profile firstly"),
        ));
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          nameC.text = snapshot['name'];
          dateC.text = snapshot['dob'];
          gender = snapshot['gender'];
          phoneC.text = snapshot['phone'];
          addC.text = snapshot['address'];
          cityC.text = snapshot['city'];
          stateC.text = snapshot['State'];
          file = snapshot['profilePic'];

          setState(() {});
          parseDate();
        });
      }
    });
    super.initState();
  }

  Future<DateTime?> parseDateStringAsync(String dateString) async {
    String locale = "it_IT"; // Locale for Italy
    DateFormat formatter = DateFormat('d-M-yyyy', locale);

    try {
      DateTime parsedDate = formatter.parse(dateString);
      return parsedDate;
    } catch (e) {
      print("Error parsing date: $e");
      return null;
    }
  }

  Future<void> parseDate() async {
    DateTime? parsedDate = await parseDateStringAsync(dateC.text);
    if (parsedDate != null) {
      // You can use the parsedDate here
      
      print(parsedDate);
    } else {
      // Handle parsing error
      print("Parsing error occurred.");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: TextButton(
                onPressed: () {
                  nameC.text.isEmpty ? saveInfo() : updateInfo();
                },
                child: Text(
                  nameC.text.isEmpty ? "SAVE" : "SAVE",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconlyLight.arrow_left_2),
          color: Colors.white,
        ),
        title: const Text("Your Details"),
      ),
      body: nameC.text.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff0078aa),
              ),
            )
          : NotificationListener(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
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
                              Stack(
                                children: [
                                  file!.isEmpty
                                      ? CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 55,
                                          child: Image.asset(
                                            scale: 16,
                                            "assets/img/profile.png",
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : file!.contains('http')
                                          ? CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              radius: 55,
                                              backgroundImage:
                                                  NetworkImage(file!),
                                            )
                                          : CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              radius: 55,
                                              backgroundImage:
                                                  FileImage(File(file!)),
                                            ),
                                  Positioned(
                                    right: 3,
                                    bottom: 0,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: themeState.getDarkTheme
                                          ? const Color(0xff121212)
                                          : const Color(0xFFffffff),
                                      child: GestureDetector(
                                        onTap: () {
                                          pickImage();
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Color(0xff0078aa),
                                          radius: 17,
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mq.size.height * 0.05,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  controller: nameC,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                      label: const Text("Name"),
                                      labelStyle: TextStyle(
                                          color: themeState.getDarkTheme
                                              ? Colors.white54
                                              : Colors.black54,
                                          fontWeight: FontWeight.w500),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color(0xff0078aa))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: themeState.getDarkTheme
                                                  ? Colors.white
                                                  : Colors.black))),
                                ),
                              ),
                              SizedBox(
                                height: mq.size.height * 0.02,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  readOnly: true,
                                  controller: dateC,
                                  onTap: () async {
                                    var dateTime = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now());

                                    dateC.text =
                                        "${dateTime?.day}-${dateTime?.month}-${dateTime!.year}";
                                  },
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    label: const Text("Date of birth"),
                                    focusedBorder: const UnderlineInputBorder(
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
                              ),
                              SizedBox(
                                height: mq.size.height * 0.02,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: DropdownButtonFormField(
                                    // hint: const Text("Gender"),
                                    decoration: InputDecoration(
                                      label: const Text("Gender"),
                                      focusedBorder: const UnderlineInputBorder(
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
                                    items: list
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    value: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  )),
                              SizedBox(
                                height: mq.size.height * 0.02,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  controller: phoneC,
                                  keyboardType: TextInputType.number,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    label: const Text("Mobile phone"),
                                    focusedBorder: const UnderlineInputBorder(
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
                              ),
                              SizedBox(
                                height: mq.size.height * 0.02,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  controller: addC,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    label: const Text("Address"),
                                    focusedBorder: const UnderlineInputBorder(
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
                              ),
                              SizedBox(
                                height: mq.size.height * 0.02,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  controller: cityC,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    label: const Text("City"),
                                    focusedBorder: const UnderlineInputBorder(
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
                              ),
                              SizedBox(
                                height: mq.size.height * 0.020,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  controller: stateC,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    label: const Text("State"),
                                    focusedBorder: const UnderlineInputBorder(
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
                              ),
                              SizedBox(
                                height: mq.size.height * 0.020,
                              ),
                            ],
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

  String? downloadUrl;
  Future<String?> uploadImg(File filepath, String? reference) async {
    try {
      final finalName =
          '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}';
      final Reference fbStorage =
          FirebaseStorage.instance.ref(reference).child(finalName);
      final UploadTask uploadTask = fbStorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        downloadUrl = await fbStorage.getDownloadURL();
      });
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  saveInfo() {
    showProgressDialog(context);
    uploadImg(File(file!), 'profile').whenComplete(() {
      Map<String, dynamic> data = {
        "dob": dateC.text,
        "gender": gender,
        "phone": phoneC.text,
        "address": addC.text,
        "city": cityC.text,
        "State": stateC.text,
        "profilePic": downloadUrl
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
        Navigator.pop(context);
      });
    });
  }

  updateInfo() {
    showProgressDialog(context);
    if (selection == true) {
      uploadImg(File(file!), 'profile').whenComplete(() {
        Map<String, dynamic> data = {
          "name": nameC.text,
          "dob": dateC.text,
          "gender": gender,
          "phone": phoneC.text,
          "address": addC.text,
          "city": cityC.text,
          "State": stateC.text,
          "profilePic": downloadUrl
        };
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(data)
            .whenComplete(() {
          FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
          Navigator.pop(context);
          Navigator.pop(context);
        });
      });
    } else {
      Map<String, dynamic> data = {
        "name": nameC.text,
        "dob": dateC.text,
        "gender": gender,
        "phone": phoneC.text,
        "address": addC.text,
        "city": cityC.text,
        "State": stateC.text,
        "profilePic": file
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }
}
