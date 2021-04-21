import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final List<int> rating;
  //final List<UserModel> usersRated;
  String password;

  UserModel(
      {this.userId,
      @required this.username,
      @required this.userAddress,
      @required this.latitude,
      @required this.longitude,
      @required this.bloodgroup,
      @required this.phoneNo,
      @required this.email,
      @required this.active,
      this.rating,
      this.photoUrl});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.username == username &&
        other.userAddress == userAddress &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.bloodgroup == bloodgroup &&
        other.phoneNo == phoneNo &&
        other.email == email &&
        other.password == password &&
        other.active == active;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        username.hashCode ^
        userAddress.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        bloodgroup.hashCode ^
        phoneNo.hashCode ^
        email.hashCode ^
        password.hashCode ^
        active.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'userAddress': userAddress,
      'latitude': latitude,
      'longitute': longitude,
      'bloodgroup': bloodgroup,
      'phoneNo': phoneNo,
      'email': email,
      'password': password,
      'active': active,
      'photoUrl': photoUrl
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      username: map['username'],
      userAddress: map['userAddress'],
      latitude: map['latitude'],
      longitude: map['longitute'],
      bloodgroup: map['bloodgroup'],
      phoneNo: map['phoneNo'],
      email: map['email'],
      active: map['active'],
      photoUrl: map['photoUrl'],
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
}
