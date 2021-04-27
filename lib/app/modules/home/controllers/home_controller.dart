import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/post_repo.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/users_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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
  @override
  void onInit() {
    super.onInit();
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
      // print(element);
      print(userid);
      if (element.userId == userid) print(element.username);
      user.add(element);
      // element.toString();
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
}

final userController = Get.find<HomeController>();
