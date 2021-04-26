import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  var isSwitched = false.obs;
  var count = 0.obs;
  var formyself = false.obs;
  var mylocation = false.obs;
  var bloodgroup = 'A+'.obs;
  RxString imagePath = ''.obs;
  Uint8List list;
  //
  //blood request controller
  TextEditingController detailController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  final requestformKey = GlobalKey<FormState>();

  void sendrequest() {
    RequestModel req = RequestModel(
        name: 'hh',
        address: locationController.text,
        detail: detailController.text);
    // print(req.toJson());
    try {
      firebaseFirestore.collection('request').add(req.toJson());
    } on PlatformException catch (err) {
      Get.snackbar(err.code, err.message);
      // Handle err
    } catch (e) {
      Get.snackbar(e.code, e.message);
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
  void onClose() {}
  void increment() => count.value++;
}
