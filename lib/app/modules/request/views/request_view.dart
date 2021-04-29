import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/request/controllers/request_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestView extends GetView<RequestController> {
  @override
  Widget build(BuildContext context) {
    //  var scr = new GlobalKey();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: controller.requestformKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // padding: EdgeInsets.only(left: 20, right: 10, top: 20),
                children: [
                  AppBar(
                    leading: InkWell(
                        onTap: () {
                          Get.offNamed('/home');
                        },
                        child: Icon(Icons.arrow_back)),
                    title: Text('RequestBlood'),
                    //centerTitle: true,
                  ),
                  Text(
                    'Our donors help when you need them the most',
                    textAlign: TextAlign.center,
                    style: smallText.copyWith(color: grey),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(' Request on behalf of friend'),
                    Obx(
                      () => Switch(
                        value: controller.isSwitched.value,
                        onChanged: (value) {
                          controller.isSwitched.value = value;
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ),
                  ]),
                  SizedBox(height: 10),
                  // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //   Text('Find donor near my location'),
                  //   Obx(
                  //     () => Switch(
                  //       value: controller.mylocation.value,
                  //       onChanged: (value) {
                  //         controller.mylocation.value = value;
                  //       },
                  //       activeTrackColor: Colors.lightGreenAccent,
                  //       activeColor: Colors.green,
                  //     ),
                  //   ),
                  // ]),
                  // SizedBox(height: 10),
                  Obx(
                    () => !controller.mylocation.value
                        ? TextFormField(
                            controller: controller.locationController,
                            validator: (v) {
                              if (v.length != 0) {
                                return null;
                              } else
                                return 'Enter a valid location';
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8.0),
                                border: UnderlineInputBorder(),
                                labelText: 'Hospital or emergency location'),
                          )
                        : Text(''),
                  ),
                  Obx(
                    () => controller.mylocation.value
                        ? Text(
                            'Ranibari,Kathmandu',
                            style: mediumText,
                          )
                        : Container(),
                  ),
                  Obx(
                    () => controller.imagePath.value == ''
                        ? Container(
                            // height: 200,
                            child: CustomGoogleMap(),
                          )
                        : Image.memory(
                            controller.data.value,
                            height: 100,
                            width: double.infinity,
                          ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: controller.detailController,
                        validator: (v) {
                          if (v.isEmpty)
                            return 'Enter a valid';
                          else if (v.isNum)
                            return 'Enter a prover result';
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                            hintMaxLines: 3, hintText: 'Hospital detail')),
                  ),
                  SizedBox(height: 10),
                  Obx(() => controller.isSwitched.value
                      ? Text('Required Blood Group',
                          style: largeText.copyWith(color: Colors.grey))
                      : const Text('')),
                  SizedBox(height: 10),
                  Obx(() {
                    if (controller.isSwitched.value)
                      return Container(
                          height: 170,
                          child: GridView(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, right: 20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30),
                            children: [
                              for (int i = 0; i < 8; i++)
                                InkWell(
                                  onTap: () {
                                    controller.bloodgroup.value = bloodgroup[i];
                                  },
                                  child: CircleAvatar(
                                      backgroundColor:
                                          controller.bloodgroup.value ==
                                                  bloodgroup[i]
                                              ? Colors.red
                                              : Colors.grey,
                                      child: Text(
                                        bloodgroup[i],
                                        style: mediumText.copyWith(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                      )),
                                ),
                            ],
                          ));
                    return Container();
                  }),
                  Obx(() => SizedBox(
                        height: controller.isSwitched.value ? 20 : 170,
                      )),
                  Obx(
                    () => !userController.loading.value
                        ? Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                if (controller.requestformKey.currentState
                                    .validate()) {
                                  controller.sendrequest();
                                  Get.offNamed("/home");
                                }
                              },
                              child: Text('Continue'),
                              style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.deepOrange),
                            ),
                          )
                        : Text('Loading'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'These Services are free of cost. do not pay anyone',
                    style: smallText.copyWith(color: grey),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({
    Key key,
  }) : super(key: key);

  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  Uint8List _imageBytes;
  final reqController = Get.find<RequestController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 140,
          child: _imageBytes == null
              ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(userController.mylatitude.value,
                        userController.mylongitude.value),
                    zoom: 0.0,
                  ),
                  markers: Set<Marker>.of(
                    [
                      Marker(
                        markerId: MarkerId('marker_1'),
                        position: LatLng(userController.mylatitude.value,
                            userController.mylongitude.value),
                        consumeTapEvents: true,
                        infoWindow: InfoWindow(
                          title: 'Blood Request location',
                          snippet: "My location",
                        ),
                        onTap: () {
                          print("Marker tapped");
                        },
                      ),
                    ],
                  ),
                  mapType: MapType.normal,
                  onTap: (location) => print('onTap: $location'),
                  onCameraMove: (cameraUpdate) =>
                      print('onCameraMove: $cameraUpdate'),
                  compassEnabled: true,
                  onMapCreated: (controller) {
                    reqController.loading.value = true;
                    Future.delayed(Duration(seconds: 2)).then(
                      (_) {
                        controller
                            .animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  bearing: 270.0,
                                  target: LatLng(
                                      userController.mylatitude.value,
                                      userController.mylongitude.value),
                                  tilt: 30.0,
                                  zoom: 14,
                                ),
                              ),
                            )
                            .then((value) =>
                                Future.delayed(Duration(seconds: 2))
                                    .then((_) async {
                                  await controller.takeSnapshot().then((value) {
                                    setState(() {
                                      _imageBytes = value;
                                    });
                                    reqController.data.value = value;
                                    reqController.loading.value = false;
                                  });

                                  //  print(reqController.data.value);
                                }));
                        //   controller.getVisibleRegion().then(
                        //       (bounds) => print("bounds: ${bounds.toString()}"));
                      },
                    );
                    // _mapController = controller;
                  },
                )
              : Image.memory(_imageBytes),
        ),
        // if (_imageBytes == null)
        //   TextButton(
        //     child: Text(
        //       'Take a snapshot',
        //     ),
        //     onPressed: () async {
        //       final imageBytes = await _mapController?.takeSnapshot();
        //       setState(() {
        //         _imageBytes = imageBytes;
        //       });
        //     },
        //   ),
      ],
    );
  }
}
