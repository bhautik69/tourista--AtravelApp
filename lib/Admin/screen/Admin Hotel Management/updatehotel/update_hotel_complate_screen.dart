import 'package:demo/Admin/screen/Admin%20Hotel%20Management/addhotel/bootomseet.dart';
import 'package:demo/Admin/screen/Admin%20Hotel%20Management/addhotel/imagesshow.dart';
import 'package:demo/Admin/screen/Admin%20Hotel%20Management/updatehotel/updateimages.dart';

import 'package:demo/models/Hotel%20models/hotelAdd.dart';
import 'package:demo/models/Trip%20models/packagemodel.dart';
import 'package:demo/widget/button.dart';
import 'package:demo/widget/textwidget.dart';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class UpdateComplateHotel extends StatefulWidget {
  String? id;
  Hotel? hotel;
  UpdateComplateHotel({super.key, required this.id, required this.hotel});

  @override
  State<UpdateComplateHotel> createState() => _UpdateComplateHotelState();
}

class _UpdateComplateHotelState extends State<UpdateComplateHotel> {
  bool isloading = false;

  final _formKey = GlobalKey<FormState>();
  List<dynamic> imgUrl = [];
  var checkinConroller = TextEditingController();
  var priceConroller = TextEditingController();
  var checkinuntilConroller = TextEditingController();
  var checkoutConroller = TextEditingController();
  var hotelnameController = TextEditingController();
  var descriptionController = TextEditingController();
  var cityController = TextEditingController();
  var distancetocenterController = TextEditingController();
  var addressController = TextEditingController();
  var latitudeController = TextEditingController();
  var longitudeContoller = TextEditingController();
  var trsfeeController = TextEditingController();
  var trstimeController = TextEditingController();
  var trsdisContoller = TextEditingController();
  var facilityController = TextEditingController();
  var imagesController = TextEditingController();

  final imagePicker = ImagePicker();
  List<XFile> images = [];
  Map<String, dynamic>? ficility;

  @override
  void initState() {
    checkinConroller.text = widget.hotel!.checkinfrom!;
    priceConroller.text = widget.hotel!.price!;
    checkinuntilConroller.text = widget.hotel!.checkinUntil!;
    checkoutConroller.text = widget.hotel!.checkoutUntil!;
    hotelnameController.text = widget.hotel!.name!;
    descriptionController.text = widget.hotel!.description!;
    cityController.text = widget.hotel!.cityName!;
    distancetocenterController.text = widget.hotel!.disttocenter!;

    addressController.text = widget.hotel!.address!;
    latitudeController.text = widget.hotel!.latitude!;
    longitudeContoller.text = widget.hotel!.longitude!;
    trsfeeController.text = widget.hotel!.transeferFee!;
    trstimeController.text = widget.hotel!.traveltimetoairport!;
    trsdisContoller.text = widget.hotel!.distFromAirport!;
    imagesController.text = widget.hotel!.images!.length.toString();

    ficility = widget.hotel!.facilities!;
    imgUrl = widget.hotel!.images!;
    int a = 0;
    for (int i = 0; i < 14; i++) {
      if (ficility![i.toString()] == true) {
        a = a + 1;
      }
    }
    facilityController.text = a.toString();

    super.initState();
  }

  void updateFacility(Map<String, dynamic> newFacility) {
    int a = 0;
    setState(() {
      ficility = newFacility;
      for (int i = 0; i < 14; i++) {
        if (ficility![i.toString()] == true) {
          a = a + 1;
        }
      }

      print(ficility);
      facilityController.text = a.toString();
      setState(() {});
    });
  }

