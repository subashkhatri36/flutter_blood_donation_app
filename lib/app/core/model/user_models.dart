import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String photoUrl;
  String userId;
  final String username;
  final String userAddress;
  final double latitude;
  final double longitude;
  final String bloodgroup;
  final String phoneNo;
  final String email;
  final bool active;
  String password;
  final double average;
  final double onestar;
  final double twostar;
  final double threestar;
  final double fourstar;
  final double fivestar;
  final bool candonate;

  UserModel({
    this.average = 0.0,
    this.onestar = 0.0,
    this.twostar = 0.0,
    this.threestar = 0.0,
    this.fourstar = 0.0,
    this.fivestar = 0.0,
    this.candonate = true,
    this.userId,
    @required this.username,
    @required this.userAddress,
    @required this.latitude,
    @required this.longitude,
    @required this.bloodgroup,
    @required this.phoneNo,
    @required this.email,
    @required this.active,
    this.photoUrl,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'photoUrl': photoUrl,
      'userId': userId,
      'username': username,
      'userAddress': userAddress,
      'latitude': latitude,
      'longitude': longitude,
      'bloodgroup': bloodgroup,
      'phoneNo': phoneNo,
      'email': email,
      'active': active,
      'password': password,
      'average': average,
      'onestar': onestar,
      'twostar': twostar,
      'threestar': threestar,
      'fourstar': fourstar,
      'fivestar': fivestar,
      'candonate': candonate,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      photoUrl: map['photoUrl'],
      userId: map['userId'],
      username: map['username'],
      userAddress: map['userAddress'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      bloodgroup: map['bloodgroup'],
      phoneNo: map['phoneNo'],
      email: map['email'],
      active: map['active'],
      password: map['password'],
      average: map['average'],
      onestar: map['onestar'],
      twostar: map['twostar'],
      threestar: map['threestar'],
      fourstar: map['fourstar'],
      fivestar: map['fivestar'],
      candonate: map['candonate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.photoUrl == photoUrl &&
        other.userId == userId &&
        other.username == username &&
        other.userAddress == userAddress &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.bloodgroup == bloodgroup &&
        other.phoneNo == phoneNo &&
        other.email == email &&
        other.active == active &&
        other.password == password &&
        other.average == average &&
        other.onestar == onestar &&
        other.twostar == twostar &&
        other.threestar == threestar &&
        other.fourstar == fourstar &&
        other.fivestar == fivestar &&
        other.candonate == candonate;
  }

  @override
  int get hashCode {
    return photoUrl.hashCode ^
        userId.hashCode ^
        username.hashCode ^
        userAddress.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        bloodgroup.hashCode ^
        phoneNo.hashCode ^
        email.hashCode ^
        active.hashCode ^
        password.hashCode ^
        average.hashCode ^
        onestar.hashCode ^
        twostar.hashCode ^
        threestar.hashCode ^
        fourstar.hashCode ^
        fivestar.hashCode ^
        candonate.hashCode;
  }
}
