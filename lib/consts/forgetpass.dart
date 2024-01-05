
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:demo/widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool? ischeck = false;
  var emailC = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  /*void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      emailC.text = snapshot['email'] ?? " ok";

      setState(() {});
    });

    super.initState();
  }*/

  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var mq = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconlyLight.arrow_left_2),
            color: Colors.white,
          ),
          toolbarHeight: 8.8.h,
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Forgot Password"),
              SizedBox(
                height: 2,
              ),
              Text(
                "New Password",
                style: TextStyle(fontSize: 13.5),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 8.5.h,
                ),
                SizedBox(
                  height: 26.h,
                  width: 26.h,
                  child: Image.asset(
                    "assets/img/lock.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: SizedBox(
                    child: Text(
                      'Enter your email, we\'ll send you a link to change a new password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black, //Color(0xff0078aa,),
                          fontSize: 17),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: SizedBox(
                        child: TextFormField(
                      controller: emailC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email Address";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Enter Email",
                          //label: Text("Email"),
                          prefixIcon: const Icon(Icons.mail),
                          hintStyle: TextStyle(
                            color: themeState.getDarkTheme
                                ? Colors.white54
                                : Colors.black54,
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Color(0xff0078AA))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: themeState.getDarkTheme
                                      ? Colors.white54
                                      : Colors.black54)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: themeState.getDarkTheme
                                      ? Colors.white54
                                      : Colors.black54)),
                          errorStyle: const TextStyle(color: Color(0xffB00020)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1.5, color: Color(0xffB00020)),
                          )),
                    ))),
                SizedBox(
                  height: 7.5.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: SizedBox(
                      width: mq.size.width,
                      height: 55,
                      child: commenButton(
                          loading: loading,
                          title: 'SEND',
                          callback: () async {
                            if (_formKey.currentState!.validate()) {
                              emailC.text == "admin@gmail.com"
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Admin can't change passwors")))
                                  : await Forgetpass(context);
                            }
                          })),
                )
              ],
            ),
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Future<void> Forgetpass(BuildContext context) async {
    setState(() {
      loading = true;
    });

    await auth
        .sendPasswordResetEmail(email: emailC.text)
        .then((value) {})
        .whenComplete(() {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
    }).whenComplete(() {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("EMAIL SENT")));
      Navigator.pop(context);
    });
  }
}
