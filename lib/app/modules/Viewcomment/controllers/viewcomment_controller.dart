import 'package:dartz/dartz.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/account_repository.dart';
import 'package:get/get.dart';

class ViewcommentController extends GetxController {
  AccountRepo _accountRepo = new AccountRepositories();

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> deletingComment(String docId) async {
    bool value = false;
    Either<bool, bool> dele = await _accountRepo.deleteComment(docId);
    dele.fold((l) => value = l, (r) => value = r);
    return value;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
