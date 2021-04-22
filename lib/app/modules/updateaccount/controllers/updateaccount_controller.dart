import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/account_repository.dart';
import 'package:get/get.dart';

class UpdateaccountController extends GetxController {
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController nameController = new TextEditingController();
  TextEditingController poneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

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

  void loading(UserModel model) {
    if (oneload) {
      nameController.text = model.username;
      poneController.text = model.phoneNo;
      addressController.text = model.userAddress;
      bloodgroup.value = model.bloodgroup;
      selectedData = model.bloodgroup;
      oneload = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> updateProfile() async {
    var id = FirebaseAuth.instance.currentUser.uid;
    bool cmmplete = false;
    if (id != null) {
      UserModel model = new UserModel(
          username: nameController.text,
          userAddress: addressController.text,
          latitude: 0,
          longitude: 0,
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
