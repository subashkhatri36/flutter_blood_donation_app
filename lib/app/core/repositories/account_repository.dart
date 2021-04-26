import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blood_donation_app/app/core/model/comment_model.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';

import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';

abstract class AccountRepo {
  Future<Either<String, UserModel>> getUserData(String userId);
  Future<Either<bool, bool>> deleteComment(String docId);
  Future<Either<String, List<CommentModel>>> getUserComment(String userId);
  Future<Either<String, String>> updateUser(String userId, UserModel userModel);
  Future<Either<String, String>> uploadImage(File path, String userId);
  Future<Either<String, RequestModel>> getCurrentRequest(String userId);
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
      'latitude': userModel.latitude,
      'longitude': userModel.longitude
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

  @override
  Future<Either<String, List<CommentModel>>> getUserComment(
      String userId) async {
    try {
      bool complete = false;
      List<CommentModel> modelList = [];
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('comment')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          modelList.add(CommentModel(
            id: element.id,
            name: element['name'],
            photo: element['photo'],
            comment: element['comment'],
          ));
        });
      }).whenComplete(() => complete = true);
      if (complete) {
        return right(modelList);
      } else {
        return left('Something went Wrong while getting data');
      }
    } catch (error) {
      return left('Sorry Error Occured while geting comment.');
    }
  }

  @override
  Future<Either<bool, bool>> deleteComment(String docId) async {
    try {
      bool complete = false;
      await FirebaseFirestore.instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('comment')
          .doc(docId)
          .delete()
          .whenComplete(() => complete = true);
      if (complete) {
        return right(true);
      } else {
        return left(false);
      }
    } catch (error) {
      return left(false);
    }
  }

  @override
  Future<Either<String, RequestModel>> getCurrentRequest(String userId) async {
    try {
      bool complete = false;
      RequestModel rmodel;
      await FirebaseFirestore.instance
          .collection('request')
          .where('id', isEqualTo: userId)
          .where('active', isEqualTo: true)
          .limit(1)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          rmodel = RequestModel.fromMap(element.data());
          print('from data here');
        });
      }).whenComplete(() => complete = true);
      if (complete) {
        return right(rmodel);
      } else {
        return left('Some Things went fetching user info of request.');
      }
    } catch (error) {
      return left(error.toString());
    }
  }
}
