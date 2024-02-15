import 'package:demo/widget/button.dart';
import 'package:flutter/material.dart';

class ChildAgaSheet extends StatefulWidget {
  // int? ages;

  // ChildAgaSheet(int ages);
  const ChildAgaSheet({super.key});

  @override
  State<ChildAgaSheet> createState() => _ChildAgaSheetState();
}

class _ChildAgaSheetState extends State<ChildAgaSheet> {
  String ages = "0";
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return SizedBox(
      height: mq.size.height / 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 17,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${index + 1}"),
                        Radio(
                          value: (index + 1).toString(),
                          groupValue: ages,
                          onChanged: (value) {
                            setState(() {
                              ages = value.toString();
                              print("--------------$ages------------------");
                            });
                          },
                        ),
                        // Radio(
                        //   value: index + 1,
                        //   groupValue: widget.ages,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       widget.ages = value!;
                        //     });
                        //   },
                        // ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            SizedBox(
              height: mq.size.height * 0.055,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: mq.size.height * 0.06,
                    width: mq.size.width * 0.40,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff0078aa)),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Remove",
                        style: TextStyle(
                            color: Color(0xff0078aa),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mq.size.height * 0.06,
                    width: mq.size.width * 0.40,
                    child: commenButton(
                      title: "Done",
                      callback: () {
                        // Global.ages = widget.ages!;
                        // setState(() {
                        // print("${Global.ages}");
                        // });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
