import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/account_repository.dart';
import 'package:get/get.dart';

class ViewallrequestController extends GetxController {
  RxBool loadingRequest = false.obs;
  AccountRepo _accountRepo = AccountRepositories();
  RxList<RequestModel> requestList;

  @override
  void onInit() {
    loadAllRequest();
    super.onInit();
  }

  loadAllRequest() async {
    loadingRequest.toggle();
    var id = FirebaseAuth.instance.currentUser.uid;
    if (id != null) {
      Either<String, List<RequestModel>> data =
          await _accountRepo.getAllUserRequest(id);
      data.fold((l) => Get.snackbar('Error !', l.toString()), (r) {
        requestList = r.toList().obs;
      });
    }
    loadingRequest.toggle();
  }

  deleteRequest(String reqId, RequestModel model) async {
    var id = FirebaseAuth.instance.currentUser.uid;
    if (id != null) {
      Either<String, String> data = await _accountRepo.deleteuserRequest(reqId);
      data.fold((l) => Get.snackbar('Error !', l.toString()), (r) {
        Get.snackbar('Successful', r.toString());
        requestList.remove(model);
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
