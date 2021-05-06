import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_blood_donation_app/app/core/model/donation_model.dart';

abstract class DonationRepo {
  Future<Either<String, String>> saveDonation(
      String userId, DonationModel donationModel);
  Future<Either<String, String>> deleteDonation(String userId, String docId);
  Future<Either<String, List<DonationModel>>> loadAllDonation(String userId);
}

class DonationRepositories implements DonationRepo {
  @override
  Future<Either<String, String>> deleteDonation(
      String userId, String docId) async {
    try {
      bool complete = false;
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('donation')
          .doc(docId)
          .delete()
          .whenComplete(() => complete = true);
      if (complete)
        return right('Delete Successfully.');
      else
        return left('Error while deleting');
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, List<DonationModel>>> loadAllDonation(
      String userId) async {
    try {
      bool complete = false;
      List<DonationModel> model = [];
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('donation')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          DonationModel donationg = DonationModel.fromMap(element.data());
          donationg.id = element.id;
          model.add(donationg);
        });
      }).whenComplete(() => complete = true);

      if (complete)
        return right(model);
      else
        return left('Error while deleting');
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, String>> saveDonation(
      String userId, DonationModel donationModel) async {
    try {
      bool complete = false;
      String id = '';
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('donation')
          .add(donationModel.toMap())
          .then((value) => id = value.id)
          .whenComplete(() => complete = true);
      if (complete)
        return right(id);
      else
        return left('Error while deleting');
    } catch (error) {
      return left(error.toString());
    }
  }
}
