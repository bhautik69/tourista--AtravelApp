import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

typedef ContectDetails = Function(String email, String phone);

// ignore: must_be_immutable
class Usercontact extends StatefulWidget {
  ContectDetails contectDetails;
  Usercontact({super.key, required this.contectDetails});

  @override
  State<Usercontact> createState() => UsercontactState();
}

class UsercontactState extends State<Usercontact> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var phone = TextEditingController();
  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool validateStructureemail(String email) {
    String email1 = email.trim();
    if (emailValid.hasMatch(email1)) {
      return true;
    } else {
      return false;
    }
  }

  bool validateMobile(String value) {
    String pattern = r'(?:\+91|0)?[9678]\d{9}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Traveller details"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2,
                  color: Colors.white))), // centerTitle: true,

      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            SizedBox(
              height: mq.size.height * 0.028,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
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
                          SizedBox(
                            width: mq.size.width * 0.036,
                          ),
                          Text(
                            "Contact details",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: const Text(
                        "Contact email",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Required';
                          } else {
                            if (validateStructureemail(value)) {
                              return null;
                            } else {
                              return "Enter a valid Email";
                            }
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Enter email address",
                            hintStyle: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white54
                                  : Colors.black54,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 17, horizontal: 15),
                            prefixIcon: Icon(Icons.mail_outline),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black12),
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            // errorStyle:
                            //   const TextStyle(color: Color(0xffB00020)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Colors.red),
                            )),
                        onTap: () async {},
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: const Text(
                        "Contact number",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.height * 0.012,
                      ),
                      child: TextFormField(
                        controller: phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* required";
                          } else {
                            if (value.length != 10) {
                              return 'Invalid contact number';
                            } else {
                              if (!validateMobile(value)) {
                                return 'Invalid contact number';
                              } else {
                                return null;
                              }
                            }
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Enter phone number",
                            hintStyle: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white54
                                  : Colors.black54,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 17, horizontal: 15),
                            prefixIcon: Icon(Icons.phone_outlined),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black12),
                                borderRadius: BorderRadius.circular(2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: themeState.getDarkTheme
                                        ? Colors.white54
                                        : Colors.black54)),
                            // errorStyle:
                            //   const TextStyle(color: Color(0xffB00020)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Colors.red),
                            )),
                        onTap: () async {},
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.03,
                    ),
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
              child: Column(children: [
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
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: mq.size.height * 0.067,
                    width: mq.size.width,
                    child: commenButton(
                      title: "Done",
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          widget.contectDetails(email.text, phone.text);
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
