import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

abstract class AuthenticationRepo {
  Future<Either<String, String>> userLogin(String email, String password);
  Future<Either<String, String>> userRegister(UserModel model, String password);
}

class Authentication implements AuthenticationRepo {
  Position _currentPosition;

  @override
  Future<Either<String, String>> userLogin(
      String email, String password) async {
    try {
      // _getCurrentLocation();

      bool complete = false;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => complete = true);

      if (complete) {
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
      _getCurrentLocation();
      double lat = 0.0;
      double logi = 0.0;
      print(_currentPosition.latitude);
      print(_currentPosition.longitude);
      if (_currentPosition.latitude != null) lat = _currentPosition.latitude;
      if (_currentPosition.longitude != null) logi = _currentPosition.longitude;

     // String id = '';
      bool complete = false;
      UserCredential userreg = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: model.email, password: password);

      if (userreg != null) {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(userreg.user.uid)
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

  _getCurrentLocation() {
    try {
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) => _currentPosition = position)
          .catchError((e) {
        Get.snackbar('Info', 'Please Trun On Your Location',
            snackPosition: SnackPosition.BOTTOM);
        print(e);
      });
    } catch (error) {
      print('error on location');
    }
  }
}
