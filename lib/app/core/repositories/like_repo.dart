
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_blood_donation_app/app/constant/const.dart';
// import 'package:flutter_blood_donation_app/app/core/model/comment_model.dart';


// class LikeRepo {
//   final repo = firebaseFirestore.collection('like');
//   sendComment( comm) async {
//     // print(comm.toJson().toString());
//     await repo.add(comm.toJson());
//     // await repo
//     //     .add(comm.toJson())
//     //     .then((value) => {print(value.id),// Get.snackbar('Request', 'sent')
//     //   })
//     //     .catchError(
//     //         // ignore: return_of_invalid_type_from_catch_error
//     //         (onError) => {
//     //               print(onError.toString()),
//     //             //  Get.snackbar('Error', 'Failed to send request')
//     //             });
//   }

// //get stream of comment
//   getComment(String postid) {
//     return repo
//      .where('postid',isEqualTo:postid)
//        // .orderBy('timestamp', descending: true)
//         .snapshots()
//         .map((QuerySnapshot query) {
//       List<CommentModel> requests = [];
//       query.docs.forEach((element) {
     
//         requests.add(CommentModel.fromJson(element.data()));
//       });

//       return requests;
//     });
//   }
// }

// final likeRepo = LikeRepo();
