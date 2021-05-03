import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blood_donation_app/app/core/model/review_model.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/account_repository.dart';
import 'package:get/get.dart';

class ViewAllReviewsController extends GetxController {
  AccountRepo _accountRepo = new AccountRepositories();
  RxBool isdeleteing = false.obs;
  RxBool isloading = false.obs;
  RxList<ReviewModel> reviewModelList;
  @override
  void onInit() {
    super.onInit();
    getCurrentRequest();
  }

  getCurrentRequest() async {
    isloading.toggle();
    List<ReviewModel> model = [];
    var id = FirebaseAuth.instance.currentUser.uid;
    if (id != null) {
      Either<String, List<ReviewModel>> userRequest =
          await _accountRepo.getUserComment(id);

      userRequest.fold((l) => Get.snackbar('Error', l.toString()), (r) {
        model = r.toList();
        reviewModelList = model.obs;
      });
    } else {
      print('uid is null');
    }
    isloading.toggle();
  }

  Future<bool> deletingComment(String docId, ReviewModel model) async {
    isdeleteing.toggle();
    if (FirebaseAuth.instance.currentUser.uid != null) {
      Either<bool, bool> dele = await _accountRepo.deleteUserComment(docId);
      dele.fold((l) {
        Get.snackbar('Error !', 'Error While Deleteing reviews');
        return false;
      }, (r) {
        Get.snackbar('Info', 'Successfully Deleted');
        reviewModelList.remove(model);
        return true;
      });
    }
    isdeleteing.toggle();
    return false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
