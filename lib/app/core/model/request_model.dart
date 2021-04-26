import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  String id;
  String name;
  String bloodgroup;
  Timestamp timestamp;
  String city;
  String address;
  String detail;
  bool active;
  String photoUrl;
  String userphotoUrl;
  RequestModel(
      {this.id,
      this.name,
      this.bloodgroup,
      this.detail,
      this.address,
      this.active,
      this.timestamp,
      this.photoUrl,
      this.userphotoUrl,
      this.city = 'Kathmandu'});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestModel &&
        other.id == id &&
        other.name == name &&
        other.bloodgroup == bloodgroup &&
        other.timestamp == timestamp &&
        other.city == city &&
        other.address == address &&
        other.detail == detail &&
        other.active == active &&
        other.photoUrl == photoUrl &&
        other.userphotoUrl == userphotoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        bloodgroup.hashCode ^
        timestamp.hashCode ^
        city.hashCode ^
        address.hashCode ^
        detail.hashCode ^
        active.hashCode ^
        photoUrl.hashCode ^
        userphotoUrl.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bloodgroup': bloodgroup,
      'timestamp': timestamp,
      'city': city,
      'address': address,
      'detail': detail,
      'active': active,
      'photoUrl': photoUrl,
      'userphotoUrl': userphotoUrl,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'],
      name: map['name'],
      bloodgroup: map['bloodgroup'],
      timestamp: map['timestamp'],
      city: map['city'],
      address: map['address'],
      detail: map['detail'],
      active: map['active'],
      photoUrl: map['photoUrl'],
      userphotoUrl: map['userphotoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) =>
      RequestModel.fromMap(json.decode(source));
}
