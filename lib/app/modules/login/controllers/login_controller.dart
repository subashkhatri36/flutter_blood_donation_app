import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/authentication_repositories.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  ScrollController pageviewScroll = new PageController();
  RxInt currentpage = 0.obs;
  final loginformKey = GlobalKey<FormState>();

  AuthenticationRepo _authenticationRepo = new Authentication();

  //for Login
  //
  TextEditingController emailControllerd = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  //for register
  TextEditingController nameController = new TextEditingController();
  TextEditingController remailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController rpasswordController = new TextEditingController();
  TextEditingController rconformController = new TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  jumppage(BuildContext context) {
    if (currentpage.value == 0) {
      pageviewScroll.jumpTo(0.0);
    } else {
      pageviewScroll.animateTo(MediaQuery.of(context).size.width,
          duration: new Duration(seconds: 0), curve: Curves.ease);
    }
  }

  void login() async {
    Either<String, String> userLog = await _authenticationRepo.userLogin(
        emailControllerd.text, passwordController.text);
    userLog.fold((l) {
      print(l);
    }, (r) => Get.off(HomeView()));
  }

  void register() async {
    UserModel user = new UserModel(
        userId: '',
        username: nameController.text,
        userAddress: '',
        latitude: 0,
        longitude: 0,
        bloodgroup: '',
        phoneNo: phoneController.text,
        email: remailController.text,
        active: true);

    Either<String, String> userLog =
        await _authenticationRepo.userRegister(user);
    userLog.fold((l) {
      print(l);
    }, (r) => Get.off(HomeView()));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageviewScroll.dispose();
    emailControllerd.dispose();
    passwordController.dispose();
    nameController.dispose();
    remailController.dispose();
    phoneController.dispose();
    rpasswordController.dispose();
    rconformController.dispose();
  }
}
