import 'package:flutter_blood_donation_app/app/constant/const.dart';

import 'package:flutter_blood_donation_app/app/core/model/like.dart';

class LikeRepo {
  final repo = firebaseFirestore.collection('like');
  sendlike(LikeModel comm) async {
    // print(comm.toJson().toString());
    await repo.add(comm.toJson()).whenComplete(() {
      print('like send');
    }).catchError((e) {
      print(e.toString());
    });
  }

//get stream of like
  getlikes(String postid) {
    List<LikeModel> likes = [];
    repo.where('postid', isEqualTo: postid).snapshots().map((event) {
      event.docs.forEach((element) {
        print(element.data()['postid']);
        likes.add(LikeModel.fromJson(element.data()));
      });
    });

    return likes;
    //});
  }
}

final likeRepo = LikeRepo();
