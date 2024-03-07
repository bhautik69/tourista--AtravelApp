import 'dart:io';

import 'package:demo/widget/button.dart';
import 'package:demo/widget/progresindicator.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

typedef Imgurl = Function(List img);
final imagePicker = ImagePicker();

// ignore: must_be_immutable
class UpdateImages extends StatefulWidget {
  List<dynamic> img;
  Imgurl imgurlpass;
  UpdateImages({super.key, required this.img, required this.imgurlpass});

  @override
  State<UpdateImages> createState() => _UpdateImagesState();
}

class _UpdateImagesState extends State<UpdateImages> {
  List<String> imgurl = [];
  List<XFile> images = [];
  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: TextButton(
                onPressed: () {
                  widget.imgurlpass(widget.img);
                  Navigator.pop(context);
                },
                child: Text(
                  "DONE",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )),
          )
        ],
        title: const Text(
          "Hotel Images",
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconlyLight.arrow_left_2)),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(4),
              itemCount: widget.img.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: Stack(
                    children: [
                      ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: 22.5.h,
                              maxWidth: 22.5.h,
                              minHeight: 22.5.h,
                              minWidth: 22.5.h),
                          child: FancyShimmerImage(
                            imageUrl: widget.img[index],
                            boxFit: BoxFit.cover,
                          )),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                            onPressed: () {
                              widget.img.removeAt(index);

                              setState(() {});
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.red[600],
                              size: 31,
                            )),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(offset: const Offset(5, 5), color: Colors.black12)
                ]),
            height: mq.size.height * 0.1,
            child: Column(children: [
              Container(width: mq.size.width, height: 3, color: Colors.black12),
              SizedBox(
                height: mq.size.height * 0.016,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: mq.size.height * 0.067,
                  width: mq.size.width,
                  child: commenButton(
                    loading: isLoding,
                    title: "Pick Images",
                    callback: () async {
                      pickimage();
                    },
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  pickimage() async {
    final List<XFile>? pickimage = await imagePicker.pickMultiImage();

    if (pickimage != null) {
      setState(() {
        images.addAll(pickimage);
        print(images);
      });
      uploadImages(); // Call uploadImages after adding images
    }
  }

  Future postimages(XFile? img) async {
    String urls;
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(img!.name);
    await ref.putData(await img.readAsBytes());
    SettableMetadata(contentType: "image/jpeg");
    urls = await ref.getDownloadURL();
    return urls;
  }

  uploadImages() async {
    setState(() {
      isLoding = true;
    });
    for (var img in images) {
      await postimages(img).then((value) {
        setState(() {
          widget.img.add(value); // Add image URL to widget.img list
        });
      });
    }
    setState(() {
      images.clear();
      isLoding = false;
    });
  }
}
