import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  int id;
  String name;
  String bloodgroup;
  Timestamp timestamp;
  String location;
  String city;
  String address;
  String detail;
  RequestModel(
      {this.id, this.name, this.bloodgroup, this.detail, this.address});

  RequestModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.bloodgroup = json['bloodgroup'];
    this.detail = json['detail'];
    this.address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['name'] = this.name;
    data['name'] = this.name;
    data['bloodgroup'] = this.bloodgroup;
    data['address'] = this.address;
    data['detail'] = this.detail;
    return data;
  }
}
