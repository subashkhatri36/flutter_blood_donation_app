import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/account_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class UpdateaccountController extends GetxController {
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController nameController = new TextEditingController();
  TextEditingController poneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  var mylatitude = 0.0.obs;
  var mylongitude = 0.0.obs;
  AccountRepo accountRepo = new AccountRepositories();

  RxString bloodgroup = ''.obs;
  String selectedData = '';
  bool selectedstate = false;
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
  RxBool updateState = false.obs;
  bool oneload = true;

  Future<void> loading(UserModel model) async {
    if (oneload) {
      List<Location> location =
          await getcoordinatefromAddress(model.userAddress);
      nameController.text = model.username;
      poneController.text = model.phoneNo;
      addressController.text = model.userAddress;
    //  bloodgroup.value = model.bloodgroup;
      selectedData = model.bloodgroup;
      mylatitude.value = location[0].latitude;
      mylongitude.value = location[0].longitude;
      oneload = false;
      print(location[0].latitude);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  //geocoding
  getcoordinatefromAddress(String address) async {
    List<Location> locations = await locationFromAddress("$address,kathmandu");

    return locations;
  }

  Future<bool> updateProfile() async {
    var id = FirebaseAuth.instance.currentUser.uid;
    bool cmmplete = false;
    if (id != null) {
      UserModel model = new UserModel(
          username: nameController.text,
          userAddress: addressController.text,
          latitude: mylatitude.value,
          longitude: mylongitude.value,
          bloodgroup: bloodgroup.value,
          phoneNo: poneController.text,
          email: 'email',
          active: true);
      Either<String, String> val = await accountRepo.updateUser(id, model);
      val.fold((l) => print(l), (r) {
        Get.snackbar('Information', 'Successfully Updated',
            snackPosition: SnackPosition.BOTTOM);
        cmmplete = true;
      });
    }
    return cmmplete;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
