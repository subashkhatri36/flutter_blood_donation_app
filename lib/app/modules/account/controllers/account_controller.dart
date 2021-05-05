import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/core/model/review_model.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/post_repo.dart';
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
  RxBool backfromupdate = false.obs;

  RxBool isImageUploading = false.obs;
  RxBool isImageNetwork = false.obs;
  RxBool loadigUserData = false.obs;

  RxString userImage = 'assets/images/blooddonation.png'.obs;
  File image;
  RxList commentList;
  RxList<ReviewModel> reviewList;
  RxList<RequestModel> myrequestList =
      List<RequestModel>.empty(growable: true).obs;
  RxBool loadComment = false.obs;

  RxDouble average = 0.0.obs;
  RxDouble total = 0.0.obs;

  RxBool requestSendOn = false.obs;

  RequestModel currentRequest;

  @override
  void onInit() {
    getUserData();
    getMyRequest();
    //getCurrentRequest();
    super.onInit();
  }

  loadingComment() async {
    loadComment.toggle();
    List<ReviewModel> model = [];
    var id = FirebaseAuth.instance.currentUser.uid;
    if (id != null) {
      Either<String, List<ReviewModel>> data =
          await _accountRepo.getUserComment(id);
      data.fold((l) => print(l), (r) {
        model = r.toList();
        reviewList = model.obs;
      });
    }
    loadComment.toggle();
  }

  deleteRequest() async {
    if (requestSendOn.value && currentRequest != null) {
      Either<String, String> val =
          await _accountRepo.deleteuserRequest(currentRequest.id);
      val.fold((l) => Get.snackbar('Error', l.toString()), (r) {
        Get.snackbar('Info', r.toString());
        requestSendOn.value = false;
        currentRequest = null;
       getCurrentRequest();
      });
    }
  }

  getMyRequest() {
     myrequestList.bindStream(postRepo.mybloodrequest());
 
  }

  getCurrentRequest() async {
    var id = FirebaseAuth.instance.currentUser.uid;
    if (id != null) {
      print('data is not null');
      Either<String, RequestModel> userRequest =
          await _accountRepo.getCurrentRequest(id);

      userRequest.fold((l) => Get.snackbar('Error', l.toString()), (r) {
        currentRequest = r;
        requestSendOn.value = true;
      });
    } else {
      print('uid is null');
    }
  }

  Future<bool> getDelete(String docId) async {
    bool value = false;
    Either<bool, bool> dele = await _accountRepo.deleteUserComment(docId);
    dele.fold((l) => value = l, (r) => value = r);
    return value;
  }

  getUserData() async {
    loadigUserData.toggle();

    var id = _auth.currentUser?.uid ?? '';
    if (id != null && id.isNotEmpty) {
      Either<String, UserModel> data = await _accountRepo.getUserData(id);
      data.fold((l) => print(l), (r) {
        model = r;
        if (r.photoUrl.isNotEmpty) {
          isImageNetwork.value = true;
          userImage.value = r.photoUrl;
          loadingComment();
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
      if (second < 1) av = 0.0;
      average = av.obs;
    }
  }

  double calculate(int value) {
    if (total.value > 0)
      return value / total.value;
    else
      return 0.0;
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

final accountController = Get.put(AccountController());
