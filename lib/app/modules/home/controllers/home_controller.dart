import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/users_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var selectedIndex = 0.obs;
  final count = 0.obs;
  var mylatitude = 0.0.obs;
  var mylongitude = 0.0.obs;
  var myinfo = UserModel().obs;
  var userlist = List<UserModel>.empty(growable: true);
  @override
  void onInit() {
    super.onInit();
    getPosition();
    getUsers();
    getmyinfo();
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
    userlist = users;
    //print(userlist.length);
  }

  getPosition() async {
    await Geolocator.getCurrentPosition().then((location) {
      mylatitude.value = location.latitude;
      mylongitude.value = location.longitude;
    });
  }
}

final userController = Get.find<HomeController>();
