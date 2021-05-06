import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/post_repo.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../home/controllers/home_controller.dart';

class RequestController extends GetxController {
  var loading = false.obs;
  var isplatelets = false.obs;
  var count = 0.obs;
  var formyself = false.obs;
  var mylocation = false.obs;
  var bloodgroup = 'A+'.obs;
  var userlocation = 'ranibari'.obs;
  var data = Uint8List(0).obs;
  GoogleMapController mapController;
  File imagep;
  var map = false.obs;
  var isimageSelected = false.obs;
  var imagePath = ''.obs;
  var selectedImageSize = ''.obs;
  captureImage() async {
    final imagefile = await mapController.takeSnapshot();
    data.value = imagefile;
  }

  //blood request controller
  final phoneController = TextEditingController()
    ..text = userController.myinfo.value.phoneNo;
  final locationController = TextEditingController();
  //..text = userController.myinfo.value.userAddress;
  final userAddressController = TextEditingController()
    ..text = userController.myinfo.value.userAddress;

  GlobalKey<FormState> requestformKey = GlobalKey<FormState>();
  Future<void> sendrequest() async {
    loading.value = true;
    RequestModel req = RequestModel(
        name: userController.myinfo.value.username,
        userid: userController.myinfo.value.userId,
        userphotoUrl: userController.myinfo.value.photoUrl,
        address: userAddressController.text,
        contactno: phoneController.text,
        bloodgroup: bloodgroup.value,
        bloodtype: isplatelets.value,
        status: 'waiting',
        hospitaldetail: locationController.text,
        photoUrl: base64Encode(data.value));

    //sending request
    try {
      await PostsRepo().sendRequest(req);

      // clearController();

      loading = false.obs;
    } on PlatformException catch (err) {
      Get.snackbar(err.code, err.message);
      // Handle err
    } catch (e) {
      Get.snackbar(e.code, e.message);
    }
  }

  clearController() {
    phoneController.clear();
    locationController.clear();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // requestformKey.dispose();
  }

  void increment() => count.value++;
}

final reqCont = Get.find<RequestController>();
