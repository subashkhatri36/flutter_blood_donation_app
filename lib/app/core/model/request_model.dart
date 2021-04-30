import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  String id;
  String name;
  String userid;
  String contactno;
  String bloodgroup;
  Timestamp timestamp;
  String city;
  String address;
  String detail;
  String photoUrl;
  String userphotoUrl;
  List likes = []; // = [];
  int comment;
  String status;
  RequestModel(
      {this.id,
      this.userid,
      this.name,
      this.bloodgroup,
      this.detail,
      this.address,
      this.timestamp,
      this.photoUrl,
      this.userphotoUrl,
      this.contactno,
      this.city = 'Kathmandu',
      this.status,
      this.likes,
      this.comment});

  RequestModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.bloodgroup = json['bloodgroup'];
    this.detail = json['detail'];
    this.address = json['address'];
    this.timestamp = Timestamp.now();
    this.userid = json['userid'];
    this.contactno = json['contactno'];
    this.likes = json['likes'];
    //this.likes=json['likes'];
  }
  RequestModel.fromDocumentSnapshot(DocumentSnapshot json) {
    this.id = json.id;
    this.userid = json.data()['userid'];
    this.contactno = json.data()['contactno'];
    this.name = json.data()['name'];
    this.bloodgroup = json.data()['bloodgroup'];
    this.detail = json.data()['detail'];
    this.address = json.data()['address'];
    this.timestamp = json.data()['timestamp'];
    this.photoUrl = json.data()['photoUrl'];
    this.userphotoUrl = json.data()['userPhotourl'];
    this.status = json.data()['status'] ?? 'sent';
    // List data = jsonDecode(json.data()['likes']).toList();
    // print(data.toString());
    this.likes = [];
    // data.forEach((element) {

    // })
    // this.likes = jsonDecode(json.data()['likes']) ?? [];
    this.comment = json.data()['comment'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['bloodgroup'] = this.bloodgroup;
    data['address'] = this.address;
    data['detail'] = this.detail;
    data['photoUrl'] = this.photoUrl;
    data['timestamp'] = Timestamp.now();
    data['userPhotourl'] = this.userphotoUrl;
    //data['likes'] = jsonEncode(this.likes);
    data['status'] = this.status;
    data['comment'] = 0;
    return data;
  }
}
