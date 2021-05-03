import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/custommap_controller.dart';

class CustommapView extends GetView<CustommapController> {
  final List<Widget> widget = [
    GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          zoom: 16.0,
          target: LatLng(userController.mylatitude.value,
              userController.mylongitude.value)),
      myLocationEnabled: true,
      onTap: (pos) {},
      // myLocationButtonEnabled: true,
      markers: Set.from([]),
      onMapCreated: (GoogleMapController controller) {
        // addMarker();

        // controller.animateCamera(CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //         zoom: 16.0,
        //         target: LatLng(userController.mylatitude.value,
        //             userController.mylongitude.value))));
      },
    )
  ];
  @override
  Widget build(BuildContext context) {
    print(true);
    return IndexedStack(
      index: 0,
      children: widget,
    );
  }
}
