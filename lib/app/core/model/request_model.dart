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
  String hospitaldetail;
  String photoUrl;
  String userphotoUrl;
  bool bloodtype;
  int like;
  String status;

  int comment;

  RequestModel(
      {this.id,
      this.userid,
      this.name,
      this.bloodgroup,
      this.hospitaldetail,
      this.address,
      this.timestamp,
      this.bloodtype,
      this.photoUrl,
      this.userphotoUrl,
      this.status,
      this.contactno,
      this.city = 'Kathmandu',
      this.like = 0,
      this.comment = 0});

  RequestModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.bloodgroup = json['bloodgroup'];
    this.hospitaldetail = json['detail'];
    this.address = json['address'];
    this.timestamp = Timestamp.now();
    this.userid = json['userid'];
    this.contactno = json['contactno'];
  }
  RequestModel.fromDocumentSnapshot(DocumentSnapshot json) {
    this.id = json.id;
    this.userid = json.data()['userid'];
    this.contactno = json.data()['contactno'];
    this.name = json.data()['name'];
    this.bloodgroup = json.data()['bloodgroup'];
    this.hospitaldetail = json.data()['detail'];
    this.address = json.data()['address'];
    this.timestamp = json.data()['timestamp'];
    this.photoUrl = json.data()['photoUrl'];
    this.userphotoUrl = json.data()['userPhotourl'];
    this.like = json.data()['like'];
    this.comment = json.data()['comment'];
    this.bloodtype = json.data()['bloodtype'] ?? false;
    this.status = json.data()['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['bloodgroup'] = this.bloodgroup;
    data['address'] = this.address;
    data['detail'] = this.hospitaldetail;
    data['photoUrl'] = this.photoUrl;
    data['timestamp'] = Timestamp.now();
    data['like'] = this.like;
    data['bloodtype'] = this.bloodtype;
    data['status'] = this.status;
    data['comment'] = this.comment;
    data['contactno'] = this.contactno;
    data['userPhotourl'] = this.userphotoUrl;

    return data;
  }
}
