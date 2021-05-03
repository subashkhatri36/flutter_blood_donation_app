import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:get/get.dart';

class PostsRepo {
  final repo = firebaseFirestore.collection('request');
  sendRequest(req) async {
    await repo
        .add(req.toJson())
        .then((value) => {print(value.id), Get.snackbar('Request', 'sent')})
        .catchError(
            // ignore: return_of_invalid_type_from_catch_error
            (onError) => {
                  print(onError.toString()),
                  Get.snackbar('Error', 'Failed to send request')
                });
  }

//get stream of request
  getRequest() {
    return repo
        .orderBy('timestamp', descending: true)

        //.limit(3)
        .snapshots()
        .map((QuerySnapshot query) {
      List<RequestModel> requests = [];
      query.docs.forEach((element) {
        print(element.data()['likes']);
        // if (element.data()['likes'] != null || element.data()['likes'] == null)
        //    firebaseFirestore
        //       .collection('likes')
        //       .doc(element.id)
        //       .update({'likes': jsonEncode([])});
        //print(element.id);
        requests.add(RequestModel.fromDocumentSnapshot(element));
      });

      return requests;
    });
  }
}

final postRepo = PostsRepo();
