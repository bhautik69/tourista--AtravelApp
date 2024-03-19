import 'dart:io';

import 'package:demo/widget/progresindicator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

typedef Imgurl = Function(List img);

// ignore: must_be_immutable
class Images extends StatefulWidget {
  List<dynamic> img;
  Imgurl imgurl;
  Images({super.key, required this.img, required this.imgurl});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  List<String> imgurl = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: TextButton(
                onPressed: () {
                  uploadImages();
                },
                child: const Text(
                  "DONE",
                  style: TextStyle(
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
              widget.img.clear();
            },
            icon: const Icon(IconlyLight.arrow_left_2)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: widget.img.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
                  child: Image.file(
                    File(
                      widget.img[index].path,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
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
    );
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
    showProgressDialog(context);
    for (var img in widget.img) {
      postimages(img).then((value) => imgurl.add(value)).whenComplete(() {
        if (imgurl.length == widget.img.length) {
          widget.imgurl(imgurl);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      });
    }
    setState(() {});
  }
}
