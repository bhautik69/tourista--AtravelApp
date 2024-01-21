import 'package:demo/Screen/Navigationpages/home/tabbarScreen/fligthtab.dart';
import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';

class bottomSheet extends StatefulWidget {
  const bottomSheet({super.key});

  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {
  int quantity = 1;
  int quantity1 = 0;
  int qunt = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Text(
              "Who's flying?",
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Travelles",
              style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  "Adults",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 132),
                  child: Container(
                      height: 50,
                      width: 135,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          IncrementAndDecrement(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              icon: Icons.remove),
                          Text(
                            quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          IncrementAndDecrement(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: Icons.add),
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  "Children",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: Container(
                      height: 50,
                      width: 135,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          IncrementAndDecrement(
                              onPressed: () {
                                if (quantity1 > 0) {
                                  setState(() {
                                    quantity1--;
                                  });
                                }
                              },
                              icon: Icons.remove),
                          Text(
                            quantity1.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          IncrementAndDecrement(
                              onPressed: () {
                                setState(() {
                                  quantity1++;
                                });
                              },
                              icon: Icons.add),
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.topRight,
              child: commenButton(
                title: "Done",
                callback: () {
                  setState(() {
                    qunt = quantity + quantity1;
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Fligthtab(
                      qut: qunt,
                    ),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  const IncrementAndDecrement(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      height: 30,
      elevation: 2,
      //color: Colors.grey[300],
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Icon(icon),
    );
  }
}
