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

class RequestController extends GetxController {
  var isSwitched = false.obs;
  var count = 0.obs;
  var formyself = false.obs;
  var mylocation = false.obs;
  var bloodgroup = 'A+'.obs;
  var userlocation = 'ranibari'.obs;
  var data = Uint8List(0).obs;
  GoogleMapController mapController;
  RxBool loading = false.obs;
  File imagep;

  var imagePath = ''.obs;
  var selectedImageSize = ''.obs;
  captureImage() async {
    final imagefile = await mapController.takeSnapshot();
    data.value = imagefile;
  }

  //blood request controller
  final detailController = TextEditingController();
  final locationController = TextEditingController()
    ..text = userController.myinfo.value.userAddress;
  final requestformKey = GlobalKey<FormState>();
  Future<void> sendrequest() async {
    loading.value = true;

    RequestModel req = RequestModel(
      name: userController.myinfo.value.username,
      address: mylocation.value
          ? locationController.text
          : userController.myinfo.value.userAddress,
      detail: detailController.text,
      bloodgroup: formyself.value
          ? bloodgroup.value
          : userController.myinfo.value.bloodgroup,
      photoUrl: base64Encode(data.value),
      active: true,
    );

    //sending request
    try {
      await PostsRepo().sendRequest(req);
      clearController();
      Get.offNamed("/home");
      loading = false.obs;
    } on PlatformException catch (err) {
      Get.snackbar(err.code, err.message);
      // Handle err
    } catch (e) {
      Get.snackbar('Error', e.message.toString());
    }
  }

  clearController() {
    detailController.clear();
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
