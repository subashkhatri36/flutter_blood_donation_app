import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/Widgets/CustomButton.dart';
import 'package:flutter_blood_donation_app/app/Widgets/custome_text_field.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/account/controllers/account_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/request/controllers/request_controller.dart';
import 'package:flutter_blood_donation_app/app/utlis/size_config.dart';
import 'package:flutter_blood_donation_app/app/utlis/validators.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/updateaccount_controller.dart';

class UpdateaccountView extends GetView<UpdateaccountController> {
  final model = Get.arguments;
  final mcontroller = Get.find<AccountController>();
  final updateController = Get.find<UpdateaccountController>();
  @override
  Widget build(BuildContext context) {
    controller.loading(model);
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Acount'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(Defaults.borderRadius),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  CustomTextField(
                    round: true,
                    hintText: 'Fullname',
                    controller: controller.nameController,
                    prefixIcon: Icons.account_box,
                    validator: (value) =>
                        validateMinLength(string: value, length: 3),
                  ),
                  SizedBox(height: Defaults.paddingmiddle),
                  CustomTextField(
                    round: true,
                    hintText: 'Phone',
                    prefixIcon: Icons.phone,
                    controller: controller.poneController,
                    validator: (value) =>
                        validateMinMaxLength(string: value, minLegth: 10),
                  ),
                  SizedBox(height: Defaults.paddingmiddle),
                  // Obx(() => Text(controller.mylatitude.value.toString())),
                  SizedBox(height: Defaults.paddingmiddle),
                  //     Container (
                  //       height:200,
                  //       child: GoogleMap(
                  //   initialCameraPosition: CameraPosition(
                  //       target: LatLng(updateController.mylatitude.value,
                  //           updateController .mylongitude.value),
                  //       zoom: 0.0,
                  //   ),
                  //   markers: Set<Marker>.of(
                  //       [
                  //         Marker(

                  //           markerId: MarkerId('marker_1'),
                  //           position: LatLng(controller.mylatitude.value,
                  //               controller.mylongitude.value),
                  //           consumeTapEvents: true,
                  //           infoWindow: InfoWindow(
                  //             title: 'Blood Request location',
                  //             snippet: "My location",
                  //           ),
                  //           onTap: () {
                  //             print("Marker tapped");
                  //           },
                  //         ),
                  //       ],
                  //   ),
                  //   mapType: MapType.normal,
                  //   onTap: (location) => print('onTap: $location'),
                  //   onCameraMove: (cameraUpdate) =>
                  //         print('onCameraMove: $cameraUpdate'),
                  //   compassEnabled: true,
                  //   onMapCreated: (controller) {
                  //       ///  reqController.loading.value = true;
                  //       Future.delayed(Duration(seconds: 2)).then(
                  //         (_) {
                  //            updateController .mapController=controller;
                  //           controller
                  //               .animateCamera(
                  //                 CameraUpdate.newCameraPosition(
                  //                   CameraPosition(
                  //                     bearing: 270.0,
                  //                     target: LatLng(
                  //                        updateController  .mylongitude.value,
                  //                         updateController   .mylongitude.value),
                  //                     tilt: 30.0,
                  //                     zoom: 14,
                  //                   ),
                  //                 ),
                  //               )
                  //               .then((value) =>
                  //                   Future.delayed(Duration(seconds: 2))
                  //                       .then((_) async {
                  //                     await controller.takeSnapshot().then((value) {
                  //                       // setState(() {
                  //                       //   _imageBytes = value;
                  //                       // });
                  //                       // reqController.data.value = value;
                  //                       // reqController.loading.value = false;
                  //                     });

