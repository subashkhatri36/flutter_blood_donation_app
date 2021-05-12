import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/account_repository.dart';
import 'package:flutter_blood_donation_app/app/core/services/storage_service/get_storage.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UpdateaccountController extends GetxController {
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController nameController = new TextEditingController();
  TextEditingController poneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  var mylatitude = 0.0.obs;
  var mylongitude = 0.0.obs;
  AccountRepo accountRepo = new AccountRepositories();
  GoogleMapController mapController;
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
    getcoordinateAddress(userController.myinfo.value.userAddress);
  }

  getcoordinateAddress(String address) async {
    List<Location> locations = await locationFromAddress("$address,kathmandu");
    mylatitude.value = locations[0].latitude;
    mylongitude.value = locations[0].longitude;
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
        userController.myinfo.value = model;
        localStorage.write('myinfo', userController.myinfo.value.toJson());
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
