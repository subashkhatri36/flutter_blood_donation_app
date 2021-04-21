import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/account_repository.dart';
import 'package:flutter_blood_donation_app/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/login_view.dart';
import 'package:image_picker/image_picker.dart';

class AccountController extends GetxController {
  UserModel model;
  AccountRepo _accountRepo = new AccountRepositories();
  FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isImageUploading = false.obs;
  RxBool isImageNetwork = false.obs;
  RxBool loadigUserData = false.obs;

  RxString userImage = 'assets/images/blooddonation.png'.obs;
  File image;

  RxDouble average = 0.0.obs;
  RxDouble total = 0.0.obs;

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  getUserData() async {
    loadigUserData.toggle();

    var id = _auth.currentUser?.uid ?? '';
    if (id != null && id.isNotEmpty) {
      Either<String, UserModel> data = await _accountRepo.getUserData(id);
      data.fold((l) => print(l), (r) {
        model = r;
        if (r.phoneNo.isNotEmpty) {
          isImageNetwork.value = true;
          userImage.value = r.photoUrl;
        }

        calculateAverage();
      });
    } else {
      print('user is emapty');
    }
    loadigUserData.toggle();
  }

  calculateAverage() {
    if (model != null) {
      double first = (5 * model.fivestar +
              4 * model.fourstar +
              3 * model.threestar +
              2 * model.twostar +
              1 * model.onestar)
          .toDouble();
      double second = total.value = (model.fivestar +
              model.fourstar +
              model.threestar +
              model.twostar +
              model.onestar)
          .toDouble();

      double av = first / second;
      average = av.obs;
    }
  }

  double calculate(int value) {
    return (value / 100) / 5;
  }

  double showpercentage(int i) {
    switch (i) {
      case 1:
        return calculate(model.onestar);
        break;
      case 2:
        return calculate(model.twostar);
        break;
      case 3:
        return calculate(model.threestar);
        break;
      case 4:
        return calculate(model.fourstar);

        break;
      default:
        return calculate(model.fivestar);
        break;
    }
  }

  void signout() {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginView(), binding: LoginBinding());
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;

    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }

    if (pickedFile != null) {
      isImageUploading.value = true;

      // image.add(File(pickedFile.path));
      image = File(pickedFile.path).obs();
      final id = FirebaseAuth.instance.currentUser.uid;
      if (id != null) {
        Either<String, String> uploaded =
            await _accountRepo.uploadImage(image, id);
        uploaded.fold((l) {
          print(l);
        }, (r) {
          userImage.value = r;
          isImageNetwork.value = true;
        });
        isImageUploading.value = false;

        //_image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
      isImageUploading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
