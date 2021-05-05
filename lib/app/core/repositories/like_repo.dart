import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_blood_donation_app/app/core/model/like.dart';

abstract class LikeRepo {
  Future<Either<String, List<LikeModel>>> getAllLikesNativeUser(String userId);
  Future<Either<String, String>> insertLike({
    String userId,
    String postId,
  });
  Future<Either<String, void>> deletelike(
      {String userId, String docId, String postId});
}

class LikeRepositiories implements LikeRepo {
  @override
  Future<Either<String, void>> deletelike(
      {String userId, String docId, String postId}) async {
    try {
      bool complete = false;

      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('Likes')
          .doc(docId)
          .delete()
          .whenComplete(() => complete = false);
      await FirebaseFirestore.instance
          .collection('request')
          .doc(postId)
          .update({'like': FieldValue.increment(-1)}).whenComplete(
              () => complete = true);

      if (complete)
        return right(null);
      else
        return left('Error while deleting likes');
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, List<LikeModel>>> getAllLikesNativeUser(
      String userId) async {
    try {
      bool complete = false;
      List<LikeModel> likes = [];
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('Likes')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          LikeModel lm = LikeModel.fromMap(element.data());
          lm.docId = element.id;
          likes.add(lm);
        });
      }).whenComplete(() => complete = true);

      if (complete)
        return right(likes);
      else
        return left('Error while deleting likes');
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, String>> insertLike(
      {String userId, String postId}) async {
    try {
      bool complete = false;
      String id = '';
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('Likes')
          .add({'postId': postId})
          .then((value) => id = value.id)
          .whenComplete(() => complete = false);
      await FirebaseFirestore.instance
          .collection('request')
          .doc(postId)
          .update({'like': FieldValue.increment(1)}).whenComplete(
              () => complete = true);

      if (complete)
        return right(id);
      else
        return left('Error while deleting likes');
    } catch (error) {
      return left(error.toString());
    }
  }
}
