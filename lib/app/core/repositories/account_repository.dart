import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';

abstract class AccountRepo {
  Future<Either<String, UserModel>> getUserData(String userId);
  Future<Either<String, String>> updateUser(String userId, UserModel userModel);
  Future<Either<String, String>> uploadImage(File path, String userId);
}

class AccountRepositories implements AccountRepo {
  final _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<Either<String, String>> uploadImage(File path, String userId) async {
    try {
      bool complete = false;
      var downloadUrl = '';
      var snapshot = _firebaseStorage.ref().child('profile/$userId');
      UploadTask uploadTask = snapshot.putFile(path);
      await uploadTask.whenComplete(() async {
        complete = true;
      });
      if (complete) {
        await snapshot.getDownloadURL().then((value) {
          downloadUrl = value;
          saved(value, userId);
        });
      }

      return right(downloadUrl);
    } catch (error) {
      return left(error);
    }
  }

  Future<bool> saved(String path, String userId) async {
    bool comp = false;
    Map<String, String> image = {"photoUrl": path};
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .update(image)
          .then((value) => comp = true);
    } catch (error) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .set(image)
          .then((value) => comp = true);
    }

    return comp;
  }

  @override
  Future<Either<String, UserModel>> getUserData(String userId) async {
    try {
      bool complete = false;
      UserModel userModel;
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .get()
          .then((value) {
        if (value.exists) {
          userModel = UserModel.fromMap(value.data());
        }
      }).whenComplete(() => complete = true);
      if (complete)
        return right(userModel);
      else
        return left('Something went wrong while fetching data');
    } catch (erro) {
      print(erro);
      return left('Error While Fetching User Data');
    }
  }

  @override
  Future<Either<String, String>> updateUser(
      String userId, UserModel userModel) async {
    Map<String, dynamic> updateData = {
      'username': userModel.username,
      'userAddress': userModel.userAddress,
      'phoneNo': userModel.phoneNo,
      'bloodgroup': userModel.bloodgroup,
    };
    try {
      bool complete = false;
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .update(updateData)
          .whenComplete(() => complete = true);
      if (complete) {
        return right('Successful');
      } else {
        return left('Something went wrong while updating');
      }
    } catch (error) {
      return left('Error while updating User Info');
    }
  }
}