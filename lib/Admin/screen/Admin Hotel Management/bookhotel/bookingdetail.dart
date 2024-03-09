import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class BookingDetail extends StatefulWidget {
  String id;
  String email;
  String phone;
  List adultList;
  List childList;
  BookingDetail(
      {super.key,
      required this.id,
      required this.email,
      required this.phone,
      required this.adultList,
      required this.childList});

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  int adultLength = 0;
  int childLength = 0;

  @override
  void initState() {
    adultLength = widget.adultList.length;
    childLength = widget.childList.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Travellers Details"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrow_left_2, color: Colors.white))),
      body: widget.email.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff0078aa),
              ),
            )
          : Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      height: mq.size.height * 0.02,
                    ),
                    Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: mq.size.width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: mq.size.height * 0.01,
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Contact Details",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.035,
                                ),
                                Text(
                                  "Email        :   ${widget.email}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.028,
                                ),
                                Text(
                                  "Phone       :   ${widget.phone}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.028,
                                ),
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.04,
                    ),
                    Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const Text(
                              "Travellers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: adultLength + childLength,
                              itemBuilder: (context, index) {
                                return index < adultLength
                                    ? adultDisplay(
                                        widget.adultList[index]["firstName"],
                                        widget.adultList[index]["lastName"],
                                        widget.adultList[index]["gender"],
                                        index)
                                    : childrenDisplay(
                                        widget.childList[index - adultLength]
                                            ["firstName"],
                                        widget.childList[index - adultLength]
                                            ["lastName"],
                                        widget.childList[index - adultLength]
                                            ["gender"],
                                        widget.childList[index - adultLength]
                                            ["dob"],
                                        index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ]),
                ))
              ],
            ),
    );
  }

  adultDisplay(String first, String last, String gender, int index) => SizedBox(
        width: MediaQuery.of(context).size.width,
        // color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text("Traveller  ${index + 1} (Adult)",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                // ignore: prefer_interpolation_to_compose_strings
                "Firstname  :  $first",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.028,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                // ignore: prefer_interpolation_to_compose_strings
                "Lastname  :  $last",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.028,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                // ignore: prefer_interpolation_to_compose_strings
                "Gender       :  $gender",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
          ],
        ),
      );

  childrenDisplay(
          String first, String last, String gender, String dob, int index) =>
      SizedBox(
        width: MediaQuery.of(context).size.width,
        // color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text("Traveller  ${index + 1} (Children)",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                // ignore: prefer_interpolation_to_compose_strings
                "Firstname  :  $first",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.028,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                // ignore: prefer_interpolation_to_compose_strings
                "Lastname  :  $last",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.028,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                // ignore: prefer_interpolation_to_compose_strings
                "Gender       :  $gender",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.028,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                // ignore: prefer_interpolation_to_compose_strings
                "DOB            :  $dob",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
          ],
        ),
      );
}
