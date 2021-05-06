import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/request/controllers/request_controller.dart';
import 'package:flutter_blood_donation_app/app/utlis/size_config.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestView extends GetView<RequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.offNamed('/home');
            },
            child: Icon(Icons.arrow_back)),
        title: Text('RequestBlood'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.requestformKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: controller.phoneController,
                    validator: (v) {
                      if (v.isEmpty)
                        return 'Enter a valid';
                      else if (!v.isNum)
                        return 'Enter a prover result';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              print('search location');
                            },
                            child: Icon(Icons.search)),
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Phone No'),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Obx(
                    () => !controller.mylocation.value
                        ? TextFormField(
                            controller: controller.userAddressController,
                            validator: (v) {
                              if (v.length != 0) {
                                return null;
                              } else
                                return 'Enter a valid location';
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'User location and address'),
                          )
                        : Text(''),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Obx(
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
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText:
                                    'Hospital or emergency location and address'),
                          )
                        : Text(''),
                  ),
                ),
                Obx(
                  () => TextButton(
                    onPressed: () {
                      Get.to(
                        Scaffold(
                          body: controller.imagePath.value == ''
                              ? Container(
                                  // height: 200,
                                  child: CustomGoogleMap(),
                                )
                              : Container(
                                  height: 200,
                                  child: Image.memory(
                                    controller.data.value,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                        ),
                      );
                    },
                    child: !controller.map.value
                        ? Text('Mark your location on map')
                        : Container(
                            height: 200,
                            width: double.infinity,
                            child: Image.memory(controller.data.value,
                                fit: BoxFit.cover),
                          ),
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Checkbox(
                          value: !controller.isplatelets.value,
                          onChanged: (v) {
                            controller.isplatelets.value = false;
                          }),
                      Text('Blood ',
                          style: largeText.copyWith(color: Colors.grey)),
                      Checkbox(
                          value: controller.isplatelets.value,
                          onChanged: (v) {
                            controller.isplatelets.value = true;
                          }),
                      Text('Platelets ',
                          style: largeText.copyWith(color: Colors.grey)),
                    ]),
                  ),
                ),
                SizedBox(height: 10),
                Obx(() {
                  return Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      ...bloodgroup.map((e) => InkWell(
                            onTap: () {
                              controller.bloodgroup.value = e;
                              print(e);
                            },
                            child: CircleAvatar(
                              backgroundColor: controller.bloodgroup.value == e
                                  ? Colors.deepOrange
                                  : Theme.of(context).primaryColor,
                              radius: 30,
                              child: Text(
                                e,
                                style: largeText.copyWith(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))
                    ],
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => !userController.loading.value
                      ? Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              if (controller.requestformKey.currentState
                                      .validate() &&
                                  controller.map.value) {
                                controller.sendrequest();
                                Get.back();
                              } else
                                Get.snackbar('Error', 'Form not valid');
                            },
                            child: Text('Continue'),
                            style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor:
                                    Theme.of(context).primaryColor),
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
  GoogleMapController mapController;
  final reqController = Get.find<RequestController>();
  final markers = Set<Marker>.of([
    Marker(
      markerId: MarkerId('marker_1'),
      position: LatLng(
          userController.mylatitude.value, userController.mylongitude.value),
      consumeTapEvents: true,
      infoWindow: InfoWindow(
        title: 'Blood Request location',
        snippet: "My location",
      ),
      onTap: () {
        print("Marker tapped");
      },
    ),
  ]);
  @override
  Widget build(BuildContext context) {
    return _imageBytes == null
        ? Stack(
            children: [
              Center(
                child: Container(
                  height: SizeConfig.screenHeight / 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(userController.mylatitude.value,
                          userController.mylongitude.value),
                      zoom: 0.0,
                    ),
                    markers: markers,
                    mapType: MapType.normal,
                    onTap: (location) {
                      setState(() {
                        markers.add(
                          Marker(
                            markerId: MarkerId('marker_1'),
                            position:
                                LatLng(location.latitude, location.longitude),
                            consumeTapEvents: true,
                            infoWindow: InfoWindow(
                              title: 'Blood Request location',
                              snippet: "My location",
                            ),
                            onTap: () {
                              print("Marker tapped");
                            },
                          ),
                        );
                      });
                    },
                    onCameraMove: (cameraUpdate) =>
                        print('onCameraMove: $cameraUpdate'),
                    compassEnabled: true,
                    onMapCreated: (controller) {
                      setState(() {
                        mapController = controller;
                      });
                      reqController.loading.value = true;
                      Future.delayed(Duration(seconds: 2)).then(
                        (_) {
                          controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                bearing: 270.0,
                                target: LatLng(userController.mylatitude.value,
                                    userController.mylongitude.value),
                                tilt: 30.0,
                                zoom: 14,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () async {
                      await mapController.takeSnapshot().then((value) {
                        setState(() {
                          _imageBytes = value;
                        });
                        reqController.data.value = value;
                        reqController.map.value = true;
                        reqController.loading.value = false;
                        Get.back();
                      });
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        primary: Colors.white),
                    child: Text('Capture map'),
                  )),
            ],
          )
        : Image.memory(_imageBytes);
  }
}