                  //                     //  print(reqController.data.value);
                  //                   }));
                  //           //   controller.getVisibleRegion().then(
                  //           //       (bounds) => print("bounds: ${bounds.toString()}"));
                  //         },
                  //       );
                  //       // _mapController = controller;
                  //   },
                  // ),
                  //     ),
                  TextFormField(
                    onChanged: (v) {
                      // updateController.getcoordinateAddress(v);
                      // updateController.mapController.animateCamera(
                      //   CameraUpdate.newCameraPosition(
                      //     CameraPosition(
                      //       bearing: 270.0,
                      //       target: LatLng(updateController.mylatitude.value,
                      //           updateController.mylongitude.value),
                      //       tilt: 30.0,
                      //       zoom: 14,
                      //     ),
                      //   ),
                      // );
                    },
                    obscureText: false,
                    controller: controller.addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      suffix: Icon(Icons.location_on),
                    ),
                    validator: (value) =>
                        validateMinLength(string: value, length: 3),
                  ),
                  SizedBox(height: Defaults.paddingmiddle),
                  Obx(
                    () => Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: EdgeInsets.only(left: Defaults.paddingbig),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Defaults.paddingbig),
                          border: Border.all(color: Colors.grey[600])),
                      child: DropdownButton<String>(
                        isExpanded: true,

                        value: controller.bloodgroup.value.isEmpty
                            ? 'your blood group'
                            : controller.bloodgroup.value,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey[600],
                        ),
                        iconSize: 30, //this inicrease the size
                        elevation: 16,

                        style: TextStyle(color: Colors.grey[600]),
                        underline: Container(),
                        onChanged: (String newValue) {
                          controller.bloodgroup.value = newValue;
                          controller.selectedData = newValue;
                          controller.selectedstate = true;
                        },
                        items: controller.bloodgouplist
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(color: Colors.grey[600]),
                                textAlign: TextAlign.center),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: Defaults.paddingmiddle),
                  SizedBox(height: Defaults.paddingnormal),
                  Obx(() => controller.updateState.value
                      ? Container(
                          height: Defaults.paddingbig * 2,
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).backgroundColor,
                          ),
                        )
                      : Container()),
                  SizedBox(height: Defaults.paddingnormal),
                  CustomButton(
                    borderRadius: 15,
                    btnColor: Theme.of(context).backgroundColor,
                    label: 'Update',
                    labelColor: Colors.white,
                    onPressed: () async {
                      if (controller.formKey.currentState.validate()) {
                        if (controller.selectedstate &&
                            controller.selectedData != 'your blood group') {
                          if (!controller.updateState.value) {
                            controller.updateState.value = true;
                            bool body = await controller.updateProfile();
                            if (body) {
                              controller.updateState.value = false;
                              mcontroller.model.phoneNo =
                                  controller.poneController.text;

                              mcontroller.model.userAddress =
                                  controller.addressController.text;

                              mcontroller.model.username =
                                  controller.nameController.text;

                              mcontroller.model.bloodgroup =
                                  controller.bloodgroup.value;
                              mcontroller.backfromupdate.toggle();
                            }
                          } else {
                            Get.snackbar('Warning!',
                                'Blood group is not selected\n Please Select blood Group.',
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        } else
                          Get.snackbar('Warning!',
                              'Blood group is not selected\n Please Select blood Group.',
                              snackPosition: SnackPosition.BOTTOM);
                        // loginController.clearController();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
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
                          //   controller.getVisibleRegion().then(
                          //       (bounds) => print("bounds: ${bounds.toString()}"));
                        },
                      );
                      // _mapController = controller;
                    },
                  ),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 40,
                  child: TextButton(
                    onPressed: () async {
                      await mapController.takeSnapshot().then((value) {
                        setState(() {
                          _imageBytes = value;
                        });
                     
                        Get.back();
                      });
                      //  print(reqController.data.value);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        primary: Colors.white),
                    child: Text('Capture map'),
                  )),
              // Positioned(
              //   left: 20,
              //   top: 20,
              //   child: Container(
              //       width: SizeConfig.screenWidth - 100,
              //       child: TextFormField(
              //         decoration: InputDecoration(),
              //       )),
              // ),
            ],
          )
        : Image.memory(_imageBytes);
  }
}
