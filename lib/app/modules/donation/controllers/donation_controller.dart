import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blood_donation_app/app/core/model/donation_model.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/donation_repositiories.dart';
import 'package:get/get.dart';

class DonationController extends GetxController {
  DonationRepo _donationRepo = new DonationRepositories();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController dateController = new TextEditingController();
  TextEditingController personController = new TextEditingController();
  TextEditingController detailsController = new TextEditingController();
  Rx<DonationModel> donationmodel;
  RxBool isloading = false.obs;
  RxString bloodgroup = ''.obs;
  RxString note = ''.obs;
  RxList<DonationModel> donationList=List<DonationModel>.empty(growable: true).obs;
  RxBool showdonartotal = false.obs;
  RxInt totalDonation = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllDonataion();
  }

  countDocumentDonation(String userId) async {
    totalDonation.value = await _donationRepo.countDocumentation(userId);
  }

  loadAllDonataion() async {
    isloading.toggle();
    var id = FirebaseAuth.instance.currentUser.uid;
    List<DonationModel> model = [];
    if (id != null) {
      Either<String, List<DonationModel>> data =
          await _donationRepo.loadAllDonation(id);
      data.fold((l) => print(l.toString()), (r) {
        model = r.toList();
        donationList = model.obs;
        checklastDonation();
      });
    }
    isloading.toggle();
    print(isloading.value);
  }

  checklastDonation() {
    donationList.forEach((element) {
      donationmodel = element.obs;
    });
  }

  saveDonation() async {
    var id = FirebaseAuth.instance.currentUser.uid;
    if (id != null) {
      DonationModel model = new DonationModel(
          date: dateController.text,
          person: personController.text,
          bloodtype: bloodgroup.value,
          details: note.value);
      Either<String, String> save = await _donationRepo.saveDonation(id, model);
      save.fold((l) => Get.snackbar('Error', l.toString()), (r) {
        model.id = r;
        donationmodel = model.obs;
        donationList.add(model);
        Get.back();
        Get.snackbar('Info', 'Save Post Successfully');
      });
    }
  }

  deleteDonation(DonationModel model) async {
    isloading.toggle();
    var id = FirebaseAuth.instance.currentUser.uid;
    if (id != null) {
      Either<String, String> save =
          await _donationRepo.deleteDonation(id, model.id);
      save.fold((l) => Get.snackbar('Error', l.toString()), (r) {
        donationList.remove(model);
        checklastDonation();
        Get.snackbar('Info', 'Deleted Post Successfully');
      });
    }
    isloading.toggle();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
