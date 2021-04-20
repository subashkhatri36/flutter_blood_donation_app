import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:geolocator/geolocator.dart';

abstract class AuthenticationRepo {
  Future<Either<String, String>> userLogin(String email, String password);
  Future<Either<String, String>> userRegister(UserModel model);
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
  Future<Either<String, String>> userRegister(UserModel model) async {
    try {
      _getCurrentLocation();
      double lat = 0.0;
      double logi = 0.0;
      if (_currentPosition.latitude != null) lat = _currentPosition.latitude;
      if (_currentPosition.longitude != null) logi = _currentPosition.longitude;

      String id = '';
      bool complete = false;
      UserCredential userreg = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: model.email, password: model.password);

      if (userreg != null) {
        Map<String, dynamic> userData = {
          'userId': id,
          'username': model.username,
          'userAddress': model.userAddress,
          'onestar': model.onestar,
          'twostar': model.twostar,
          'threestar': model.threestar,
          'fourstar': model.fourstar,
          'fivestar': model.fivestar,
          'average': model.average,
          'candonate': model.candonate,
          'latitude': lat,
          'longitute': logi,
          'bloodgroup': '',
          'phoneNo': model.phoneNo,
          'email': model.email,
          'password': model.password,
          'active': model.active
        };
        await FirebaseFirestore.instance
            .collection('User')
            .doc(userreg.user.uid)
            .set(userData)
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
        print(e);
      });
    } catch (error) {
      print('error on location');
    }
  }
}
