import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/post_repo.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/users_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var connectionStatus = 0.obs;
  final Connectivity _connectivity = Connectivity();
  var selectedIndex = 0.obs;
  var loading = false.obs;
  var mapview = false.obs;
  final count = 0.obs;
  var mylatitude = 0.0.obs;
  var mylongitude = 0.0.obs;
  var myinfo = UserModel().obs;
  var userlist = List<UserModel>.empty(growable: true).obs;
  var requestData = List<RequestModel>.empty(growable: true).obs;
  var userlistshown = false.obs;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      Get.snackbar(e.code, e.message);
    } catch (e) {
      print(e.toString());
    }
    return _updateConnectionState(result);
  }

  void _updateConnectionState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;

        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
        Get.snackbar("Network Error", "Failed to connect ot network");
    }
  }

  @override
  void onInit() {
    super.onInit();
    userlistshown = true.obs;

    getPosition();
    getUsers();

    getmyinfo();
    streamRequest();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  getmyinfo() async {
    myinfo.value = await userRepo.getmyinfo();
  }

  getUsers() async {
    List<UserModel> users = await userRepo.getuser();
    // print(users.length);
    userlist = users.obs;
  }

  getUserByUserid(String userid) {
    List<UserModel> user = [];
    userlist.toList().forEach((element) {
      if (element.userId == userid) ;
      user.add(element);
    });
    return user[0];
  }

  getPosition() async {
    await Geolocator.getCurrentPosition().then((location) {
      mylatitude.value = location.latitude;
      mylongitude.value = location.longitude;
    });
  }

  streamRequest() async {
    loading.value = true;

    requestData.bindStream(postRepo.getRequest());
    loading.value = false;
  }

  //signout
  signout() async {
    await auth.signOut();
    Get.offNamed('/login');
  }
}

final userController = Get.find<HomeController>();
