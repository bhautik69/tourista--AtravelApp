// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:demo/Admin/screen/adminmainpage.dart';
import 'package:demo/Screen/Auth/signup.dart';
import 'package:demo/consts/forgetpass.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/errortoast.dart';
import 'package:demo/widget/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Exeptiopn/signin_fail.dart';
import '../../widget/progresindicator.dart';
import '../Navigationpages/main_page.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool? ischeck = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var password = TextEditingController();
  var email = TextEditingController();
  String adminemail = "admin@gmail.com";
  String adminpass = "Admin@123";
  bool _emailFieldTouched = false;
  bool _passwordFieldTouched = false;
  final _formKey = GlobalKey<FormState>();
  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //email validation
  bool validateStructureemail(String email) {
    String email1 = email.trim();
    if (emailValid.hasMatch(email1)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<DocumentSnapshot> adminSigin(String id) async {
    var result =
        await FirebaseFirestore.instance.collection("admin").doc(id).get();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
        body: NotificationListener(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Image.asset(
                    fit: BoxFit.cover,
                    width: mq.size.width,
                    "assets/img/login.png"),
                Positioned(
                  left: mq.size.width * 0.1,
                  bottom: mq.size.height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                      Text(
                        "Sign in to continue.",
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                )
              ]),
              SizedBox(
                height: mq.size.height * 0.09,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: commentextfield(
                      textInputType: TextInputType.emailAddress,
                      lable: "EMAIL",
                      hinttext: "Enter Email",
                      prefixicon: Icon(Icons.mail_outline_rounded),
                      controllername: email,
                      validator: (value) {
                        if (_emailFieldTouched) {
                          if (value == null || value.isEmpty) {
                            return '* Required';
                          } else {
                            if (validateStructureemail(value)) {
                              return null;
                            } else {
                              return "Enter a valid Email";
                            }
                          }
                        } else {
                          return null;
                        }
                      },
                      onTap: () {
                        setState(() {
                          _emailFieldTouched = false;
                          _formKey.currentState?.validate();
                        });
                      })),
              SizedBox(
                height: mq.size.height * 0.05,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: commentextfield(
                      controllername: password,
                      obscurevalue: !ischeck!,
                      prefixicon: Icon(Icons.lock_outline_rounded),
                      lable: "PASSWORD",
                      hinttext: "Enter Password",
                      validator: (value) {
                        if (_passwordFieldTouched) {
                          if (value == null || value.isEmpty) {
                            return '* Required';
                          }
                        } else {
                          return null;
                        }
                        return null;
                      },
                      onTap: () {
                        setState(() {
                          _passwordFieldTouched = false;
                          _formKey.currentState?.validate();
                        });
                      })),
              Padding(
                padding: EdgeInsets.only(left: 8, top: 5, right: 10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          activeColor: Color(0xff0078aa),
                          value: ischeck,
                          onChanged: (bool? val) {
                            setState(() {
                              ischeck = val!;
                            });
                          }),
                      Text(
                        "Show password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgetPassword(),
                              ));
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: mq.size.height * 0.12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SizedBox(
                    width: mq.size.width,
                    height: 50,
                    child: commenButton(
                        title: "SIGN IN",
                        callback: () {
                          setState(() {
                            _emailFieldTouched = true;
                            _passwordFieldTouched = true;
                          });

                          login();
                        })),
              ),
              SizedBox(
                height: mq.size.height * 0.01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(color: Color(0xff878593)),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signup(),
                        ));
                  },
                  child: Text(
                    " Sign up",
                    style: TextStyle(
                        color: Color(0xff0078aa), fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    ));
  }

  void login() async {
    if (adminemail == email.text && adminpass == password.text) {
      if (_formKey.currentState!.validate()) {
        showProgressDialog(context);
        await adminSigin(email.text).then((value) async {
          if (value['email'] == email.text &&
              value['password'] == password.text) {
            try {
              await _auth
                  .signInWithEmailAndPassword(
                      email: email.text.toString(),
                      password: password.text.toString())
                  .then((value) {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Adminmainpage()));
              });
            } on FirebaseAuthException catch (e) {
              Navigator.pop(context);
              final ex = Signinfail.code(e.code);
              Errortoast().toastmsg(ex.msg);

              throw ex;
            } catch (_) {
              Navigator.pop(context);
              const ex = Signinfail();
              Errortoast().toastmsg(ex.msg);
              throw ex;
            }
          }
        });
      }
    } else {
      if (_formKey.currentState!.validate()) {
        showProgressDialog(context);

        try {
          await _auth
              .signInWithEmailAndPassword(
                  email: email.text.toString(),
                  password: password.text.toString())
              .then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Mainpage()));
          });
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          final ex = Signinfail.code(e.code);
          Errortoast().toastmsg(ex.msg);

          throw ex;
        } catch (_) {
          Navigator.pop(context);
          const ex = Signinfail();
          Errortoast().toastmsg(ex.msg);
          throw ex;
        }
      }
    }
  }
}
