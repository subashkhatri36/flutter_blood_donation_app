import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_rating_model.dart';

abstract class RatingRepo {
  Future<Either<String, List<UserRatingModel>>> loadingUserRating(
      String userId);
  Future<Either<String, String>> insertrating(
      String userId, String id, int rate);
  Future<Either<String, String>> updateRating(String id, String docId, int rate,
      {UserModel usermodel, int prevalue});
}

class RatingRepositiories implements RatingRepo {
  @override
  Future<Either<String, String>> insertrating(
      String userId, String id, int rate) async {
    try {
      bool complete = false;
      UserRatingModel userRatingModel =
          new UserRatingModel(userId: id, star: rate);
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('rating')
          .add(userRatingModel.toMap())
          .whenComplete(() => complete = true);
      if (complete) {
        return right('Successfully rateded');
      } else {
        return left('Error while inserting data');
      }
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, List<UserRatingModel>>> loadingUserRating(
      String userId) async {
    try {
      bool complete = false;
      List<UserRatingModel> ratingmodel = [];
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('rating')
          .get()
          .then((value) => value.docs.forEach((element) {
                UserRatingModel rate = UserRatingModel.fromMap(element.data());
                rate.docId = element.id;
                ratingmodel.add(rate);
              }))
          .whenComplete(() => complete = true);
      if (complete) {
        return right(ratingmodel);
      } else {
        return left('Error while getting data');
      }
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, String>> updateRating(String id, String docId, int rate,
      {UserModel usermodel, int prevalue}) async {
    try {
      bool complete = false;
      await FirebaseFirestore.instance
          .collection('User')
          .doc(id)
          .collection('rating')
          .doc(docId)
          .update({'star': rate}).whenComplete(() => complete = true);
      if (complete) {
        complete = false;
        await FirebaseFirestore.instance
            .collection('User')
            .doc(usermodel.userId)
            .update({
          convertoString(rate): FieldValue.increment(1)
        }).whenComplete(() => complete = true);

        await FirebaseFirestore.instance
            .collection('User')
            .doc(usermodel.userId)
            .update({
          convertoString(prevalue): FieldValue.increment(-1)
        }).whenComplete(() => complete = true);

        return right('Successfully Updated Rating');
      } else {
        return left('Error while updating data');
      }
    } catch (error) {
      return left(error.toString());
    }
  }
}

String convertoString(int num) {
  switch (num) {
    case 1:
      return 'onestar';

      break;
    case 2:
      return 'twostar';
      break;

    case 3:
      return 'threestar';
      break;
    case 4:
      return 'fourstar';
      break;
    default:
      return 'fivestar';
      break;
  }
}
