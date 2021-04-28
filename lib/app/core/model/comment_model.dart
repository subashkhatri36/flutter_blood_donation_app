
import 'package:cloud_firestore/cloud_firestore.dart';


// class CommentModel {
//   String postid;
//   String userid;
 
//   String comment;
// Timestamp timestamp;
  
//   CommentModel({
//     this.postid,
//    this.userid,
//     this.comment,
//     this.timestamp
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'postid': postid,
//       'userid': userid,
//     'timestamp':timestamp,
//       'comment': comment,
//     };
//   }

//   factory CommentModel.fromMap(Map<String, dynamic> map) {
//     return CommentModel(
//    postid: map['postid'],
//    userid: map['userid'],
//    timestamp: map['timestamp'],
//       comment: map['comment'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CommentModel.fromJson(String source) =>
//       CommentModel.fromMap(json.decode(source));

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is CommentModel &&
//         other.postid == postid &&
//         other.userid == userid &&
//         other.timestamp == timestamp &&
//         other.comment == comment;
//   }

//   @override
//   int get hashCode {
//     return postid.hashCode ^ userid.hashCode ^ timestamp.hashCode ^ comment.hashCode;
//   }
// }

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