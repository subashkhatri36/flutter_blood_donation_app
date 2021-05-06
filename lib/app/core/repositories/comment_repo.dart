import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/comment_model.dart';

class CommentRepo {
  final repo = firebaseFirestore.collection('comments');
  sendComment(CommentModel comm, int count) async {
    await repo.add(comm.toJson()).whenComplete(() {
      firebaseFirestore
          .collection('request')
          .doc(comm.postid)
          .update({"comment": count});
    });
  }

  // getCommentlength(String postid) async {
  //   var data = await repo.where('postid', isEqualTo: postid).get();
  //   return data.docs.length;
  // }

//get stream of comment
  getComment(String postid) {
    return repo
        .where('postid', isEqualTo: postid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<CommentModel> requests = [];
      query.docs.forEach((element) {
        requests.add(CommentModel.fromJson(element.data()));
      });
      requests.sort(
        (a, b) => a.timestamp.compareTo(b.timestamp),
      );
      requests = List.from(requests.reversed);
      return requests;
    });
  }
}

final commentRepo = CommentRepo();
