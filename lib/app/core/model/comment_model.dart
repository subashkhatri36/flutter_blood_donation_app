
import 'package:cloud_firestore/cloud_firestore.dart';



class CommentModel {

  String postid;
  String userid;
 
  String comment;
Timestamp timestamp;
  

  CommentModel({
    this.postid,
   this.userid,
    this.comment,
    this.timestamp
  });


  CommentModel.fromJson(Map<String, dynamic> json){
      this.postid = json['postid'];
      this.userid = json['userid'];
      this.comment=json['comment'];
      this.timestamp=json['timestamp'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postid'] = this.postid;
    data['userid']=this.userid;
    data['comment']=this.comment;
    data['timestamp']=this.timestamp;
    return data;
  }
}