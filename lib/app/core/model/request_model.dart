import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  String id;
  String name;
  String bloodgroup;
  Timestamp timestamp;
  double latitude;
  double longitude;
  String city;
  String address;
  String detail;
  bool active;
  String photoUrl;

  RequestModel(
      {this.id,
      this.name,
      this.bloodgroup,
      this.detail,
      this.address,
      this.active,
      this.timestamp,
      this.photoUrl,
      this.city = 'Kathmandu'});

  RequestModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.bloodgroup = json['bloodgroup'];
    this.detail = json['detail'];
    this.address = json['address'];
    this.timestamp = Timestamp.now();
  }
  RequestModel.fromDocumentSnapshot(DocumentSnapshot json) {
    this.id = json.id;
    this.name = json.data()['name'];
    this.bloodgroup = json.data()['bloodgroup'];
    this.detail = json.data()['detail'];
    this.address = json.data()['address'];
    this.timestamp = json.data()['timestamp'];
    this.photoUrl = json.data()['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['bloodgroup'] = this.bloodgroup;
    data['address'] = this.address;
    data['detail'] = this.detail;
    data['active'] = this.active;
    data['photoUrl'] = this.photoUrl;

    return data;
  }
}
