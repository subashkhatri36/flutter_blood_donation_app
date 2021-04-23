
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/post_repo.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestController extends GetxController {
  var loading = false.obs;
  var isSwitched = false.obs;
  var count = 0.obs;
  var formyself = false.obs;
  var mylocation = false.obs;
  var bloodgroup = 'A+'.obs;
  var userlocation = 'ranibari'.obs;
  var data = Uint8List(8).obs;
  GoogleMapController mapController;
  File imagep;
  Uint8List list;
  var imagePath = ''.obs;
  var selectedImageSize = ''.obs;

  captureImage() async {
    final imagefile = await mapController.takeSnapshot();
    //
    //       await screenshotController.capture().catchError((onError) {
    //     print(onError);
    //   });
    //   //print(imagefile);
    //   imagep = File.fromRawPath(imagefile);
    //   // data.value = image;
    //   imagePath.value = imagep.path;
    list = imagefile;
    //   //Share.shareFiles([imagep.path]);
  }

  //
  //blood request controller
  TextEditingController detailController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  final requestformKey = GlobalKey<FormState>();
  Future<void> sendrequest() async {
    loading.value = true;
    RequestModel req = RequestModel(
        name: auth.currentUser.displayName ?? 'SomeUser',
        address:
            mylocation.value ? locationController.text : userlocation.value,
        detail: detailController.text,
        bloodgroup: bloodgroup.value);
    //sending request
    try {
      await PostsRepo().sendRequest(req);
      loading = false.obs;
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

final reqCont = Get.find<RequestController>();
