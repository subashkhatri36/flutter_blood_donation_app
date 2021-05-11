import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/authentication_repositories.dart';
import 'package:flutter_blood_donation_app/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  ScrollController pageviewScroll = new PageController();
  RxInt currentpage = 0.obs;
  GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  var longitude = 27.0.obs;
  var latitude = 85.0.obs;
  AuthenticationRepo _authenticationRepo = new Authentication();

  //for Login
  //
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  //for register
  final signupformKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController remailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController rpasswordController = new TextEditingController();
  TextEditingController rconformController = new TextEditingController();
  RxString bloodgroup = ''.obs;
  List<String> bloodgouplist = [
    'your blood group',
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  RxBool loginProcess = false.obs;

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
    // try {
    print(emailController.text);
    print(passwordController.text);
    Either<String, String> userLogin = await _authenticationRepo.userLogin(
        emailController.text, passwordController.text);
    userLogin.fold(
        (l) => Get.snackbar('Error !', l, snackPosition: SnackPosition.BOTTOM),
        (r) {
      Get.off(HomeView(), binding: HomeBinding());
    });
    loginProcess.value = false;
  }

  void register() async {
    UserModel user = new UserModel(
        userId: '',
        username: nameController.text,
        userAddress: addressController.text,
        latitude: latitude.value,
        longitude: longitude.value,
        bloodgroup: bloodgroup.value,
        photoUrl: '',
        phoneNo: phoneController.text,
        email: remailController.text,
        onestar: 0,
        twostar: 0,
        threestar: 0,
        fourstar: 0,
        fivestar: 0,
        candonate: true,
        active: true);

    Either<String, String> userLog =
        await _authenticationRepo.userRegister(user, rpasswordController.text);
    userLog.fold((l) {
      print(l);
    }, (r) => Get.off(HomeView(), binding: HomeBinding()));
    loginProcess.value = false;
  }

  signout() async {
    await authResult.signOut();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageviewScroll.dispose();
    emailController.dispose();
    passwordController.dispose();
    rpasswordController.dispose();
    remailController.dispose();
    bloodgroup.value = '';
    nameController.dispose();
    phoneController.dispose();
    rconformController.dispose();
  }
}