  var uuid = const Uuid();
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 235, 235),
      appBar: AppBar(
        title: const Text(
          "Update Hotels",
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconlyLight.arrow_left_2)),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        const Titletext(title: "Hotel Details"),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: hotelnameController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Name of Resort"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: descriptionController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Resort Description"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        TextFormField(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Bottomseetfasility(
                                  faciliti1: ficility!,
                                  updateFacility: updateFacility,
                                );
                              },
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: facilityController,
                          readOnly: true,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Facilities"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        TextFormField(
                          readOnly: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateImages(
                                    img: imgUrl,
                                    imgurlpass: (img) {
                                      imgUrl = img;
                                      imagesController.text =
                                          imgUrl.length.toString();

                                      setState(() {});
                                    },
                                  ),
                                ));
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: imagesController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Images"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: priceConroller,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Price"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.size.height * 0.01,
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        const Titletext(title: "Property Location"),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: cityController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("City Name"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: distancetocenterController,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Distance To Center(km)"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: addressController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Property Address"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: latitudeController,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Latitude"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: longitudeContoller,
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text("Longitude"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.size.height * 0.01,
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        const Titletext(title: "Check-In[24-hour]"),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          readOnly: true,
                          controller: checkinConroller,
                          onTap: () async {
                            var pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode.input);
                            if (pickedTime != null) {
                              // Format the picked time using DateFormat
                              String formattedTime =
                                  DateFormat('hh:mm a').format(
                                DateTime(2024, 1, 1, pickedTime.hour,
                                    pickedTime.minute),
                              );
                              setState(() {
                                checkinConroller.text = formattedTime;
                              });
                            }
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                            label: Text("Check-In From"),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xff0078aa))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelStyle: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          readOnly: true,
                          controller: checkinuntilConroller,
                          onTap: () async {
                            var pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode.input);
                            if (pickedTime != null) {
                              // Format the picked time using DateFormat
                              String formattedTime =
                                  DateFormat('hh:mm a').format(
                                DateTime(2024, 1, 1, pickedTime.hour,
                                    pickedTime.minute),
                              );
                              setState(() {
                                checkinuntilConroller.text = formattedTime;
                              });
                            }
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                            label: Text("Check-In Until"),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xff0078aa))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelStyle: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          readOnly: true,
                          controller: checkoutConroller,
                          onTap: () async {
                            var pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode.input);
                            if (pickedTime != null) {
                              // Format the picked time using DateFormat
                              String formattedTime =
                                  DateFormat('hh:mm a').format(
                                DateTime(2024, 1, 1, pickedTime.hour,
                                    pickedTime.minute),
                              );
                              setState(() {
                                checkoutConroller.text = formattedTime;
                              });
                            }
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                            label: Text("Check-Out Until"),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xff0078aa))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelStyle: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.size.height * 0.01,
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        const Titletext(title: "Airport Transfer"),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: trsfeeController,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Airport Transfer Fee"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: trsdisContoller,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Distance from Airport(km)"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* required";
                            }
                            return null;
                          },
                          controller: trstimeController,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              label: Text("Travel Time To Airport(min)"),
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Color(0xff0078aa))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: commenButton(
                        title: "Update",
                        loading: isloading,
                        callback: () {
                          if (_formKey.currentState!.validate()) {
                            update();
                          }
                        })),
                const SizedBox(
                  height: 25,
                )
              ],
            ),
          )),
    );
  }

  update() async {
    setState(() {
      isloading = true;
    });

    await Hotel.updatehoteldetail(
            widget.id!,
            Hotel(
                id: widget.id,
                name: hotelnameController.text,
                description: descriptionController.text,
                facilities: ficility,
                images: imgUrl,
                price: priceConroller.text,
                cityName: cityController.text,
                disttocenter: distancetocenterController.text,
                address: addressController.text,
                latitude: latitudeController.text,
                longitude: longitudeContoller.text,
                checkinfrom: checkinConroller.text,
                checkinUntil: checkinuntilConroller.text,
                checkoutUntil: checkoutConroller.text,
                transeferFee: trsfeeController.text,
                distFromAirport: trsdisContoller.text,
                traveltimetoairport: trstimeController.text))
        .whenComplete(() {
      setState(() {
        isloading = false;

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("UPDATE SUCCESSFULLY")));
      });
    });
  }

  clearFields() {
    setState(() {
      latitudeController.clear();
      longitudeContoller.clear();
      checkinConroller.clear();
      checkinuntilConroller.clear();
      checkoutConroller.clear();
      trsfeeController.clear();
      trsdisContoller.clear();
      trstimeController.clear();
      addressController.clear();
      distancetocenterController.clear();
      hotelnameController.clear();
      descriptionController.clear();
      ficility!.clear();
      imgUrl.clear();
      images.clear();
      facilityController.clear();
      imagesController.clear();
      cityController.clear();
      priceConroller.clear();
    });
  }
}
