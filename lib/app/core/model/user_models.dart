import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String photoUrl;
  String userId;
  String username;
  String userAddress;
  double latitude;
  double longitude;
  String bloodgroup;
  String phoneNo;
  String email;
  bool active;
  int onestar;
  int twostar;
  int threestar;
  int fourstar;
  int fivestar;
  bool candonate;
  String fcmtoken;
  String devicetoken;
  bool online;

  UserModel({
    this.onestar = 0,
    this.twostar = 0,
    this.threestar = 0,
    this.fourstar = 0,
    this.fivestar = 0,
    this.candonate = true,
    this.userId,
    this.username,
    this.userAddress,
    this.latitude,
    this.longitude,
    this.bloodgroup,
    this.phoneNo,
    this.email,
    this.active,
    this.photoUrl = '',
    this.fcmtoken,
    this.devicetoken,
    this.online,

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
      'devicetoken': devicetoken,
      'fcmtoken': fcmtoken,
      'online':online,
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
      devicetoken: map['devicetoken'],
      fcmtoken: map['fcmtoken'],
      online:map['online']
    );
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot map) {
    return UserModel(
      userId: map.id,
      username: map.data()['username'],
      userAddress: map.data()['userAddress'],
      latitude: map.data()['latitude'],
      longitude: map.data()['longitude'],
      bloodgroup: map.data()['bloodgroup'],
      phoneNo: map.data()['phoneNo'],
      email: map.data()['email'],
      active: map.data()['active'],
      photoUrl: map.data()['photoUrl'],
      onestar: map.data()['onestar'],
      twostar: map.data()['twostar'],
      threestar: map.data()['threestar'],
      fourstar: map.data()['fourstar'],
      fivestar: map.data()['fivestar'],
      devicetoken: map.data()['devicetoken'],
      fcmtoken: map.data()['fcmtoken'],
      online:map.data()['online'],
    );
  }
  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  
}
