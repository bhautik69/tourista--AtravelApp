// ignore_for_file: sort_child_properties_las
import 'package:flutter/material.dart';

import '../../widget/splashlogin.dart';
import '../Auth/signin.dart';

class Pageviewpage extends StatefulWidget {
  const Pageviewpage({super.key});

  @override
  State<Pageviewpage> createState() => _PageviewState();
}

class _PageviewState extends State<Pageviewpage> {
  final PageController controller = PageController(initialPage: 0);
  int pagecout = 0;
//Pagespepp
  void nextPage() {
    if (pagecout < 2) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        pagecout = controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                pagecout = index;
              });
            },
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: mq.size.width * 0.08,
                      top: mq.size.height * 0.09,
                    ),
                    child: const Text(
                      "Tourista",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: mq.size.width * 0.08,
                        bottom: mq.size.height * 0.028),
                    child: const Text(
                      "Plan A Trip",
                      style: TextStyle(color: Colors.black54, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: mq.size.width * 0.08),
                    child: SizedBox(
                      width: mq.size.width * 0.7,
                      child: const Text(
                        "Discover the world, explore, plan and embark on unforgettable adventures, one app at a time.",
                        style:
                            TextStyle(color: Color(0xff878593), fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.037),
                  Padding(
                    padding: EdgeInsets.only(left: mq.size.width * 0.072),
                    child:
                        GestureDetector(onTap: nextPage, child: Swipbutton()),
                  ),
                  SizedBox(
                    height: mq.size.height * 0.037,
                  ),
                  Column(
                    children: [
                      Container(
                        height: mq.size.height * 0.411,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  'assets/img/plan.png',
                                ))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mq.size.height * 0.09,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Signin(),
                                  ));
                            },
                            child: skipbutton()),
                      ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: mq.size.width * 0.08,
                      top: mq.size.height * 0.09,
                    ),
                    child: const Text(
                      "Tourista",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: mq.size.width * 0.08,
                        bottom: mq.size.height * 0.028),
                    child: const Text(
                      "Book Them",
                      style: TextStyle(color: Colors.black54, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: mq.size.width * 0.08),
                    child: SizedBox(
                      width: mq.size.width * 0.7,
                      child: const Text(
                        "Book now and travel smarter,faster and with more joy, Create memories that will last a lifetime,powered by our app.",
                        style:
                            TextStyle(color: Color(0xff878593), fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.037),
                  Padding(
                    padding: EdgeInsets.only(left: mq.size.width * 0.072),
                    child:
                        GestureDetector(onTap: nextPage, child: Swipbutton()),
                  ),
                  SizedBox(
                    height: mq.size.height * 0.037,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: mq.size.height * 0.411,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  'assets/img/book.png',
                                ))),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: mq.size.width * 0.08,
                      top: mq.size.height * 0.09,
                    ),
                    child: const Text(
                      "Tourista",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: mq.size.width * 0.08,
                        bottom: mq.size.height * 0.028),
                    child: const Text(
                      "Let's Travel",
                      style: TextStyle(color: Colors.black54, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: mq.size.width * 0.08,
                    ),
                    child: SizedBox(
                      width: mq.size.width * 0.7,
                      child: const Text(
                        "See the world differenrly and adventure awaits - start your journey with our app as your guide.",
                        style:
                            TextStyle(color: Color(0xff878593), fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.037),
                  Padding(
                    padding: EdgeInsets.only(left: mq.size.width * 0.072),
                    child: Card(
                      elevation: 10,
                      shadowColor: const Color(0xff0078aa),
                      child: InkWell(
                        child: Container(
                          height: 55,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff0078aa)),
                          child: const Center(
                              child: Text(
                            "SIGN IN",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Signin(),
                              ));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mq.size.height * 0.037,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: mq.size.height * 0.411,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  'assets/img/done.png',
                                ))),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          Positioned(
              bottom: mq.size.height * 0.09,
              left: mq.size.width * 0.438,
              child: row())
        ],
      ),
    );
  }

  Widget row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        pagecout == 0
            ? Container(
                height: 8,
                width: 20,
                decoration: BoxDecoration(
                    color: const Color(0xff0078aa),
                    borderRadius: BorderRadius.circular(8)))
            : Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    color: const Color(0xff0078aa).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8))),
        const SizedBox(
          width: 7,
        ),
        pagecout == 1
            ? Container(
                height: 8,
                width: 20,
                decoration: BoxDecoration(
                    color: const Color(0xff0078aa),
                    borderRadius: BorderRadius.circular(8)))
            : Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    color: const Color(0xff0078aa).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8))),
        const SizedBox(
          width: 7,
        ),
        pagecout == 2
            ? Container(
                height: 8,
                width: 20,
                decoration: BoxDecoration(
                    color: const Color(0xff0078aa),
                    borderRadius: BorderRadius.circular(8)))
            : Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    color: const Color(0xff0078aa).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8)))
      ],
    );
  }
}
