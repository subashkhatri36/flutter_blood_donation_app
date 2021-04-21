
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/authentication_repositories.dart';
import 'package:flutter_blood_donation_app/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  ScrollController pageviewScroll = new PageController();
  RxInt currentpage = 0.obs;
  final loginformKey = GlobalKey<FormState>();

  AuthenticationRepo _authenticationRepo = new Authentication();

  //for Login
  //
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  //for register
  final signupformKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  //TextEditingController remailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  // TextEditingController rpasswordController = new TextEditingController();
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
    try {
      print(emailController.text);
      print(passwordController.text);
      UserCredential usercred = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (usercred.user == null)
        Get.snackbar('Error ', 'signing in');
      else
        Get.to(HomeView(), binding: HomeBinding());
    } on PlatformException catch (err) {
      Get.snackbar(err.code, err.message);
      // Handle err
    } catch (e) {
      Get.snackbar(e.code, e.message);
    }
  }

  void register() async {
    try {
      print(emailController.text);
      print(passwordController.text);
      UserCredential usercred = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (usercred.user == null)
        Get.snackbar('Error ', 'signing in');
      else {
        Map<String, dynamic> userData = {
          'userId': usercred.user.uid,
          'username': nameController.text,
          'userAddress': addressController.text,
          'latitude': '',
          'longitute': '',
          'bloodgroup': 'AB+',
          'phoneNo': phoneController.text,
          'email': emailController.text,
          'active': true,
        };
       await firebaseFirestore.collection('Users').doc(usercred.user.uid).set(userData);
        //add(userData).whenComplete(
            // () =>
            //     Get.snackbar('Completed Signup', 'User register successfully'));
        Get.to(HomeView(), binding: HomeBinding());
      }
    } on PlatformException catch (err) {
      Get.snackbar(err.code, err.message);
      // Handle err
    } catch (e) {
      Get.snackbar(e.code, e.message);
    }
    // UserModel user = new UserModel(
    //     userId: '',
    //     username: nameController.text,
    //     userAddress: '',
    //     latitude: 0,
    //     longitude: 0,
    //     bloodgroup: '',
    //     phoneNo: phoneController.text,
    //     email: emailController.text,
    //     active: true);

    // Either<String, String> userLog =
    //     await _authenticationRepo.userRegister(user);
    // userLog.fold((l) {
    //   print(l);
    // }, (r) => Get.off(HomeView()));
  }

  clearController() {
    emailController.clear();
    passwordController.clear();
    rconformController.clear();
    phoneController.clear();
    nameController.clear();
    emailController.clear();
    addressController.clear();
  }

  signout() async {
    await auth.signOut();
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
    nameController.dispose();

    phoneController.dispose();

    rconformController.dispose();
  }
}
