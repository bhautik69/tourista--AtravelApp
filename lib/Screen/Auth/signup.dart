// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Exeptiopn/signup_fail.dart';
import 'package:demo/Screen/Auth/signin.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/errortoast.dart';
import 'package:demo/widget/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widget/progresindicator.dart';

import '../Navigationpages/main_page.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool _ps = true;
  bool _cps = true;
  bool _nameFieldTouched = false;
  bool _passwordFieldTouched = false;
  bool _emailFieldTouched = false;
  bool _confirmpasswordFieldTouched = false;
  var emailC = TextEditingController();
  var nameC = TextEditingController();
  var passwordC = TextEditingController();
  var cpasswordC = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names, valid_regexps
  RegExp name = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
  // ignore: non_constant_identifier_names
  RegExp pass_valid =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_]).{8,}$');

  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // password validatoon
  bool validateStructure(String pass) {
    String password1 = pass.trim();
    if (pass_valid.hasMatch(password1)) {
      return true;
    } else {
      return false;
    }
  }

  //name validation
  bool validateStructurename(String nam) {
    String nm = nam.trim();
    if (name.hasMatch(nm)) {
      return true;
    } else {
      return false;
    }
  }

  //email validation
  bool validateStructureemail(String email) {
    String email1 = email.trim();
    if (emailValid.hasMatch(email1)) {
      return true;
    } else {
      return false;
    }
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
                    width: mq.size.width,
                    // height: mq.size.height * 0.267,
                    fit: BoxFit.cover,
                    "assets/img/login.png"),
                Positioned(
                  left: mq.size.width * 0.1,
                  bottom: mq.size.height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Sign up",
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 39),
                      ),
                      Text(
                        "Create a new account.",
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
                height: mq.size.height * 0.035,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: commentextfield(
                      controllername: nameC,
                      lable: "NAME",
                      hinttext: "Enter Name",
                      validator: (value) {
                        if (_nameFieldTouched) {
                          if (value == null || value.isEmpty) {
                            return '* Required';
                          } else {
                            if (validateStructurename(value)) {
                              return "Enter a Valid Name";
                            } else {
                              return null;
                            }
                          }
                        }
                        return null;
                      },
                      onTap: () {
                        setState(() {
                          _nameFieldTouched = false;
                          _formKey.currentState?.validate();
                        });
                      })),
              SizedBox(
                height: mq.size.height * 0.029,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: commentextfield(
                    controllername: emailC,
                    lable: "EMAIL",
                    hinttext: "Enter Email",
                    textInputType: TextInputType.emailAddress,
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
                    },
                  )),
              SizedBox(
                height: mq.size.height * 0.029,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: commentextfield(
                    controllername: passwordC,
                    obscurevalue: _ps,
                    lable: "PASSWORD",
                    suffixicon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _ps = !_ps;
                        });
                      },
                      child:
                          Icon(_ps ? Icons.visibility_off : Icons.visibility),
                    ),
                    hinttext: "Enter Password",
                    validator: (value) {
                      if (_passwordFieldTouched) {
                        if (value == null || value.isEmpty) {
                          return '* Required';
                        } else {
                          if (validateStructure(value)) {
                            return null;
                          } else {
                            return "Password must be least 8 chars, 1 uppercase, 1 lowercase, 1 number, special chars";
                          }
                        }
                      } else {
                        return null;
                      }
                    },
                    onTap: () {
                      setState(() {
                        _passwordFieldTouched = false;
                        _formKey.currentState?.validate();
                      });
                    },
                  )),
              SizedBox(
                height: mq.size.height * 0.029,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: commentextfield(
                    controllername: cpasswordC,
                    obscurevalue: _cps,
                    onTap: () {
                      setState(() {
                        _confirmpasswordFieldTouched = false;
                        _formKey.currentState?.validate();
                      });
                    },
                    suffixicon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _cps = !_cps;
                        });
                      },
                      child:
                          Icon(_cps ? Icons.visibility_off : Icons.visibility),
                    ),
                    lable: "CONFIRM PASSWORD",
                    hinttext: "Enter Confirm Password",
                    validator: (value) {
                      if (_confirmpasswordFieldTouched) {
                        if (value == null || value.isEmpty) {
                          return '* Required';
                        } else {
                          if (cpasswordC.text == passwordC.text) {
                            return null;
                          } else {
                            return "Confirm Password Didn't Match";
                          }
                        }
                      } else {
                        return null;
                      }
                    },
                  )),
              SizedBox(
                height: mq.size.height * 0.062,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SizedBox(
                    width: mq.size.width,
                    height: 52,
                    child: commenButton(
                        title: "SIGN UP",
                        callback: () {
                          register();
                        })),
              ),
              SizedBox(
                height: mq.size.height * 0.01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Already Registered?",
                  style: TextStyle(color: Color(0xff878593)),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Signin(),
                        ));
                  },
                  child: Text(
                    " Login",
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

  void register() async {
    setState(() {
      _confirmpasswordFieldTouched = true;
      _passwordFieldTouched = true;
      _emailFieldTouched = true;
      _nameFieldTouched = true;
    });
    if (_formKey.currentState!.validate()) {
      showProgressDialog(context);
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: emailC.text.toString(),
                password: passwordC.text.toString())
            .whenComplete(() {
          saveInfo();
        }).then((value) {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Mainpage()));
        });
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        final ex = Signupfail.code(e.code);
        Errortoast().toastmsg(ex.msg);
        throw ex;
      } catch (_) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        const ex = Signupfail();
        Errortoast().toastmsg(ex.msg);
        throw ex;
      }
    }
  }

  saveInfo() {
    Map<String, dynamic> data = {
      "name": nameC.text,
      "email": emailC.text,
      "dob": "",
      "gender": "",
      "phone": "",
      "address": "",
      "city": "",
      "State": "",
      "profilePic": ""
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(data)
        .whenComplete(() {
      FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
    });
  }
}
