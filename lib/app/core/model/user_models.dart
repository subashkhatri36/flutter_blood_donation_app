import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  String photoUrl;
  String userId;
  String username;
  String userAddress;
  final double latitude;
  final double longitude;
  String bloodgroup;
  String phoneNo;
  final String email;
  final bool active;
  final int onestar;
  final int twostar;
  final int threestar;
  final int fourstar;
  final int fivestar;
  final bool candonate;

  UserModel({
    this.onestar = 0,
    this.twostar = 0,
    this.threestar = 0,
    this.fourstar = 0,
    this.fivestar = 0,
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
    this.photoUrl = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'photoUrl': photoUrl,
      'username': username,
      'userAddress': userAddress,
      'latitude': latitude,
      'longitude': longitude,
      'bloodgroup': bloodgroup,
      'phoneNo': phoneNo,
      'email': email,
      'active': active,
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
      username: map['username'],
      userAddress: map['userAddress'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      bloodgroup: map['bloodgroup'],
      phoneNo: map['phoneNo'],
      email: map['email'],
      active: map['active'],
      onestar: map['onestar'],
      twostar: map['twostar'],
      threestar: map['threestar'],
      fourstar: map['fourstar'],
      fivestar: map['fivestar'],
      candonate: map['candonate'],
    );
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot map) {
    return UserModel(
      userId: map.id,
      username: map.data()['username'],
      userAddress: map.data()['userAddress'],
      latitude: map.data()['latitude'],
      longitude: map.data()['longitute'],
      bloodgroup: map.data()['bloodgroup'],
      phoneNo: map.data()['phoneNo'],
      email: map.data()['email'],
      active: map.data()['active'],
      photoUrl: map.data()['photoUrl'],
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
        onestar.hashCode ^
        twostar.hashCode ^
        threestar.hashCode ^
        fourstar.hashCode ^
        fivestar.hashCode ^
        candonate.hashCode;
  }
}
