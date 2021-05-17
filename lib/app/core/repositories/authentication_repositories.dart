import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';

abstract class AuthenticationRepo {
  Future<Either<String, String>> userLogin(String email, String password);
  Future<Either<String, String>> userRegister(UserModel model, String password);
  Future<void> updateUserInfo(
      {@required String userId,
      @required String fieldname,
      @required dynamic value});
}

class Authentication implements AuthenticationRepo {
  //Position _currentPosition;

  @override
  Future<Either<String, String>> userLogin(
      String email, String password) async {
    try {
      // _getCurrentLocation();

      bool complete = false;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => complete = true);
      String fcmtoken = await FirebaseMessaging.instance.getToken();
      if (complete) {
        updateUserInfo(
            userId: FirebaseAuth.instance.currentUser.uid,
            fieldname: 'online',
            value: true);
        updateUserInfo(
            userId: FirebaseAuth.instance.currentUser.uid,
            fieldname: 'fcmtoken',
            value: fcmtoken);
        return right('Successfully Logged In');
      } else {
        return left('Something went wrong while Log in');
      }
    } catch (error) {
      return left('Error Occured while logged in');
    }
  }

  @override
  Future<Either<String, String>> userRegister(
      UserModel model, String password) async {
    try {
      // _getCurrentLocation();
      double lat = 0.0;
      double logi = 0.0;

      // if (_currentPosition.latitude != null) lat = _currentPosition.latitude;
      // if (_currentPosition.longitude != null) logi = _currentPosition.longitude;

      model.latitude = lat;
      model.longitude = logi;
      String fcmtoken = await FirebaseMessaging.instance.getToken();

      // String id = '';
      bool complete = false;
      //  bool rcompete = false;
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: model.email, password: password)
          .whenComplete(() => null);

      if (user != null) {
        model.fcmtoken = fcmtoken;
        model.online = true;
        await FirebaseFirestore.instance
            .collection('User')
            .doc(user.user.uid)
            .set(model.toMap())
            .whenComplete(() => complete = true);
      }

      if (complete) {
        return right('Successfully Register ');
      } else {
        return left('Something went wrong while Register');
      }
    } catch (error) {
      return left('Error Occured while Registering User');
    }
  }

  // _getCurrentLocation() {
  //   try {
  //     Geolocator.getCurrentPosition(
  //             desiredAccuracy: LocationAccuracy.best,
  //             forceAndroidLocationManager: true)
  //         .then((Position position) => _currentPosition = position)
  //         .catchError((e) {
  //       // print(e);
  //     });
  //   } catch (error) {
  //     Get.snackbar('Info', 'Please Trun On Your Location',
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }
  @override
  Future<void> updateUserInfo(
      {String userId, String fieldname, dynamic value}) async {
    await FirebaseFirestore.instance.collection('User').doc(userId).update(
        {fieldname: value}).whenComplete(() => print('Completed update.'));
  }
}
